import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/campus_data.dart';
import '../data/campus_map_geometry.dart';
import '../models/navigation.dart';
import '../models/place.dart';

class _CollegeMapFeature {
  final Offset center;
  final double width;
  final double length;
  final double rotationDeg;
  final String label;
  final String? placeId;
  final bool isGround;

  const _CollegeMapFeature({
    required this.center,
    required this.width,
    required this.length,
    required this.label,
    this.placeId,
    this.rotationDeg = 0,
    this.isGround = false,
  });
}

const _collegeMapFeatures = <_CollegeMapFeature>[
  _CollegeMapFeature(
    center: Offset(432, 188),
    width: 28,
    length: 20,
    rotationDeg: 18,
    label: 'Main Gate',
    placeId: 'main_gate',
  ),
  _CollegeMapFeature(
    center: Offset(534, 280),
    width: 200,
    length: 140,
    label: 'Main Block',
    placeId: 'main_block',
  ),
  _CollegeMapFeature(
    center: Offset(710, 298),
    width: 90,
    length: 52,
    label: 'Seminar Hall',
    placeId: 'seminar_hall',
  ),
  _CollegeMapFeature(
    center: Offset(792, 284),
    width: 84,
    length: 50,
    label: 'Library',
    placeId: 'library',
  ),
  _CollegeMapFeature(
    center: Offset(278, 268),
    width: 178,
    length: 190,
    label: 'Cricket Ground',
    isGround: true,
    placeId: 'cricket_ground',
  ),
  _CollegeMapFeature(
    center: Offset(738, 492),
    width: 240,
    length: 256,
    label: 'Sports Ground',
    isGround: true,
    placeId: 'stadium',
  ),
  _CollegeMapFeature(
    center: Offset(466, 418),
    width: 74,
    length: 62,
    label: 'Open Air Theatre',
    isGround: true,
    placeId: 'open_air_theatre',
  ),
  _CollegeMapFeature(
    center: Offset(368, 412),
    width: 88,
    length: 66,
    label: 'Canteen',
    placeId: 'canteen',
  ),
  _CollegeMapFeature(
    center: Offset(162, 432),
    width: 140,
    length: 96,
    rotationDeg: 20,
    label: 'Ladies Hostel',
    placeId: 'ladies_hostel',
  ),
  _CollegeMapFeature(
    center: Offset(514, 484),
    width: 100,
    length: 72,
    label: 'Hydraulic Machines Lab',
    placeId: 'hydraulic_lab',
  ),
  _CollegeMapFeature(
    center: Offset(480, 562),
    width: 102,
    length: 74,
    label: 'Heat Engines Lab',
    placeId: 'heat_engines_lab',
  ),
  _CollegeMapFeature(
    center: Offset(448, 652),
    width: 100,
    length: 74,
    label: 'PG Block',
    placeId: 'pg_block',
  ),
  _CollegeMapFeature(
    center: Offset(1020, 504),
    width: 130,
    length: 160,
    label: 'Hostels',
    placeId: 'mens_hostel',
  ),
  _CollegeMapFeature(
    center: Offset(330, 148),
    width: 60,
    length: 36,
    label: 'Parking Lot',
    placeId: 'parking_lot',
    isGround: true,
  ),
];
final _collegeMapNodePositions = <String, Offset>{
  // ── Key building nodes ────────────────────────────────────────────────────
  'node_gate':            const Offset(435, 140),
  'node_parking':         const Offset(386, 150),
  'node_statue':          const Offset(490, 200),
  'node_main_block':      const Offset(554, 310),
  'node_pool':            const Offset(638, 520),
  'node_campus_road_mid': const Offset(432, 352),
  'node_cricket':         const Offset(296, 156),
  'node_canteen':         const Offset(386, 436),
  'node_ladies_hostel':   const Offset(288, 484),
  'node_hydraulic_lab':   const Offset(536, 514),
  'node_heat_engines':    const Offset(476, 598),
  'node_ec_block':        const Offset(490, 670),
  'node_pg_block':        const Offset(524, 692),
  'node_stadium':         const Offset(810, 516),
  'node_hostels_road':    const Offset(966, 558),
  'node_mens_hostel':     const Offset(1010, 520),
  'rn_hs_s1':             const Offset(984, 620),

  // ── Main Kozhippilly Road ─────────────────────────────────────────────────
  'rn_main_r1': const Offset(60, 30),
  'rn_main_r2': const Offset(250, 82),
  'rn_main_r3': const Offset(435, 140),
  'rn_main_r4': const Offset(595, 190),
  'rn_main_r5': const Offset(775, 228),
  'rn_main_r6': const Offset(920, 228),
  'rn_main_r7': const Offset(1070, 196),

  // ── Gate access road ──────────────────────────────────────────────────────
  'rn_gate_1': const Offset(430, 175),
  'rn_gate_2': const Offset(422, 232),

  // ── Cricket loop road ─────────────────────────────────────────────────────
  'rn_cr_n':  const Offset(296, 156),
  'rn_cr_ne': const Offset(388, 192),
  'rn_cr_e':  const Offset(418, 256),
  'rn_cr_se': const Offset(400, 324),
  'rn_cr_s':  const Offset(320, 372),
  'rn_cr_sw': const Offset(232, 342),
  'rn_cr_w':  const Offset(202, 256),
  'rn_cr_nw': const Offset(254, 173),

  // ── West perimeter road ───────────────────────────────────────────────────
  'rn_wp_1': const Offset(196, 235),
  'rn_wp_2': const Offset(156, 306),
  'rn_wp_3': const Offset(118, 408),
  'rn_wp_4': const Offset(78, 454),

  // ── Ladies hostel access ──────────────────────────────────────────────────
  'rn_lh_1': const Offset(172, 416),
  'rn_lh_2': const Offset(228, 428),
  'rn_lh_3': const Offset(272, 464),

  // ── Inner campus spine ────────────────────────────────────────────────────
  'rn_sp_1': const Offset(420, 286),
  'rn_sp_2': const Offset(432, 352),
  'rn_sp_3': const Offset(456, 402),
  'rn_sp_4': const Offset(456, 462),
  'rn_sp_5': const Offset(450, 490),

  // ── Lab access road ───────────────────────────────────────────────────────
  'rn_lab_1':  const Offset(434, 542),
  'rn_lab_2':  const Offset(414, 594),
  'rn_lab_3':  const Offset(436, 648),
  'rn_lab_4':  const Offset(452, 670),
  'rn_lab_5':  const Offset(466, 718),
  'rn_lab_6':  const Offset(506, 752),
  'rn_lab_7':  const Offset(574, 752),
  'rn_lab_8':  const Offset(648, 728),
  'rn_lab_9':  const Offset(714, 696),
  'rn_lab_10': const Offset(756, 674),

  // ── South-west road ───────────────────────────────────────────────────────
  'rn_sw_1': const Offset(306, 494),
  'rn_sw_2': const Offset(310, 562),
  'rn_sw_3': const Offset(346, 628),
  'rn_sw_4': const Offset(418, 662),
  'rn_sw_5': const Offset(452, 670),

  // ── Stadium outer loop ────────────────────────────────────────────────────
  'rn_sol_n':  const Offset(808, 344),
  'rn_sol_ne': const Offset(864, 350),
  'rn_sol_e1': const Offset(916, 374),
  'rn_sol_e2': const Offset(952, 414),
  'rn_sol_e3': const Offset(972, 460),
  'rn_sol_e4': const Offset(978, 510),
  'rn_sol_se': const Offset(966, 558),
  'rn_sol_s1': const Offset(944, 604),
  'rn_sol_s2': const Offset(912, 644),
  'rn_sol_sw': const Offset(868, 672),
  'rn_sol_s3': const Offset(816, 686),
  'rn_sol_s4': const Offset(756, 684),
  'rn_sol_w1': const Offset(714, 670),
  'rn_sol_w2': const Offset(674, 642),
  'rn_sol_w3': const Offset(648, 606),
  'rn_sol_w4': const Offset(638, 564),
  'rn_sol_w5': const Offset(650, 476),
  'rn_sol_w6': const Offset(674, 438),
  'rn_sol_w7': const Offset(710, 406),
  'rn_sol_nw': const Offset(754, 376),

  // ── North stadium connector ───────────────────────────────────────────────
  'rn_nsc_1': const Offset(940, 258),
  'rn_nsc_2': const Offset(952, 336),
  'rn_nsc_3': const Offset(882, 298),
  'rn_nsc_4': const Offset(792, 288),
  'rn_nsc_5': const Offset(722, 318),
  'rn_nsc_6': const Offset(710, 370),

  // ── MACE Hostels Road ─────────────────────────────────────────────────────
  'rn_hr_1': const Offset(952, 348),
  'rn_hr_2': const Offset(980, 354),
  'rn_hr_3': const Offset(982, 402),
  'rn_hr_4': const Offset(978, 510),
  'rn_hr_5': const Offset(966, 558),
  'rn_hr_6': const Offset(950, 608),
  'rn_hr_7': const Offset(930, 658),
  'rn_hr_8': const Offset(916, 710),

  for (final place in CampusData.referencePlaces)
    place.walkwayNodeId: Offset(place.campusX * 1.179, place.campusY * 0.768),
};

enum MapStyleMode {
  collegeMap('College Map', Icons.map_rounded),
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
    this.styleMode = MapStyleMode.collegeMap,
    required this.onPlaceTapped,
    this.onPlaceLongPressed,
  });

  @override
  State<Campus3DMap> createState() => Campus3DMapState();
}

class Campus3DMapState extends State<Campus3DMap>
    with TickerProviderStateMixin {
  // Camera state
  double _camX = 589.5;
  double _camY = 384.0;
  double _zoom = 0.5;
  double _rotation = 0.0; // Radians
  double _tilt = 0.0;
  Size _viewportSize = Size.zero;
  bool _cameraInitialized = false;

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
    _animController.addListener(() {
      if (!mounted) return;
      setState(() {
        _camX = _animCamX.value;
        _camY = _animCamY.value;
        _zoom = _animZoom.value;
        _rotation = _animRotation.value;
      });
    });

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

  double get _coordinateYScale => 1.0;

  double get _overviewZoom {
    if (_viewportSize.isEmpty) {
      return 0.95;
    }
    return math
            .min(
              _viewportSize.width / 1179,
              _viewportSize.height / (768 * math.cos(_tilt)),
            )
            .clamp(0.25, 3.5) *
        0.98;
  }

  /// Reset camera to standard full campus overview
  void resetToCampusOverview() {
    _animateCameraTo(
      targetX: 589.5,
      targetY: 384.0,
      targetZoom: _overviewZoom,
      targetRot: 0.0,
    );
  }

  /// Smoothly fly camera to a specific place
  void animateToPlace(CampusPlace place) {
    final mapPosition = widget.styleMode == MapStyleMode.collegeMap
        ? _collegeMapFeatures
              .where((feature) => feature.placeId == place.id)
              .firstOrNull
              ?.center
        : null;
    _animateCameraTo(
      targetX: mapPosition?.dx ?? place.campusX,
      targetY: mapPosition?.dy ?? place.campusY,
      targetZoom: 1.55,
      targetRot: _rotation,
    );
  }

  /// Fit the camera view to show the entire active route
  void fitRoute(CampusRoute route) {
    if (route.pathNodes.isEmpty) return;
    final points = route.pathNodes
        .map(
          (node) => _collegeMapNodePositions[node.id] ?? Offset(node.x, node.y)
        )
        .toList();
    double minX = double.infinity;
    double maxX = -double.infinity;
    double minY = double.infinity;
    double maxY = -double.infinity;

    for (final point in points) {
      if (point.dx < minX) minX = point.dx;
      if (point.dx > maxX) maxX = point.dx;
      if (point.dy < minY) minY = point.dy;
      if (point.dy > maxY) maxY = point.dy;
    }

    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;
    final span = math.max(maxX - minX, (maxY - minY) * _coordinateYScale);
    final viewportSpan = _viewportSize.isEmpty
        ? 500.0
        : math.min(_viewportSize.width, _viewportSize.height) * 0.8;
    final targetZoom = (viewportSpan / (span + 120.0)).clamp(0.25, 1.8);

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
      targetZoom: (_zoom * 1.3).clamp(0.25, 3.5),
      targetRot: _rotation,
    );
  }

  /// Zoom out by a step
  void zoomOut() {
    _animateCameraTo(
      targetX: _camX,
      targetY: _camY,
      targetZoom: (_zoom / 1.3).clamp(0.25, 3.5),
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
      _tilt = _tilt > 0.2 ? 0.0 : 0.52;
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

      _camX = (_camX - unrotatedDx).clamp(
        0.0,
        1179.0,
      );
      _camY = (_camY - unrotatedDy / _coordinateYScale).clamp(
        0.0,
        768.0,
      );

      // Pinch zoom
      if (details.scale != 1.0) {
        _zoom = (_baseZoom * details.scale).clamp(0.25, 3.5);
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
    final campusTap = _screenToCampus(tapOffset, size);
    final campusTapX = campusTap.dx;
    final campusTapY = campusTap.dy;

    // Hit test against campus places
    CampusPlace? hitPlace;
    double minHitDist = double.infinity;

    for (final place in widget.places) {
      final mapBuilding = widget.styleMode == MapStyleMode.collegeMap
          ? _collegeMapFeatures
                .where((feature) => feature.placeId == place.id)
                .firstOrNull
          : null;
      final mapPosition = mapBuilding?.center;
      final placeX = mapPosition?.dx ?? place.campusX;
      final placeY = mapPosition?.dy ?? place.campusY;
      // Check distance to center
      final dist = math.sqrt(
        math.pow(placeX - campusTapX, 2) +
            math.pow((placeY - campusTapY) * _coordinateYScale, 2),
      );

      final radius = mapBuilding == null
          ? math.max(place.width, place.length) * 0.7
          : math.max(mapBuilding.width, mapBuilding.length) * 0.65;
      final labelLineCount = mapBuilding?.label.split('\n').length ?? 0;
      final labelFontSize = math.max(7.0, 10.5 * math.min(_zoom, 1.1));
      final labelHit =
          mapBuilding != null &&
          (Offset(
                        mapBuilding.center.dx,
                        mapBuilding.isGround
                            ? mapBuilding.center.dy
                            : mapBuilding.center.dy -
                                  mapBuilding.length * 0.5 -
                                  (labelLineCount * labelFontSize * 0.55 + 3) /
                                      (_zoom * math.cos(_tilt)),
                      ) -
                      campusTap)
                  .distance <=
              math.max(mapBuilding.width * 0.45, 22 / _zoom);
      if ((dist <= radius || labelHit) && dist < minHitDist) {
        minHitDist = dist;
        hitPlace = place;
      }
    }

    if (hitPlace != null) {
      widget.onPlaceTapped(hitPlace);
    }
  }

  Offset _screenToCampus(Offset screenPoint, Size size) {
    final dx = (screenPoint.dx - size.width / 2) / _zoom;
    final dy = (screenPoint.dy - size.height / 2) / _zoom;
    final unTiltedY = dy / math.cos(_tilt);
    final cosRot = math.cos(-_rotation);
    final sinRot = math.sin(-_rotation);
    return Offset(
      _camX + dx * cosRot - unTiltedY * sinRot,
      _camY + (dx * sinRot + unTiltedY * cosRot) / _coordinateYScale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _viewportSize = size;
        if (!_cameraInitialized && size.width > 0 && size.height > 0) {
          _cameraInitialized = true;
          _camX = 589.5;
            _camY = 384;
            _zoom = _overviewZoom;
        }

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
    final buildingTilt = 0.48;
    final screenY =
        centerY +
        (rotY * math.cos(tilt) - z * math.sin(buildingTilt) * 2.2) * zoom;

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
    _drawCollegeMap(canvas, size);
    if (activeRoute != null) {
      _drawNavigationRoute(canvas, size);
    }
    if (userLocationOffset != null) {
      _drawUserLocation(canvas, size);
    }
    if (selectedPlace != null) {
      _drawSelectedPin(canvas, size);
    }
  }
  void _drawCollegeMap(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFF8DBB5A), BlendMode.src);
    _drawCollegeGreenspace(canvas, size);
    _drawCollegeGrounds(canvas, size);
    _drawCollegeRoads(canvas, size);
    _drawCollegeBuildings(canvas, size);
    _drawCollegeMapLabels(canvas, size);
  }

  Path _mapPath(List<Offset> points, Size size, {bool close = false}) {
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final point = _project(points[i].dx, points[i].dy, 0, size);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    if (close) path.close();
    return path;
  }

  Path _smoothMapPath(List<Offset> points, Size size, {double z = 0}) {
    if (points.length < 3) return _mapPath(points, size);
    final closes =
        points.length > 3 && (points.first - points.last).distance < 0.01;
    final projected = (closes ? points.sublist(0, points.length - 1) : points)
        .map((point) => _project(point.dx, point.dy, z, size))
        .toList(growable: false);
    if (closes) {
      final firstMidpoint = Offset(
        (projected.last.dx + projected.first.dx) / 2,
        (projected.last.dy + projected.first.dy) / 2,
      );
      final path = Path()..moveTo(firstMidpoint.dx, firstMidpoint.dy);
      for (var i = 0; i < projected.length; i++) {
        final current = projected[i];
        final next = projected[(i + 1) % projected.length];
        final midpoint = Offset(
          (current.dx + next.dx) / 2,
          (current.dy + next.dy) / 2,
        );
        path.quadraticBezierTo(
          current.dx,
          current.dy,
          midpoint.dx,
          midpoint.dy,
        );
      }
      return path..close();
    }
    final path = Path()..moveTo(projected.first.dx, projected.first.dy);
    for (var i = 1; i < projected.length - 1; i++) {
      final current = projected[i];
      final next = projected[i + 1];
      final midpoint = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(current.dx, current.dy, midpoint.dx, midpoint.dy);
    }
    path.lineTo(projected.last.dx, projected.last.dy);
    return path;
  }

  void _drawCollegeGreenspace(Canvas canvas, Size size) {
    const treeColors = [
      Color(0xFF3A7A28),
      Color(0xFF4A8A35),
      Color(0xFF5A9940),
      Color(0xFF336B23),
      Color(0xFF428030),
    ];
    const highlights = [
      Color(0xFF72AA4A),
      Color(0xFF85BB58),
      Color(0xFF78AF50),
      Color(0xFF60993E),
      Color(0xFF8BBF55),
    ];
    const shadows = [
      Color(0xFF2A5C1A),
      Color(0xFF305220),
      Color(0xFF264A18),
      Color(0xFF3A6028),
      Color(0xFF2E5820),
    ];

    // Draw a dense grid of tree clusters matching the aerial reference image
    for (var row = 0; row < 31; row++) {
      for (var column = 0; column < 46; column++) {
        final seed = math.sin(column * 12.989 + row * 78.233);
        final x = 6.0 + column * 26 + math.sin(row * 4.3 + column) * 7;
        final y = 7.0 + row * 25 + math.cos(column * 2.7 + row) * 7;
        if (seed < 0.35 &&
            !_isNearMapBuilding(x, y) &&
            !_isNearRoad(x, y) &&
            !_isInGround(x, y) &&
            !_isNearMapLabel(x, y)) {
          final center = _project(x, y, 0, size);
          final radius = 6.5 + (math.cos(seed * 18).abs() * 5.0);
          final colorIndex = ((seed.abs() * treeColors.length).floor())
              .clamp(0, treeColors.length - 1)
              .toInt();

          // Dark shadow beneath the canopy
          canvas.drawCircle(
            center.translate(2.5 * zoom, 3.5 * zoom),
            radius * 1.15 * zoom,
            Paint()
              ..color = const Color(0x552A3E1E)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5),
          );

          // Main dark base canopy
          canvas.drawCircle(
            center.translate(-radius * 0.15 * zoom, radius * 0.1 * zoom),
            radius * zoom,
            Paint()..color = shadows[colorIndex],
          );

          // Mid-tone main foliage
          canvas.drawCircle(
            center,
            radius * 0.85 * zoom,
            Paint()..color = treeColors[colorIndex],
          );

          // Secondary foliage blob
          canvas.drawCircle(
            center.translate(radius * 0.4 * zoom, -radius * 0.15 * zoom),
            radius * 0.68 * zoom,
            Paint()..color = treeColors[(colorIndex + 1) % treeColors.length],
          );

          // Bright highlight crown
          canvas.drawCircle(
            center.translate(-radius * 0.22 * zoom, -radius * 0.32 * zoom),
            radius * 0.48 * zoom,
            Paint()..color = highlights[colorIndex],
          );

          // Small bright specular highlight
          canvas.drawCircle(
            center.translate(-radius * 0.28 * zoom, -radius * 0.38 * zoom),
            radius * 0.22 * zoom,
            Paint()..color = highlights[(colorIndex + 2) % highlights.length].withValues(alpha: 0.7),
          );
        }
      }
    }
  }


  bool _isNearMapBuilding(double x, double y) {
    final point = Offset(x, y);
    return CampusMapGeometry.buildings.any(
      (building) =>
          _isPointInPolygon(point, building.footprint) ||
          _distanceToPolygon(point, building.footprint) < 12,
    );
  }

  bool _isNearRoad(double x, double y) {
    final point = Offset(x, y);
    return CampusMapGeometry.roads.any((road) {
      for (var i = 0; i < road.points.length - 1; i++) {
        if (_distanceToSegment(point, road.points[i], road.points[i + 1]) <
            road.width / 2 + 10) {
          return true;
        }
      }
      return false;
    });
  }

  bool _isInGround(double x, double y) {
    return CampusMapGeometry.grounds.any((ground) {
      final dx = (x - ground.center.dx) / (ground.width / 2);
      final dy = (y - ground.center.dy) / (ground.height / 2);
      return dx * dx + dy * dy <= 1;
    });
  }

  bool _isNearMapLabel(double x, double y) {
    return CampusMapGeometry.labels.any(
      (label) =>
          (x - label.position.dx).abs() < 54 &&
          (y - label.position.dy).abs() < 17,
    );
  }

  bool _isPointInPolygon(Offset point, List<Offset> polygon) {
    var inside = false;
    for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final current = polygon[i];
      final previous = polygon[j];
      final crosses =
          (current.dy > point.dy) != (previous.dy > point.dy) &&
          point.dx <
              (previous.dx - current.dx) *
                      (point.dy - current.dy) /
                      (previous.dy - current.dy) +
                  current.dx;
      if (crosses) inside = !inside;
    }
    return inside;
  }

  double _distanceToSegment(Offset point, Offset start, Offset end) {
    final segment = end - start;
    final lengthSquared = segment.distanceSquared;
    if (lengthSquared == 0) return (point - start).distance;
    final projection =
        ((point - start).dx * segment.dx + (point - start).dy * segment.dy) /
        lengthSquared;
    final t = projection.clamp(0.0, 1.0);
    return (point - (start + segment * t)).distance;
  }

  double _distanceToPolygon(Offset point, List<Offset> polygon) {
    var distance = double.infinity;
    for (var i = 0; i < polygon.length; i++) {
      distance = math.min(
        distance,
        _distanceToSegment(
          point,
          polygon[i],
          polygon[(i + 1) % polygon.length],
        ),
      );
    }
    return distance;
  }

  void _drawCollegeGrounds(Canvas canvas, Size size) {
    for (final ground in CampusMapGeometry.grounds) {
      final path = _ellipseMapPath(
        ground.center,
        ground.width,
        ground.height,
        size,
      );
      switch (ground.style) {
        case CampusGroundStyle.athleticsTrack:
          // Outer running track (terracotta/tan)
          canvas.drawPath(path, Paint()..color = const Color(0xFFC8956A));
          final innerField = _ellipseMapPath(
            ground.center,
            ground.width - 28,
            ground.height - 28,
            size,
          );
          // Inner green field
          canvas.drawPath(innerField, Paint()..color = const Color(0xFF6DA83E));
          // Track lane lines
          for (final inset in [9.0, 18.0]) {
            canvas.drawPath(
              _ellipseMapPath(
                ground.center,
                ground.width - inset * 2,
                ground.height - inset * 2,
                size,
              ),
              Paint()
                ..color = Colors.white.withValues(alpha: 0.55)
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.2 * zoom,
            );
          }
          canvas.drawPath(
            innerField,
            Paint()
              ..color = const Color(0xFF4D7D2E)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.4 * zoom,
          );
          break;
        case CampusGroundStyle.cricket:
          canvas.drawPath(path, Paint()..color = const Color(0xFF78B045));
          canvas.drawPath(
            path,
            Paint()
              ..color = const Color(0xFFAACC70)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2 * zoom,
          );
          final pitch = _mapPath(
            const [
              Offset(290, 247),
              Offset(302, 247),
              Offset(302, 286),
              Offset(290, 286),
            ],
            size,
            close: true,
          );
          canvas.drawPath(pitch, Paint()..color = const Color(0xFFCCB880));
          break;
        case CampusGroundStyle.theatre:
          canvas.drawPath(path, Paint()..color = const Color(0xFFDDD3B8));
          for (final inset in [9.0, 18.0, 27.0]) {
            canvas.drawPath(
              _ellipseMapPath(
                ground.center,
                ground.width - inset * 2,
                ground.height - inset * 2,
                size,
              ),
              Paint()
                ..color = const Color(0xFFB0A38A)
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.5 * zoom,
            );
          }
          canvas.drawPath(
            _ellipseMapPath(
              ground.center,
              ground.width * 0.28,
              ground.height * 0.28,
              size,
            ),
            Paint()..color = const Color(0xFFC4BAA4),
          );
          break;
        case CampusGroundStyle.lawn:
          canvas.drawPath(path, Paint()..color = const Color(0xFF8DC258));
          canvas.drawPath(
            path,
            Paint()
              ..color = const Color(0xFFADD478)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.2 * zoom,
          );
          break;
      }
    }
  }

  Path _ellipseMapPath(Offset center, double width, double height, Size size) {
    final points = List<Offset>.generate(40, (index) {
      final angle = index * math.pi * 2 / 40;
      return Offset(
        center.dx + math.cos(angle) * width / 2,
        center.dy + math.sin(angle) * height / 2,
      );
    });
    return _mapPath(points, size, close: true);
  }

  void _drawCollegeRoads(Canvas canvas, Size size) {
    for (final road in CampusMapGeometry.roads) {
      final path = _smoothMapPath(road.points, size);
      final outline = Paint()
        ..color = const Color(0xFFD8D0BC)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (road.width + 6) * zoom
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final surface = Paint()
        ..color = const Color(0xFF6E7275)
        ..style = PaintingStyle.stroke
        ..strokeWidth = road.width * zoom
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas
        ..drawPath(path, outline)
        ..drawPath(path, surface);
    }

    final walkways = Paint()
      ..color = const Color(0xFFE7D8B8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 * zoom
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final pathPoints in const [
      <Offset>[Offset(411, 267), Offset(438, 290), Offset(460, 321)],
      <Offset>[Offset(430, 447), Offset(451, 430), Offset(470, 420)],
      <Offset>[Offset(274, 472), Offset(299, 484), Offset(344, 510)],
      <Offset>[Offset(594, 556), Offset(622, 555), Offset(656, 552)],
      <Offset>[Offset(977, 481), Offset(986, 486), Offset(995, 491)],
      <Offset>[Offset(558, 721), Offset(590, 731)],
    ]) {
      canvas.drawPath(_smoothMapPath(pathPoints, size), walkways);
    }
  }

  void _drawCollegeBuildings(Canvas canvas, Size size) {
    final buildings = List<CampusMapBuilding>.from(CampusMapGeometry.buildings)
      ..sort((a, b) => a.center.dy.compareTo(b.center.dy));
    for (final building in buildings) {
      _drawCollegeBuilding(canvas, size, building);
    }
  }

  void _drawCollegeBuilding(
    Canvas canvas,
    Size size,
    CampusMapBuilding building,
  ) {
    final ground = building.footprint
        .map((point) => _project(point.dx, point.dy, 0, size))
        .toList(growable: false);
    final roof = building.footprint
        .map((point) => _project(point.dx, point.dy, building.height, size))
        .toList(growable: false);
    final shadowOffset = Offset(4 * zoom, 5 * zoom);
    final shadow = Path()
      ..moveTo(
        ground.first.dx + shadowOffset.dx,
        ground.first.dy + shadowOffset.dy,
      );
    for (final point in ground.skip(1)) {
      shadow.lineTo(point.dx + shadowOffset.dx, point.dy + shadowOffset.dy);
    }
    shadow.close();
    canvas.drawPath(
      shadow,
      Paint()
        ..color = const Color(0x3D34402C)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    final hostel = building.hostel;
    final roofColor = hostel
        ? const Color(0xFFCC8050)
        : const Color(0xFFBF6B3A);
    for (var i = 0; i < building.footprint.length; i++) {
      final next = (i + 1) % building.footprint.length;
      final face = Path()
        ..moveTo(ground[i].dx, ground[i].dy)
        ..lineTo(ground[next].dx, ground[next].dy)
        ..lineTo(roof[next].dx, roof[next].dy)
        ..lineTo(roof[i].dx, roof[i].dy)
        ..close();
      canvas.drawPath(
        face,
        Paint()
          ..color = hostel
              ? (i.isEven ? const Color(0xFFF5EAE0) : const Color(0xFFE0CFBF))
              : (i.isEven ? const Color(0xFFF8F4EE) : const Color(0xFFE6DDD0)),
      );

      final edgeLength = (ground[next] - ground[i]).distance;
      final windowCount = (edgeLength / (11 * zoom)).floor().clamp(1, 5);
      for (var windowIndex = 0; windowIndex < windowCount; windowIndex++) {
        final along = (windowIndex + 1) / (windowCount + 1);
        final baseStart = Offset.lerp(ground[i], ground[next], along)!;
        final roofStart = Offset.lerp(roof[i], roof[next], along)!;
        final baseEnd = Offset.lerp(
          ground[i],
          ground[next],
          along + 0.18 / (windowCount + 1),
        )!;
        final roofEnd = Offset.lerp(
          roof[i],
          roof[next],
          along + 0.18 / (windowCount + 1),
        )!;
        final windowTop = Offset.lerp(baseStart, roofStart, 0.62)!;
        final windowTopEnd = Offset.lerp(baseEnd, roofEnd, 0.62)!;
        final windowBottom = Offset.lerp(baseStart, roofStart, 0.3)!;
        final windowBottomEnd = Offset.lerp(baseEnd, roofEnd, 0.3)!;
        final window = Path()
          ..moveTo(windowTop.dx, windowTop.dy)
          ..lineTo(windowTopEnd.dx, windowTopEnd.dy)
          ..lineTo(windowBottomEnd.dx, windowBottomEnd.dy)
          ..lineTo(windowBottom.dx, windowBottom.dy)
          ..close();
        canvas.drawPath(window, Paint()..color = const Color(0xFF718B8A));
        canvas.drawPath(
          window,
          Paint()
            ..color = const Color(0xFFD8D0BC)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.65 * zoom,
        );
      }
    }

    final top = Path()..moveTo(roof.first.dx, roof.first.dy);
    for (final point in roof.skip(1)) {
      top.lineTo(point.dx, point.dy);
    }
    top.close();
    canvas.drawShadow(top, const Color(0x33000000), 3 * zoom, false);
    final roofCenter =
        building.footprint.fold(Offset.zero, (sum, point) => sum + point) /
        building.footprint.length.toDouble();
    var covarianceX = 0.0;
    var covarianceY = 0.0;
    var covarianceXY = 0.0;
    for (final point in building.footprint) {
      final dx = point.dx - roofCenter.dx;
      final dy = point.dy - roofCenter.dy;
      covarianceX += dx * dx;
      covarianceY += dy * dy;
      covarianceXY += dx * dy;
    }
    final axisAngle =
        0.5 * math.atan2(2 * covarianceXY, covarianceX - covarianceY);
    final ridgeAxis = Offset(math.cos(axisAngle), math.sin(axisAngle));
    final ridgeAcross = Offset(-ridgeAxis.dy, ridgeAxis.dx);
    const ridgeHeight = 5.0;

    List<Offset> clipRoofSide(bool positiveSide) {
      final clipped = <Offset>[];
      for (var i = 0; i < building.footprint.length; i++) {
        final start = building.footprint[i];
        final end = building.footprint[(i + 1) % building.footprint.length];
        final startSide =
            (start - roofCenter).dx * ridgeAcross.dx +
            (start - roofCenter).dy * ridgeAcross.dy;
        final endSide =
            (end - roofCenter).dx * ridgeAcross.dx +
            (end - roofCenter).dy * ridgeAcross.dy;
        final startInside = positiveSide ? startSide >= 0 : startSide <= 0;
        final endInside = positiveSide ? endSide >= 0 : endSide <= 0;

        if (startInside) clipped.add(start);
        if (startInside != endInside) {
          clipped.add(
            Offset.lerp(start, end, startSide / (startSide - endSide))!,
          );
        }
      }
      return clipped;
    }

    for (final positiveSide in [false, true]) {
      final clippedFootprint = clipRoofSide(positiveSide);
      if (clippedFootprint.length < 3) continue;
      final roofSide = Path();
      for (var i = 0; i < clippedFootprint.length; i++) {
        final point = clippedFootprint[i];
        final across =
            (point - roofCenter).dx * ridgeAcross.dx +
            (point - roofCenter).dy * ridgeAcross.dy;
        final projected = _project(
          point.dx,
          point.dy,
          building.height + (across.abs() < 0.01 ? ridgeHeight : 0),
          size,
        );
        if (i == 0) {
          roofSide.moveTo(projected.dx, projected.dy);
        } else {
          roofSide.lineTo(projected.dx, projected.dy);
        }
      }
      roofSide.close();
      canvas.drawPath(
        roofSide,
        Paint()..color = _shadeColor(roofColor, positiveSide ? 0.82 : 1.12),
      );
      canvas.drawPath(
        roofSide,
        Paint()
          ..color = const Color(0xFF7A3C22).withValues(alpha: 0.65)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.85 * zoom,
      );
    }

    final ridgePoints = clipRoofSide(true).where((point) {
      final across =
          (point - roofCenter).dx * ridgeAcross.dx +
          (point - roofCenter).dy * ridgeAcross.dy;
      return across.abs() < 0.01;
    }).toList();
    if (ridgePoints.length >= 2) {
      final ridgeStart = _project(
        ridgePoints.first.dx,
        ridgePoints.first.dy,
        building.height + ridgeHeight,
        size,
      );
      final ridgeEnd = _project(
        ridgePoints.last.dx,
        ridgePoints.last.dy,
        building.height + ridgeHeight,
        size,
      );
      canvas.drawLine(
        ridgeStart,
        ridgeEnd,
        Paint()
          ..color = const Color(0xFFFFDDB5).withValues(alpha: 0.78)
          ..strokeWidth = 1.5 * zoom
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawCollegeMapLabels(Canvas canvas, Size size) {
    for (final label in CampusMapGeometry.labels) {
      if (!label.keyLabel && zoom < 0.9) continue;
      final fontSize = math.max(7.5, 9.5 * math.min(zoom, 1.15));
      final isKey = label.keyLabel;
      final text = TextPainter(
        text: TextSpan(
          text: label.text,
          style: TextStyle(
            color: const Color(0xFF1A1A1A),
            fontSize: fontSize,
            height: 1.1,
            fontWeight: isKey ? FontWeight.w800 : FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: math.max(70.0, 160 * math.min(zoom, 1.0)));

      final center = _project(label.position.dx, label.position.dy, 0, size);
      final pillW = text.width + 10 * zoom;
      final pillH = text.height + 6 * zoom;

      canvas
        ..save()
        ..translate(center.dx, center.dy)
        ..rotate(label.rotation);

      // White semi-transparent pill background
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: pillW,
            height: pillH,
          ),
          Radius.circular(5 * zoom),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.88),
      );

      // Subtle pill border
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: pillW,
            height: pillH,
          ),
          Radius.circular(5 * zoom),
        ),
        Paint()
          ..color = const Color(0xFFBBBBA8).withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8 * zoom,
      );

      text.paint(canvas, Offset(-text.width / 2, -text.height / 2));
      canvas.restore();
    }
  }

  // ---------------------------------------------------------------------------
  // 4. NAVIGATION ROUTE (Glowing animated path)
  // ---------------------------------------------------------------------------
  void _drawNavigationRoute(Canvas canvas, Size size) {
    final nodes = activeRoute!.pathNodes;
    if (nodes.length < 2) return;

    final routePoints = <Offset>[];
    for (int i = 0; i < nodes.length; i++) {
      final mapPosition = _collegeMapNodePositions[nodes[i].id];
      routePoints.add(
        Offset(mapPosition?.dx ?? nodes[i].x, mapPosition?.dy ?? nodes[i].y),
      );
    }
    final routePath = _smoothMapPath(routePoints, size, z: 1.0);

    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFF38BDF8)
          .withValues(alpha: 0.35 + 0.2 * pulseValue)
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
      final mapPosition = _collegeMapNodePositions[nodes[i].id];
      final pt = _project(
        mapPosition?.dx ?? nodes[i].x,
        mapPosition?.dy ?? nodes[i].y,
        1.2,
        size,
      );
      canvas.drawCircle(pt, 3.5 * zoom, dotPaint);
    }

    // Start Pin (Green)
    final startPosition = _collegeMapNodePositions[nodes.first.id];
    final startPt = _project(
      startPosition?.dx ?? nodes.first.x,
      startPosition?.dy ?? nodes.first.y,
      2.0,
      size,
    );
    _drawMarkerBadge(
      canvas: canvas,
      point: startPt,
      color: const Color(0xFF16A34A),
      label: 'START',
      icon: Icons.trip_origin_rounded,
    );

    // Dest Pin (Crimson)
    final destPosition = _collegeMapNodePositions[nodes.last.id];
    final destPt = _project(
      destPosition?.dx ?? nodes.last.x,
      destPosition?.dy ?? nodes.last.y,
      2.0,
      size,
    );
    _drawMarkerBadge(
      canvas: canvas,
      point: destPt,
      color: const Color(0xFFDC2626),
      label: 'DEST',
      icon: Icons.flag_rounded,
    );
  }

  // ---------------------------------------------------------------------------
  // 6. USER LOCATION PIN
  // ---------------------------------------------------------------------------
  void _drawUserLocation(Canvas canvas, Size size) {
    final location = userLocationOffset!;
    final mapLocation = Offset(location.dx * 1.179, location.dy * 0.768);
    final pt = _project(mapLocation.dx, mapLocation.dy, 1.5, size);

    // Outer pulse ring
    final pulsePaint = Paint()
      ..color = const Color(0xFF38BDF8)
          .withValues(alpha: 0.5 * (1.0 - pulseValue))
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
    final mapPosition = styleMode == MapStyleMode.collegeMap
        ? _collegeMapFeatures
              .where((feature) => feature.placeId == place.id)
              .firstOrNull
              ?.center
        : null;
    final pt = _project(
      mapPosition?.dx ?? place.campusX,
      mapPosition?.dy ?? place.campusY,
      place.height + 22.0,
      size,
    );

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
