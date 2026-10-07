import 'package:flutter/material.dart';
import 'place.dart';

/// A waypoint node on the campus walkway network
class WalkNode {
  final String id;
  final double x; // Campus X coordinate (0..1000)
  final double y; // Campus Y coordinate (0..1000)
  final double approxLat;
  final double approxLng;
  final String name;

  const WalkNode({
    required this.id,
    required this.x,
    required this.y,
    required this.approxLat,
    required this.approxLng,
    required this.name,
  });
}

/// An edge / path segment connecting two walkway nodes
class WalkEdge {
  final String fromId;
  final String toId;
  final double distanceMeters;
  final String pathName;
  final bool isAccessible;

  const WalkEdge({
    required this.fromId,
    required this.toId,
    required this.distanceMeters,
    this.pathName = 'Campus Walkway',
    this.isAccessible = true,
  });
}

/// A turn-by-turn navigation instruction
class RouteStep {
  final String instruction;
  final IconData icon;
  final double distanceMeters;
  final double x;
  final double y;

  const RouteStep({
    required this.instruction,
    required this.icon,
    required this.distanceMeters,
    required this.x,
    required this.y,
  });
}

/// A computed walking route between two campus locations
class CampusRoute {
  final CampusPlace startPlace;
  final CampusPlace destPlace;
  final List<WalkNode> pathNodes;
  final double totalDistanceMeters;
  final int estimatedMinutes;
  final List<RouteStep> steps;

  const CampusRoute({
    required this.startPlace,
    required this.destPlace,
    required this.pathNodes,
    required this.totalDistanceMeters,
    required this.estimatedMinutes,
    required this.steps,
  });
}
