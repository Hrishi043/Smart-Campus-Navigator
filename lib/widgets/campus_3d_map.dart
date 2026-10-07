import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/campus_data.dart';
import '../models/navigation.dart';
import '../models/place.dart';

enum MapStyleMode {
  architectural('3D Architecture', Icons.view_in_ar_rounded),
  satellite('Satellite Hybrid', Icons.satellite_alt_rounded),
  blueprint('Blueprint Dark', Icons.dark_mode_rounded);

  final String label;
  final IconData icon;
  const MapStyleMode(this.label, this.icon);
}

class Campus3DMap extends StatefulWidget {
  final List<CampusPlace> places;
  final CampusPlace? selectedPlace;
  final CampusRoute? activeRoute;
  final Offset? userLocationOffset;
  final MapStyleMode styleMode;
  final Function(CampusPlace place) onPlaceTapped;
  final Function(CampusPlace place)? onPlaceLongPressed;

  const Campus3DMap({
    super.key,
    required this.places,
    this.selectedPlace,
    this.activeRoute,
    this.userLocationOffset,
    this.styleMode = MapStyleMode.architectural,
    required this.onPlaceTapped,
    this.onPlaceLongPressed,
  });

  @override
  State<Campus3DMap> createState() => Campus3DMapState();
}

class Campus3DMapState extends State<Campus3DMap>
    with TickerProviderStateMixin {
  // Camera state
  double _camX = 520.0;
  double _camY = 480.0;
  double _zoom = 0.95;
  double _rotation = 0.0; // Radians
  double _tilt = 0.52; // ~30 degrees tilt for 3D oblique perspective

  // Animation controller for smooth camera moves
  late AnimationController _animController;
  late Animation<double> _animCamX;
  late Animation<double> _animCamY;
  late Animation<double> _animZoom;
  late Animation<double> _animRotation;

  // Pulse animation for route and selected pin
  late AnimationController _pulseController;

  // Gesture tracking
  Offset _lastFocalPoint = Offset.zero;
  double _baseZoom = 1.0;
  double _baseRotation = 0.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(Campus3DMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPlace != null &&
        widget.selectedPlace != oldWidget.selectedPlace) {
      animateToPlace(widget.selectedPlace!);
    } else if (widget.activeRoute != null &&
        widget.activeRoute != oldWidget.activeRoute) {
      fitRoute(widget.activeRoute!);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// Reset camera to standard full campus overview
  void resetToCampusOverview() {
    _animateCameraTo(
      targetX: 520.0,
      targetY: 480.0,
      targetZoom: 0.95,
      targetRot: 0.0,
    );
  }

  /// Smoothly fly camera to a specific place
  void animateToPlace(CampusPlace place) {
    _animateCameraTo(
      targetX: place.campusX,
      targetY: place.campusY,
      targetZoom: 1.55,
      targetRot: _rotation,
    );
  }

  /// Fit the camera view to show the entire active route
  void fitRoute(CampusRoute route) {
    if (route.pathNodes.isEmpty) return;
    double minX = double.infinity;
    double maxX = -double.infinity;
    double minY = double.infinity;
    double maxY = -double.infinity;

    for (final node in route.pathNodes) {
      if (node.x < minX) minX = node.x;
      if (node.x > maxX) maxX = node.x;
      if (node.y < minY) minY = node.y;
      if (node.y > maxY) maxY = node.y;
    }

    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;
    final span = math.max(maxX - minX, maxY - minY);
    final targetZoom = (500.0 / (span + 180.0)).clamp(0.8, 1.8);

    _animateCameraTo(
      targetX: centerX,
      targetY: centerY,
      targetZoom: targetZoom,
      targetRot: _rotation,
    );
  }

  /// Zoom in by a step
  void zoomIn() {
    _animateCameraTo(
      targetX: _camX,
      targetY: _camY,
      targetZoom: (_zoom * 1.3).clamp(0.5, 3.5),
      targetRot: _rotation,
    );
  }

  /// Zoom out by a step
  void zoomOut() {
    _animateCameraTo(
      targetX: _camX,
      targetY: _camY,
      targetZoom: (_zoom / 1.3).clamp(0.5, 3.5),
      targetRot: _rotation,
    );
  }

  /// Rotate 90 degrees clockwise
  void rotateClockwise() {
    _animateCameraTo(
      targetX: _camX,
      targetY: _camY,
      targetZoom: _zoom,
      targetRot: _rotation + (math.pi / 4),
    );
  }

  /// Toggle 3D tilt between oblique 3D and flatter 2D
  void toggleTilt() {
    setState(() {
      _tilt = _tilt > 0.2 ? 0.05 : 0.52;
    });
  }

  bool get is3DTilt => _tilt > 0.2;

  void _animateCameraTo({
    required double targetX,
    required double targetY,
    required double targetZoom,
    required double targetRot,
  }) {
    _animController.stop();

    _animCamX = Tween<double>(begin: _camX, end: targetX).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animCamY = Tween<double>(begin: _camY, end: targetY).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animZoom = Tween<double>(begin: _zoom, end: targetZoom).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animRotation = Tween<double>(begin: _rotation, end: targetRot).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );

    _animController.addListener(() {
      setState(() {
        _camX = _animCamX.value;
        _camY = _animCamY.value;
        _zoom = _animZoom.value;
        _rotation = _animRotation.value;
      });
    });

    _animController.forward(from: 0.0);
  }

  // Handle multi-touch gestures (Pan, Scale, Rotate)
  void _onScaleStart(ScaleStartDetails details) {
    _animController.stop();
    _lastFocalPoint = details.localFocalPoint;
    _baseZoom = _zoom;
    _baseRotation = _rotation;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Pan translation (accounting for current rotation)
      final delta = details.localFocalPoint - _lastFocalPoint;
      _lastFocalPoint = details.localFocalPoint;

      // Invert rotation and tilt to translate camera correctly in campus space
      final cosRot = math.cos(-_rotation);
      final sinRot = math.sin(-_rotation);

      final unrotatedDx = (delta.dx * cosRot - delta.dy * sinRot) / _zoom;
      final unrotatedDy =
          (delta.dx * sinRot + delta.dy * cosRot) / (_zoom * math.cos(_tilt));

      _camX = (_camX - unrotatedDx).clamp(100.0, 900.0);
      _camY = (_camY - unrotatedDy).clamp(100.0, 900.0);

      // Pinch zoom
      if (details.scale != 1.0) {
        _zoom = (_baseZoom * details.scale).clamp(0.5, 3.5);
      }

      // Two-finger twist rotation
      if (details.pointerCount >= 2 && details.rotation.abs() > 0.01) {
        _rotation = _baseRotation + details.rotation;
      }
    });
  }

  void _onTapUp(TapUpDetails details, Size size) {
    // Convert screen tap coordinate into campus plane (X, Y)
    final tapOffset = details.localPosition;
    final screenCenterX = size.width / 2;
    final screenCenterY = size.height / 2;

    final dx = (tapOffset.dx - screenCenterX) / _zoom;
    final dy = (tapOffset.dy - screenCenterY) / _zoom;

    // Invert tilt
    final unTiltedY = dy / math.cos(_tilt);

    // Invert rotation
    final cosRot = math.cos(-_rotation);
    final sinRot = math.sin(-_rotation);

    final campusTapX = _camX + (dx * cosRot - unTiltedY * sinRot);
    final campusTapY = _camY + (dx * sinRot + unTiltedY * cosRot);

    // Hit test against campus places
    CampusPlace? hitPlace;
    double minHitDist = double.infinity;

    for (final place in widget.places) {
      // Check distance to center
      final dist = math.sqrt(math.pow(place.campusX - campusTapX, 2) +
          math.pow(place.campusY - campusTapY, 2));

      final radius = math.max(place.width, place.length) * 0.7;
      if (dist <= radius && dist < minHitDist) {
        minHitDist = dist;
        hitPlace = place;
      }
    }

    if (hitPlace != null) {
      widget.onPlaceTapped(hitPlace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onTapUp: (details) => _onTapUp(details, size),
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _Campus3DMapPainter(
                  places: widget.places,
                  selectedPlace: widget.selectedPlace,
                  activeRoute: widget.activeRoute,
                  userLocationOffset: widget.userLocationOffset,
                  styleMode: widget.styleMode,
                  camX: _camX,
                  camY: _camY,
                  zoom: _zoom,
                  rotation: _rotation,
                  tilt: _tilt,
                  pulseValue: _pulseController.value,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// Custom 3D isometric & oblique projection painter for MACE Campus
class _Campus3DMapPainter extends CustomPainter {
  final List<CampusPlace> places;
  final CampusPlace? selectedPlace;
  final CampusRoute? activeRoute;
  final Offset? userLocationOffset;
  final MapStyleMode styleMode;
  final double camX;
  final double camY;
  final double zoom;
  final double rotation;
  final double tilt;
  final double pulseValue;

  _Campus3DMapPainter({
    required this.places,
    required this.selectedPlace,
    required this.activeRoute,
    required this.userLocationOffset,
    required this.styleMode,
    required this.camX,
    required this.camY,
    required this.zoom,
    required this.rotation,
    required this.tilt,
    required this.pulseValue,
  });

  /// Project a 3D campus point (x, y, z) into 2D screen coordinates
  Offset _project(double x, double y, double z, Size screenSize) {
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    // 1. Center relative to camera
    final relX = x - camX;
    final relY = y - camY;

    // 2. Rotate around camera
    final cosRot = math.cos(rotation);
    final sinRot = math.sin(rotation);
    final rotX = relX * cosRot - relY * sinRot;
    final rotY = relX * sinRot + relY * cosRot;

    // 3. Oblique 3D perspective projection
    // Elevation Z lifts vertically on screen
    final screenX = centerX + rotX * zoom;
    final screenY =
        centerY + (rotY * math.cos(tilt) - z * math.sin(tilt) * 2.2) * zoom;

    return Offset(screenX, screenY);
  }

  /// Depth sorting value: objects with higher projected rotY are in front
  double _getDepth(double x, double y) {
    final relX = x - camX;
    final relY = y - camY;
    final sinRot = math.sin(rotation);
    final cosRot = math.cos(rotation);
    return relX * sinRot + relY * cosRot;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background fill
    _drawCampusBackground(canvas, size);

    // 2. Campus roads & pedestrian walkways
    _drawRoadsAndPaths(canvas, size);

    // 3. Ground landmarks (Cricket Ground, Stadium, Swimming pool)
    _drawGroundLandmarks(canvas, size);

    // 4. Active navigation route
    if (activeRoute != null) {
      _drawNavigationRoute(canvas, size);
    }

    // 5. 3D Extruded Building Models & Landmarks (Depth sorted back-to-front)
    _draw3DBuildings(canvas, size);

    // 6. User Current Location Pin
    if (userLocationOffset != null) {
      _drawUserLocation(canvas, size);
    }

    // 7. Highlight pin on selected place
    if (selectedPlace != null) {
      _drawSelectedPin(canvas, size);
    }
  }

  // ---------------------------------------------------------------------------
  // 1. CAMPUS BACKGROUND
  // ---------------------------------------------------------------------------
  void _drawCampusBackground(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final isDark = styleMode == MapStyleMode.blueprint;

    final Paint bgPaint = Paint();
    if (isDark) {
      bgPaint.color = const Color(0xFF0F172A);
      canvas.drawRect(rect, bgPaint);

      // Technical blueprint grid
      final gridPaint = Paint()
        ..color = const Color(0xFF1E293B)
        ..strokeWidth = 1.0;
      const step = 40.0;
      for (double x = 0; x < size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
      for (double y = 0; y < size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    } else {
      // Natural campus greenery gradient
      bgPaint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: styleMode == MapStyleMode.satellite
            ? [const Color(0xFF2E4034), const Color(0xFF1E2D22)]
            : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
      ).createShader(rect);
      canvas.drawRect(rect, bgPaint);
    }

    // Campus boundary outline
    final tl = _project(50, 50, 0, size);
    final tr = _project(950, 50, 0, size);
    final br = _project(950, 950, 0, size);
    final bl = _project(50, 950, 0, size);

    final borderPath = Path()
      ..moveTo(tl.dx, tl.dy)
      ..lineTo(tr.dx, tr.dy)
      ..lineTo(br.dx, br.dy)
      ..lineTo(bl.dx, bl.dy)
      ..close();

    final borderPaint = Paint()
      ..color = isDark
          ? const Color(0xFF38BDF8).withValues(alpha: 0.25)
          : const Color(0xFF81C784).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(borderPath, borderPaint);
  }

  // ---------------------------------------------------------------------------
  // 2. ROADS & PATHS
  // ---------------------------------------------------------------------------
  void _drawRoadsAndPaths(Canvas canvas, Size size) {
    final isDark = styleMode == MapStyleMode.blueprint;

    // Campus roads (MACE Campus Rd, MA College Rd)
    final roadColor = isDark ? const Color(0xFF1E293B) : const Color(0xFF94A3B8);
    final pathColor = isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1);

    final roadPaint = Paint()
      ..color = roadColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 14.0 * zoom;

    final walkwayPaint = Paint()
      ..color = pathColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 7.0 * zoom;

    // Draw all walkway edges
    for (final edge in CampusData.campusWalkEdges) {
      final from = CampusData.campusWalkNodes[edge.fromId]!;
      final to = CampusData.campusWalkNodes[edge.toId]!;

      final p1 = _project(from.x, from.y, 0, size);
      final p2 = _project(to.x, to.y, 0, size);

      final isMajorRoad = edge.pathName.contains('Road') ||
          edge.pathName.contains('Drive') ||
          edge.pathName.contains('Avenue');

      canvas.drawLine(p1, p2, isMajorRoad ? roadPaint : walkwayPaint);
    }

    // Road dash lines for major campus roads
    final centerDashPaint = Paint()
      ..color = isDark ? const Color(0xFF0284C7) : Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * zoom;

    for (final edge in CampusData.campusWalkEdges) {
      if (edge.pathName.contains('Road') || edge.pathName.contains('Drive')) {
        final from = CampusData.campusWalkNodes[edge.fromId]!;
        final to = CampusData.campusWalkNodes[edge.toId]!;
        final p1 = _project(from.x, from.y, 0, size);
        final p2 = _project(to.x, to.y, 0, size);
        canvas.drawLine(p1, p2, centerDashPaint);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // 3. GROUND LANDMARKS (Cricket Ground, Stadium, Pool)
  // ---------------------------------------------------------------------------
  void _drawGroundLandmarks(Canvas canvas, Size size) {
    final isDark = styleMode == MapStyleMode.blueprint;

    // A. CRICKET GROUND (Oval turf)
    _drawCricketGround(canvas, size, isDark);

    // B. MAR ATHANASIUS COLLEGE STADIUM (400m Athletic Track + Field)
    _drawStadiumTrack(canvas, size, isDark);

    // C. SWIMMING POOL (Sunken blue basin)
    _drawSwimmingPool(canvas, size, isDark);
  }

  void _drawCricketGround(Canvas canvas, Size size, bool isDark) {
    const cx = 420.0;
    const cy = 440.0;
    const rx = 65.0;
    const ry = 85.0;

    // Draw oval perimeter
    final path = Path();
    for (int i = 0; i <= 36; i++) {
      final angle = (i * 2 * math.pi) / 36;
      final px = cx + rx * math.cos(angle);
      final py = cy + ry * math.sin(angle);
      final pt = _project(px, py, 0, size);
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();

    final fillPaint = Paint()
      ..color = isDark ? const Color(0xFF064E3B) : const Color(0xFF86EFAC)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    final borderPaint = Paint()
      ..color = isDark ? const Color(0xFF10B981) : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5 * zoom;
    canvas.drawPath(path, borderPaint);

    // Cricket Pitch Strip (rect in center)
    final p1 = _project(cx - 5, cy - 14, 0.5, size);
    final p2 = _project(cx + 5, cy - 14, 0.5, size);
    final p3 = _project(cx + 5, cy + 14, 0.5, size);
    final p4 = _project(cx - 5, cy + 14, 0.5, size);
    final pitchPath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p4.dx, p4.dy)
      ..close();
    final pitchPaint = Paint()..color = const Color(0xFFD97706);
    canvas.drawPath(pitchPath, pitchPaint);
  }

  void _drawStadiumTrack(Canvas canvas, Size size, bool isDark) {
    const cx = 720.0;
    const cy = 660.0;
    const rx = 70.0;
    const ry = 90.0;

    // Outer running track
    final trackPath = Path();
    for (int i = 0; i <= 36; i++) {
      final angle = (i * 2 * math.pi) / 36;
      final px = cx + rx * math.cos(angle);
      final py = cy + ry * math.sin(angle);
      final pt = _project(px, py, 0, size);
      if (i == 0) {
        trackPath.moveTo(pt.dx, pt.dy);
      } else {
        trackPath.lineTo(pt.dx, pt.dy);
      }
    }
    trackPath.close();

    final trackPaint = Paint()
      ..color = isDark ? const Color(0xFF7F1D1D) : const Color(0xFFDC2626)
      ..style = PaintingStyle.fill;
    canvas.drawPath(trackPath, trackPaint);

    // Inner green field
    final fieldPath = Path();
    for (int i = 0; i <= 36; i++) {
      final angle = (i * 2 * math.pi) / 36;
      final px = cx + (rx - 16) * math.cos(angle);
      final py = cy + (ry - 18) * math.sin(angle);
      final pt = _project(px, py, 0.5, size);
      if (i == 0) {
        fieldPath.moveTo(pt.dx, pt.dy);
      } else {
        fieldPath.lineTo(pt.dx, pt.dy);
      }
    }
    fieldPath.close();

    final fieldPaint = Paint()
      ..color = isDark ? const Color(0xFF047857) : const Color(0xFF4ADE80)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fieldPath, fieldPaint);

    // White lane line
    final lanePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2 * zoom;
    canvas.drawPath(trackPath, lanePaint);
    canvas.drawPath(fieldPath, lanePaint);
  }

  void _drawSwimmingPool(Canvas canvas, Size size, bool isDark) {
    const cx = 640.0;
    const cy = 390.0;
    const w = 30.0;
    const l = 20.0;

    // Sunken basin outline
    final p1 = _project(cx - w, cy - l, 0, size);
    final p2 = _project(cx + w, cy - l, 0, size);
    final p3 = _project(cx + w, cy + l, 0, size);
    final p4 = _project(cx - w, cy + l, 0, size);

    final poolDeckPath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p4.dx, p4.dy)
      ..close();

    final deckPaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    canvas.drawPath(poolDeckPath, deckPaint);

    // Water surface
    final waterP1 = _project(cx - w + 4, cy - l + 4, -2, size);
    final waterP2 = _project(cx + w - 4, cy - l + 4, -2, size);
    final waterP3 = _project(cx + w - 4, cy + l - 4, -2, size);
    final waterP4 = _project(cx - w + 4, cy + l - 4, -2, size);

    final waterPath = Path()
      ..moveTo(waterP1.dx, waterP1.dy)
      ..lineTo(waterP2.dx, waterP2.dy)
      ..lineTo(waterP3.dx, waterP3.dy)
      ..lineTo(waterP4.dx, waterP4.dy)
      ..close();

    final waterPaint = Paint()
      ..color = isDark ? const Color(0xFF0284C7) : const Color(0xFF38BDF8);
    canvas.drawPath(waterPath, waterPaint);
  }

  // ---------------------------------------------------------------------------
  // 4. NAVIGATION ROUTE (Glowing animated path)
  // ---------------------------------------------------------------------------
  void _drawNavigationRoute(Canvas canvas, Size size) {
    final nodes = activeRoute!.pathNodes;
    if (nodes.length < 2) return;

    final routePath = Path();
    for (int i = 0; i < nodes.length; i++) {
      final pt = _project(nodes[i].x, nodes[i].y, 1.0, size);
      if (i == 0) {
        routePath.moveTo(pt.dx, pt.dy);
      } else {
        routePath.lineTo(pt.dx, pt.dy);
      }
    }

    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.35 + 0.2 * pulseValue)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 12.0 * zoom;
    canvas.drawPath(routePath, glowPaint);

    // Core vibrant route line
    final corePaint = Paint()
      ..color = const Color(0xFF0284C7)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 5.0 * zoom;
    canvas.drawPath(routePath, corePaint);

    // Waypoint dots
    final dotPaint = Paint()..color = Colors.white;
    for (int i = 0; i < nodes.length; i++) {
      final pt = _project(nodes[i].x, nodes[i].y, 1.2, size);
      canvas.drawCircle(pt, 3.5 * zoom, dotPaint);
    }

    // Start Pin (Green)
    final startPt = _project(nodes.first.x, nodes.first.y, 2.0, size);
    _drawMarkerBadge(
      canvas: canvas,
      point: startPt,
      color: const Color(0xFF16A34A),
      label: 'START',
      icon: Icons.trip_origin_rounded,
    );

    // Dest Pin (Crimson)
    final destPt = _project(nodes.last.x, nodes.last.y, 2.0, size);
    _drawMarkerBadge(
      canvas: canvas,
      point: destPt,
      color: const Color(0xFFDC2626),
      label: 'DEST',
      icon: Icons.flag_rounded,
    );
  }

  // ---------------------------------------------------------------------------
  // 5. 3D BUILDING BLOCKS & MODELS
  // ---------------------------------------------------------------------------
  void _draw3DBuildings(Canvas canvas, Size size) {
    // Depth sort places back-to-front so closer buildings occlude background buildings
    final sortedPlaces = List<CampusPlace>.from(places)
      ..sort((a, b) => _getDepth(a.campusX, a.campusY)
          .compareTo(_getDepth(b.campusX, b.campusY)));

    for (final place in sortedPlaces) {
      if (place.isLandmark &&
          (place.id == 'cricket_ground' ||
              place.id == 'stadium' ||
              place.id == 'swimming_pool')) {
        // Already drawn as ground landmarks; only draw floating label
        _drawBuildingLabel(canvas, size, place, 8.0);
        continue;
      }

      if (place.id == 'statue') {
        _drawStatue3D(canvas, size, place);
      } else {
        _drawBuildingBlock3D(canvas, size, place);
      }
    }
  }

  /// Render 3D extruded rectangular building block with realistic faces & roof
  void _drawBuildingBlock3D(Canvas canvas, Size size, CampusPlace place) {
    final cx = place.campusX;
    final cy = place.campusY;
    final hw = place.width / 2;
    final hl = place.length / 2;
    final h = place.height;
    final isDark = styleMode == MapStyleMode.blueprint;
    final isSelected = selectedPlace?.id == place.id;

    // Local building rotation angle
    final rotRad = place.rotationDeg * (math.pi / 180.0);
    final cosB = math.cos(rotRad);
    final sinB = math.sin(rotRad);

    // 4 base corners in local orientation
    Offset localCorner(double dx, double dy) {
      final rx = dx * cosB - dy * sinB;
      final ry = dx * sinB + dy * cosB;
      return Offset(cx + rx, cy + ry);
    }

    final c0 = localCorner(-hw, -hl); // Back-left
    final c1 = localCorner(hw, -hl); // Back-right
    final c2 = localCorner(hw, hl); // Front-right
    final c3 = localCorner(-hw, hl); // Front-left

    // Ground projection (Z = 0)
    final g0 = _project(c0.dx, c0.dy, 0, size);
    final g1 = _project(c1.dx, c1.dy, 0, size);
    final g2 = _project(c2.dx, c2.dy, 0, size);
    final g3 = _project(c3.dx, c3.dy, 0, size);

    // Roof projection (Z = h)
    final r0 = _project(c0.dx, c0.dy, h, size);
    final r1 = _project(c1.dx, c1.dy, h, size);
    final r2 = _project(c2.dx, c2.dy, h, size);
    final r3 = _project(c3.dx, c3.dy, h, size);

    // 1. Soft ground drop-shadow
    final shadowOffset = Offset(6 * zoom, 8 * zoom);
    final shadowPath = Path()
      ..moveTo(g0.dx + shadowOffset.dx, g0.dy + shadowOffset.dy)
      ..lineTo(g1.dx + shadowOffset.dx, g1.dy + shadowOffset.dy)
      ..lineTo(g2.dx + shadowOffset.dx, g2.dy + shadowOffset.dy)
      ..lineTo(g3.dx + shadowOffset.dx, g3.dy + shadowOffset.dy)
      ..close();
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);
    canvas.drawPath(shadowPath, shadowPaint);

    // 2. Wall faces
    // Define the 4 wall quadrilaterals:
    // Wall 0: c0 -> c1 (North wall)
    // Wall 1: c1 -> c2 (East wall)
    // Wall 2: c2 -> c3 (South wall)
    // Wall 3: c3 -> c0 (West wall)
    final wallCorners = [
      [c0, c1, g0, g1, r0, r1],
      [c1, c2, g1, g2, r1, r2],
      [c2, c3, g2, g3, r2, r3],
      [c3, c0, g3, g0, r3, r0],
    ];

    final baseWallColor = isDark ? const Color(0xFF1E293B) : place.wallColor;

    for (int i = 0; i < 4; i++) {
      final info = wallCorners[i];
      final ptG_A = info[2];
      final ptG_B = info[3];
      final ptR_A = info[4];
      final ptR_B = info[5];

      // Calculate 2D screen cross product to check if face is camera-facing
      final cross = (ptG_B.dx - ptG_A.dx) * (ptR_A.dy - ptG_A.dy) -
          (ptG_B.dy - ptG_A.dy) * (ptR_A.dx - ptG_A.dx);

      if (cross > 0) {
        // Face is visible to camera!
        final wallPath = Path()
          ..moveTo(ptG_A.dx, ptG_A.dy)
          ..lineTo(ptG_B.dx, ptG_B.dy)
          ..lineTo(ptR_B.dx, ptR_B.dy)
          ..lineTo(ptR_A.dx, ptR_A.dy)
          ..close();

        // Directional lighting: vary brightness by face orientation
        final shadeFactor = (i == 1 || i == 2) ? 0.82 : 0.95;
        final wallPaint = Paint()
          ..color = _shadeColor(baseWallColor, shadeFactor)
          ..style = PaintingStyle.fill;
        canvas.drawPath(wallPath, wallPaint);

        // Wall edge stroke
        final wallEdgePaint = Paint()
          ..color = isDark ? const Color(0xFF38BDF8).withValues(alpha: 0.3) : Colors.black26
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawPath(wallPath, wallEdgePaint);
      }
    }

    // 3. Roof surface polygon
    final roofPath = Path()
      ..moveTo(r0.dx, r0.dy)
      ..lineTo(r1.dx, r1.dy)
      ..lineTo(r2.dx, r2.dy)
      ..lineTo(r3.dx, r3.dy)
      ..close();

    final roofColor = isDark
        ? const Color(0xFF0F766E)
        : (isSelected ? const Color(0xFFF59E0B) : place.roofColor);

    final roofPaint = Paint()
      ..color = roofColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(roofPath, roofPaint);

    final roofBorderPaint = Paint()
      ..color = isSelected ? Colors.amberAccent : Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = (isSelected ? 2.8 : 1.2) * zoom;
    canvas.drawPath(roofPath, roofBorderPaint);

    // 4. Rooftop Label Banner
    _drawBuildingLabel(canvas, size, place, h + 8.0);
  }

  /// Render 3D Statue Landmark
  void _drawStatue3D(Canvas canvas, Size size, CampusPlace place) {
    final cx = place.campusX;
    final cy = place.campusY;
    const h = 18.0;

    // Pedestal base
    final p0 = _project(cx - 12, cy - 12, 0, size);
    final p1 = _project(cx + 12, cy - 12, 0, size);
    final p2 = _project(cx + 12, cy + 12, 0, size);
    final p3 = _project(cx - 12, cy + 12, 0, size);

    final basePt = _project(cx, cy, 0, size);
    final midPt = _project(cx, cy, h * 0.6, size);
    final topPt = _project(cx, cy, h, size);

    // Pedestal circle
    final basePaint = Paint()..color = const Color(0xFFCBD5E1);
    canvas.drawCircle(basePt, 14.0 * zoom, basePaint);

    // Column
    final colPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 6.0 * zoom
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(basePt, midPt, colPaint);

    // Statue Bust / Figure
    final bustPaint = Paint()..color = const Color(0xFFD97706);
    canvas.drawCircle(topPt, 6.0 * zoom, bustPaint);

    // Label
    _drawBuildingLabel(canvas, size, place, h + 10.0);
  }

  /// Draw floating billboard label above building
  void _drawBuildingLabel(
    Canvas canvas,
    Size size,
    CampusPlace place,
    double elevationZ,
  ) {
    if (zoom < 0.72) return; // Hide labels at far zoom to reduce clutter

    final labelPt = _project(place.campusX, place.campusY, elevationZ, size);
    final isSelected = selectedPlace?.id == place.id;

    final text = place.shortCode;
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: isSelected ? Colors.black : Colors.white,
        fontSize: math.max(9.0, 10.0 * zoom),
        fontWeight: FontWeight.bold,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    final paddingH = 6.0 * zoom;
    final paddingV = 3.0 * zoom;
    final badgeWidth = textPainter.width + paddingH * 2;
    final badgeHeight = textPainter.height + paddingV * 2;

    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: labelPt,
        width: badgeWidth,
        height: badgeHeight,
      ),
      const Radius.circular(6.0),
    );

    final bgPaint = Paint()
      ..color = isSelected
          ? Colors.amberAccent
          : place.category.color.withValues(alpha: 0.92)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(badgeRect, bgPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(badgeRect, borderPaint);

    textPainter.paint(
      canvas,
      Offset(labelPt.dx - textPainter.width / 2,
          labelPt.dy - textPainter.height / 2),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. USER LOCATION PIN
  // ---------------------------------------------------------------------------
  void _drawUserLocation(Canvas canvas, Size size) {
    final pt =
        _project(userLocationOffset!.dx, userLocationOffset!.dy, 1.5, size);

    // Outer pulse ring
    final pulsePaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.5 * (1.0 - pulseValue))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 * zoom;
    canvas.drawCircle(pt, (12.0 + 16.0 * pulseValue) * zoom, pulsePaint);

    // Inner bright blue dot
    final corePaint = Paint()..color = const Color(0xFF0284C7);
    canvas.drawCircle(pt, 8.0 * zoom, corePaint);

    final whiteBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5 * zoom;
    canvas.drawCircle(pt, 8.0 * zoom, whiteBorderPaint);
  }

  // ---------------------------------------------------------------------------
  // 7. SELECTED PLACE PIN & HIGHLIGHT
  // ---------------------------------------------------------------------------
  void _drawSelectedPin(Canvas canvas, Size size) {
    final place = selectedPlace!;
    final pt = _project(place.campusX, place.campusY, place.height + 22.0, size);

    // Floating golden beacon pin
    final beaconPaint = Paint()
      ..color = Colors.amber.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pt, 12.0 * zoom, beaconPaint);

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.location_pin.codePoint),
        style: TextStyle(
          fontSize: 22.0 * zoom,
          fontFamily: Icons.location_pin.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    iconPainter.paint(
      canvas,
      Offset(pt.dx - iconPainter.width / 2, pt.dy - iconPainter.height / 2),
    );
  }

  void _drawMarkerBadge({
    required Canvas canvas,
    required Offset point,
    required Color color,
    required String label,
    required IconData icon,
  }) {
    final paint = Paint()..color = color;
    canvas.drawCircle(point, 9.0 * zoom, paint);

    final whiteBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 * zoom;
    canvas.drawCircle(point, 9.0 * zoom, whiteBorder);
  }

  Color _shadeColor(Color color, double factor) {
    return Color.fromARGB(
      color.alpha,
      (color.red * factor).clamp(0, 255).toInt(),
      (color.green * factor).clamp(0, 255).toInt(),
      (color.blue * factor).clamp(0, 255).toInt(),
    );
  }

  @override
  bool shouldRepaint(covariant _Campus3DMapPainter oldDelegate) {
    return oldDelegate.camX != camX ||
        oldDelegate.camY != camY ||
        oldDelegate.zoom != zoom ||
        oldDelegate.rotation != rotation ||
        oldDelegate.tilt != tilt ||
        oldDelegate.selectedPlace != selectedPlace ||
        oldDelegate.activeRoute != activeRoute ||
        oldDelegate.userLocationOffset != userLocationOffset ||
        oldDelegate.styleMode != styleMode ||
        oldDelegate.pulseValue != pulseValue;
  }
}
