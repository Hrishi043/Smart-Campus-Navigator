import 'dart:collection';
import 'package:flutter/material.dart';
import '../data/campus_data.dart';
import '../models/navigation.dart';
import '../models/place.dart';

class PathfindingService {
  PathfindingService._();
  static final PathfindingService instance = PathfindingService._();

  /// Build adjacency list for Dijkstra pathfinding
  Map<String, List<WalkEdge>> _buildGraph() {
    final graph = <String, List<WalkEdge>>{};
    for (final node in CampusData.campusWalkNodes.values) {
      graph[node.id] = [];
    }

    for (final edge in CampusData.campusWalkEdges) {
      // Walkways are bidirectional
      graph[edge.fromId]?.add(edge);
      graph[edge.toId]?.add(WalkEdge(
        fromId: edge.toId,
        toId: edge.fromId,
        distanceMeters: edge.distanceMeters,
        pathName: edge.pathName,
        isAccessible: edge.isAccessible,
      ));
    }
    return graph;
  }

  /// Find shortest walking route between two campus places
  CampusRoute? findRoute({
    required CampusPlace startPlace,
    required CampusPlace destPlace,
  }) {
    if (startPlace.id == destPlace.id) {
      final startNode = CampusData.campusWalkNodes[startPlace.walkwayNodeId]!;
      return CampusRoute(
        startPlace: startPlace,
        destPlace: destPlace,
        pathNodes: [startNode],
        totalDistanceMeters: 0,
        estimatedMinutes: 0,
        steps: [
          RouteStep(
            instruction: 'You are already at ${destPlace.name}',
            icon: Icons.check_circle_rounded,
            distanceMeters: 0,
            x: startNode.x,
            y: startNode.y,
          ),
        ],
      );
    }

    final startNodeId = startPlace.walkwayNodeId;
    final destNodeId = destPlace.walkwayNodeId;

    final pathNodeIds = _runDijkstra(startNodeId, destNodeId);
    if (pathNodeIds == null || pathNodeIds.isEmpty) {
      return null;
    }

    final pathNodes = pathNodeIds
        .map((id) => CampusData.campusWalkNodes[id]!)
        .toList();

    // Calculate total distance and construct step-by-step instructions
    double totalDistance = 0;
    final steps = <RouteStep>[];

    steps.add(RouteStep(
      instruction: 'Start from ${startPlace.name}',
      icon: Icons.trip_origin_rounded,
      distanceMeters: 0,
      x: pathNodes.first.x,
      y: pathNodes.first.y,
    ));

    for (int i = 0; i < pathNodes.length - 1; i++) {
      final from = pathNodes[i];
      final to = pathNodes[i + 1];

      // Find edge for path name & distance
      final edge = CampusData.campusWalkEdges.firstWhere(
        (e) =>
            (e.fromId == from.id && e.toId == to.id) ||
            (e.fromId == to.id && e.toId == from.id),
        orElse: () => WalkEdge(
          fromId: from.id,
          toId: to.id,
          distanceMeters: _euclideanDistance(from, to),
          pathName: 'Campus Pathway',
        ),
      );

      totalDistance += edge.distanceMeters;

      // Determine heading icon based on vector
      final dx = to.x - from.x;
      final dy = to.y - from.y;
      IconData icon = Icons.straight_rounded;
      if (dx.abs() > dy.abs()) {
        icon = dx > 0 ? Icons.turn_right_rounded : Icons.turn_left_rounded;
      } else {
        icon = dy > 0 ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;
      }

      steps.add(RouteStep(
        instruction: 'Walk along ${edge.pathName} towards ${to.name} (${edge.distanceMeters.round()} m)',
        icon: icon,
        distanceMeters: edge.distanceMeters,
        x: to.x,
        y: to.y,
      ));
    }

    steps.add(RouteStep(
      instruction: 'Arrive at ${destPlace.name}',
      icon: Icons.location_on_rounded,
      distanceMeters: 0,
      x: pathNodes.last.x,
      y: pathNodes.last.y,
    ));

    // Average walking speed ~ 1.2 m/s -> ~72 m/min
    final estimatedMinutes = (totalDistance / 72.0).ceil().clamp(1, 60);

    return CampusRoute(
      startPlace: startPlace,
      destPlace: destPlace,
      pathNodes: pathNodes,
      totalDistanceMeters: totalDistance,
      estimatedMinutes: estimatedMinutes,
      steps: steps,
    );
  }

  /// Dijkstra algorithm implementation
  List<String>? _runDijkstra(String startId, String targetId) {
    final graph = _buildGraph();
    final distances = <String, double>{};
    final previous = <String, String?>{};
    final queue = SplayTreeSet<String>((a, b) {
      final cmp = (distances[a] ?? double.infinity)
          .compareTo(distances[b] ?? double.infinity);
      return cmp != 0 ? cmp : a.compareTo(b);
    });

    for (final node in CampusData.campusWalkNodes.values) {
      distances[node.id] = node.id == startId ? 0.0 : double.infinity;
      previous[node.id] = null;
      queue.add(node.id);
    }

    while (queue.isNotEmpty) {
      final current = queue.first;
      queue.remove(current);

      if (current == targetId) break;

      final currentDist = distances[current] ?? double.infinity;
      if (currentDist == double.infinity) break;

      final neighbors = graph[current] ?? [];
      for (final edge in neighbors) {
        final neighbor = edge.toId;
        final alt = currentDist + edge.distanceMeters;

        if (alt < (distances[neighbor] ?? double.infinity)) {
          queue.remove(neighbor);
          distances[neighbor] = alt;
          previous[neighbor] = current;
          queue.add(neighbor);
        }
      }
    }

    if (distances[targetId] == double.infinity) return null;

    final path = <String>[];
    String? curr = targetId;
    while (curr != null) {
      path.insert(0, curr);
      curr = previous[curr];
    }
    return path;
  }

  double _euclideanDistance(WalkNode a, WalkNode b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    // Normalized campus coordinates are roughly ~0.8m per unit
    return (dx * dx + dy * dy) * 0.8;
  }

  /// Find nearest walkway node to canvas coordinates
  WalkNode findNearestNode(double x, double y) {
    WalkNode nearest = CampusData.campusWalkNodes.values.first;
    double minDistance = double.infinity;

    for (final node in CampusData.campusWalkNodes.values) {
      final dist = (node.x - x) * (node.x - x) + (node.y - y) * (node.y - y);
      if (dist < minDistance) {
        minDistance = dist;
        nearest = node;
      }
    }
    return nearest;
  }
}
