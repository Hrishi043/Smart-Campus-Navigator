import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/campus_data.dart';
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
    center: Offset(82, 134),
    width: 24,
    length: 18,
    rotationDeg: 18,
    label: 'Main Gate',
    placeId: 'main_gate',
  ),
  _CollegeMapFeature(
    center: Offset(648, 328),
    width: 76,
    length: 56,
    rotationDeg: 22,
    label: 'Ma College of Engineering\nMain Block',
    placeId: 'main_block',
  ),
  _CollegeMapFeature(
    center: Offset(601, 285),
    width: 13,
    length: 13,
    label: 'Statue',
    placeId: 'statue',
  ),
  _CollegeMapFeature(
    center: Offset(574, 625),
    width: 92,
    length: 48,
    rotationDeg: 25,
    label: 'Electronics & Communication\nDepartment Mace',
    placeId: 'ec_block',
  ),
  _CollegeMapFeature(
    center: Offset(535, 380),
    width: 42,
    length: 27,
    rotationDeg: 25,
    label: 'Mechanical\nMeasurements Lab',
    placeId: 'hydraulic_lab',
  ),
  _CollegeMapFeature(
    center: Offset(707, 510),
    width: 62,
    length: 35,
    rotationDeg: 24,
    label: 'Mechanical Labs',
    placeId: 'heat_engines_lab',
  ),
  _CollegeMapFeature(
    center: Offset(537, 552),
    width: 46,
    length: 27,
    rotationDeg: 24,
    label: 'Electrical Lab',
    placeId: 'pg_block',
  ),
  _CollegeMapFeature(
    center: Offset(391, 471),
    width: 52,
    length: 33,
    rotationDeg: 25,
    label: 'Ladies Hostel\nMar Athanasius College of Engineering',
    placeId: 'ladies_hostel',
  ),
  _CollegeMapFeature(
    center: Offset(1094, 476),
    width: 48,
    length: 34,
    label: 'HSII Hostel',
    placeId: 'mens_hostel',
  ),
  _CollegeMapFeature(
    center: Offset(543, 466),
    width: 42,
    length: 29,
    rotationDeg: 24,
    label: 'Ootupura Canteen',
    placeId: 'canteen',
  ),
  _CollegeMapFeature(
    center: Offset(624, 47),
    width: 70,
    length: 42,
    rotationDeg: 12,
    label: 'Students Centre\nMA College',
  ),
  _CollegeMapFeature(
    center: Offset(712, 128),
    width: 34,
    length: 22,
    rotationDeg: 28,
    label: 'Chapel',
  ),
  _CollegeMapFeature(
    center: Offset(590, 222),
    width: 66,
    length: 48,
    rotationDeg: 30,
    label: 'Mace Tennis\nCourt',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(726, 233),
    width: 56,
    length: 43,
    rotationDeg: 20,
    label: 'Mace Botanical\nGarden',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(766, 277),
    width: 96,
    length: 48,
    rotationDeg: 20,
    label: 'Mace 4’s\nFootball Ground',
    isGround: true,
    placeId: 'cricket_ground',
  ),
  _CollegeMapFeature(
    center: Offset(885, 333),
    width: 56,
    length: 34,
    rotationDeg: -18,
    label: 'Swimming Pool\nMa College',
    isGround: true,
    placeId: 'swimming_pool',
  ),
  _CollegeMapFeature(
    center: Offset(579, 389),
    width: 38,
    length: 26,
    rotationDeg: 24,
    label: 'Geotech Lab',
  ),
  _CollegeMapFeature(
    center: Offset(694, 390),
    width: 45,
    length: 34,
    rotationDeg: 22,
    label: 'PTA Seminar\nHall 2',
  ),
  _CollegeMapFeature(
    center: Offset(810, 379),
    width: 52,
    length: 28,
    rotationDeg: 24,
    label: 'Training and\nPlacement Cell',
  ),
  _CollegeMapFeature(
    center: Offset(633, 436),
    width: 55,
    length: 36,
    rotationDeg: 20,
    label: 'Open Air Theatre',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(713, 622),
    width: 42,
    length: 34,
    rotationDeg: 22,
    label: 'MCA Block',
  ),
  _CollegeMapFeature(
    center: Offset(676, 648),
    width: 34,
    length: 24,
    rotationDeg: 20,
    label: 'MACE Fab Lab',
  ),
  _CollegeMapFeature(
    center: Offset(631, 692),
    width: 45,
    length: 29,
    rotationDeg: 24,
    label: 'Material\nTesting Lab',
  ),
  _CollegeMapFeature(
    center: Offset(856, 555),
    width: 205,
    length: 242,
    label: 'MH Ground',
    isGround: true,
    placeId: 'stadium',
  ),
  _CollegeMapFeature(
    center: Offset(856, 588),
    width: 185,
    length: 205,
    label: 'MAR Athanasius\nCollege Ground',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(982, 570),
    width: 42,
    length: 31,
    label: 'Kennedy Hostel',
  ),
  _CollegeMapFeature(
    center: Offset(1017, 618),
    width: 38,
    length: 26,
    label: 'Hostel Mess',
  ),
  _CollegeMapFeature(
    center: Offset(1086, 644),
    width: 44,
    length: 30,
    label: 'Diamond Jubilee\nDJ Hostel',
  ),
  _CollegeMapFeature(
    center: Offset(940, 679),
    width: 43,
    length: 30,
    label: 'MB Hostel MACE',
  ),
  _CollegeMapFeature(
    center: Offset(166, 626),
    width: 35,
    length: 25,
    label: 'Amrutha\nHomely Food',
  ),
  _CollegeMapFeature(
    center: Offset(309, 636),
    width: 29,
    length: 23,
    label: 'Chillam',
  ),
  _CollegeMapFeature(
    center: Offset(369, 687),
    width: 36,
    length: 26,
    label: 'Thaavalam',
  ),
  _CollegeMapFeature(
    center: Offset(608, 159),
    width: 43,
    length: 36,
    label: 'NSS Park',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(962, 89),
    width: 112,
    length: 183,
    label: 'Mar Athanasius\nInternational School',
    isGround: true,
  ),
  _CollegeMapFeature(
    center: Offset(1080, 118),
    width: 150,
    length: 180,
    label: 'MA International\nSchool Ground',
    isGround: true,
  ),
];

const _collegeMapNodePositions = <String, Offset>{
  'node_gate': Offset(82, 134),
  'node_parking': Offset(517, 164),
  'node_statue': Offset(601, 285),
  'node_main_block': Offset(648, 328),
  'node_pool': Offset(885, 333),
  'node_campus_road_mid': Offset(567, 399),
  'node_cricket': Offset(766, 277),
  'node_canteen': Offset(543, 466),
  'node_ladies_hostel': Offset(391, 471),
  'node_hydraulic_lab': Offset(535, 380),
  'node_heat_engines': Offset(707, 510),
  'node_ec_block': Offset(574, 625),
  'node_pg_block': Offset(537, 552),
  'node_stadium': Offset(827, 554),
  'node_hostels_road': Offset(984, 520),
  'node_mens_hostel': Offset(1094, 476),
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
    if (widget.styleMode != oldWidget.styleMode) {
      if (widget.styleMode == MapStyleMode.collegeMap) {
        _tilt = 0.0;
        _animateCameraTo(
          targetX: 589.5,
          targetY: 384,
          targetZoom: _overviewZoom,
          targetRot: 0,
        );
      } else {
        _tilt = 0.52;
        _animateCameraTo(
          targetX: 520,
          targetY: 480,
          targetZoom: 0.95,
          targetRot: 0,
        );
      }
    } else if (widget.selectedPlace != null &&
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
    if (widget.styleMode != MapStyleMode.collegeMap || _viewportSize.isEmpty) {
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
    final isCollegeMap = widget.styleMode == MapStyleMode.collegeMap;
    _animateCameraTo(
      targetX: isCollegeMap ? 589.5 : 520.0,
      targetY: isCollegeMap ? 384.0 : 480.0,
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
          (node) => widget.styleMode == MapStyleMode.collegeMap
              ? _collegeMapNodePositions[node.id] ?? Offset(node.x, node.y)
              : Offset(node.x, node.y),
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
        widget.styleMode == MapStyleMode.collegeMap ? 1179.0 : 1000.0,
      );
      _camY = (_camY - unrotatedDy / _coordinateYScale).clamp(
        0.0,
        widget.styleMode == MapStyleMode.collegeMap ? 768.0 : 1000.0,
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
    final campusTapY =
        _camY + (dx * sinRot + unTiltedY * cosRot) / _coordinateYScale;

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
        _viewportSize = size;
        if (!_cameraInitialized && size.width > 0 && size.height > 0) {
          _cameraInitialized = true;
          if (widget.styleMode == MapStyleMode.collegeMap) {
            _camX = 589.5;
            _camY = 384;
            _zoom = _overviewZoom;
          }
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
    final buildingTilt = styleMode == MapStyleMode.collegeMap ? 0.48 : tilt;
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
    if (styleMode == MapStyleMode.collegeMap) {
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
    } else {
      _drawCampusBackground(canvas, size);
      _drawRoadsAndPaths(canvas, size);
      _drawGroundLandmarks(canvas, size);
      if (activeRoute != null) {
        _drawNavigationRoute(canvas, size);
      }
      _draw3DBuildings(canvas, size);
      if (userLocationOffset != null) {
        _drawUserLocation(canvas, size);
      }
      if (selectedPlace != null) {
        _drawSelectedPin(canvas, size);
      }
    }
  }

  void _drawCollegeMap(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFFEAF0E2), BlendMode.src);
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

  void _drawCollegeGreenspace(Canvas canvas, Size size) {
    final parkPaint = Paint()..color = const Color(0xFFDCE8CE);
    for (final park in const [
      <Offset>[
        Offset(440, 160),
        Offset(560, 160),
        Offset(558, 230),
        Offset(470, 250),
      ],
      <Offset>[
        Offset(700, 210),
        Offset(755, 220),
        Offset(735, 265),
        Offset(690, 253),
      ],
      <Offset>[
        Offset(75, 485),
        Offset(330, 520),
        Offset(330, 740),
        Offset(145, 755),
      ],
      <Offset>[
        Offset(830, 40),
        Offset(930, 30),
        Offset(950, 245),
        Offset(830, 225),
      ],
    ]) {
      canvas.drawPath(_mapPath(park, size, close: true), parkPaint);
    }

    final treePaint = Paint()..color = const Color(0xFF9DB88C);
    final treeHighlight = Paint()..color = const Color(0xFFC0D0AD);
    for (var row = 0; row < 18; row++) {
      for (var column = 0; column < 26; column++) {
        final x = 18.0 + column * 46;
        final y = 14.0 + row * 43;
        final variation = math.sin(column * 12.989 + row * 78.233);
        if (variation < -0.22 &&
            !_isNearMapBuilding(x, y) &&
            !_isNearRoad(x, y)) {
          final center = _project(x, y, 0, size);
          final radius = 5.0 + (variation.abs() * 5);
          canvas.drawCircle(center, radius * zoom, treePaint);
          canvas.drawCircle(
            center.translate(-radius * zoom * 0.2, -radius * zoom * 0.2),
            radius * zoom * 0.52,
            treeHighlight,
          );
        }
      }
    }
  }

  bool _isNearMapBuilding(double x, double y) {
    return _collegeMapFeatures.any(
      (feature) =>
          (feature.center.dx - x).abs() < feature.width * 0.62 &&
          (feature.center.dy - y).abs() < feature.length * 0.62,
    );
  }

  bool _isNearRoad(double x, double y) {
    return (x < 125 && y > 210) ||
        (y > 48 + x * 0.19 && y < 79 + x * 0.19 && x < 1050) ||
        (x > 545 && x < 820 && y > 280 && y < 470);
  }

  void _drawCollegeGrounds(Canvas canvas, Size size) {
    for (final feature in _collegeMapFeatures.where(
      (feature) => feature.isGround,
    )) {
      if (feature.label.contains('College Ground')) continue;
      if (feature.label == 'MH Ground') {
        final center = _project(feature.center.dx, feature.center.dy, 0, size);
        final track = Rect.fromCenter(
          center: center,
          width: feature.width * zoom,
          height: feature.length * zoom,
        );
        canvas.drawOval(track, Paint()..color = const Color(0xFFD8D7C8));
        canvas.drawOval(
          track.deflate(9 * zoom),
          Paint()
            ..color = const Color(0xFFF7F5ED)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2 * zoom,
        );
        final field = track.deflate(22 * zoom);
        canvas.drawOval(field, Paint()..color = const Color(0xFFC9DEB8));
        canvas.drawOval(
          field,
          Paint()
            ..color = const Color(0xFFB6C9A8)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2 * zoom,
        );
        continue;
      }
      final bounds = Rect.fromCenter(
        center: feature.center,
        width: feature.width,
        height: feature.length,
      );
      final rect = Rect.fromPoints(
        _project(bounds.topLeft.dx, bounds.topLeft.dy, 0, size),
        _project(bounds.bottomRight.dx, bounds.bottomRight.dy, 0, size),
      );
      final groundColor =
          feature.label.contains('Ground') || feature.label.contains('Football')
          ? const Color(0xFFC9DEB8)
          : const Color(0xFFD5E3C8);
      final groundPaint = Paint()..color = groundColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        groundPaint,
      );
      final outline = Paint()
        ..color = const Color(0xFFB6C9A8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        outline,
      );
      if (feature.label.contains('Ground') ||
          feature.label.contains('Football')) {
        final field = rect.deflate(math.max(6, rect.width * 0.11));
        final fieldPaint = Paint()..color = const Color(0xFFB9D3A8);
        canvas.drawRRect(
          RRect.fromRectAndRadius(field, const Radius.circular(20)),
          fieldPaint,
        );
      }
    }
  }

  void _drawCollegeRoads(Canvas canvas, Size size) {
    const roads = <({List<Offset> points, double width})>[
      (
        points: [
          Offset(20, -10),
          Offset(18, 90),
          Offset(28, 195),
          Offset(42, 300),
          Offset(62, 408),
          Offset(95, 520),
          Offset(124, 650),
          Offset(160, 780),
        ],
        width: 29,
      ),
      (
        points: [
          Offset(272, 53),
          Offset(350, 72),
          Offset(445, 96),
          Offset(540, 128),
          Offset(630, 168),
          Offset(727, 218),
          Offset(835, 254),
          Offset(944, 257),
          Offset(1065, 236),
          Offset(1195, 218),
        ],
        width: 23,
      ),
      (
        points: [
          Offset(556, 235),
          Offset(580, 271),
          Offset(627, 301),
          Offset(682, 321),
          Offset(757, 333),
          Offset(812, 376),
          Offset(808, 420),
          Offset(771, 458),
          Offset(724, 492),
          Offset(685, 531),
          Offset(635, 572),
          Offset(594, 622),
          Offset(546, 700),
          Offset(510, 780),
        ],
        width: 15,
      ),
      (
        points: [
          Offset(815, 396),
          Offset(870, 415),
          Offset(932, 433),
          Offset(991, 474),
          Offset(1050, 523),
          Offset(1114, 566),
          Offset(1195, 607),
        ],
        width: 17,
      ),
    ];

    for (final road in roads) {
      final path = _mapPath(road.points, size);
      final outline = Paint()
        ..color = const Color(0xFFD1D4CE)
        ..style = PaintingStyle.stroke
        ..strokeWidth = road.width * zoom
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final surface = Paint()
        ..color = const Color(0xFFFDFCF8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (road.width - 3) * zoom
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas
        ..drawPath(path, outline)
        ..drawPath(path, surface);
    }

    _drawMapRoadLabel(
      canvas,
      size,
      'KOTHAMANGALAM MAIN ROAD',
      const Offset(43, 227),
      -math.pi / 2,
    );
    _drawMapRoadLabel(
      canvas,
      size,
      'M A COLLEGE ROAD',
      const Offset(796, 228),
      math.atan2(70, 150),
    );
    _drawMapRoadLabel(
      canvas,
      size,
      'M A COLLEGE ROAD',
      const Offset(1072, 238),
      -0.24,
    );

    final walkways = Paint()
      ..color = const Color(0xFFF8F7F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * zoom
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final pathPoints in const [
      <Offset>[
        Offset(535, 244),
        Offset(510, 318),
        Offset(545, 384),
        Offset(542, 458),
      ],
      <Offset>[
        Offset(650, 337),
        Offset(603, 384),
        Offset(635, 436),
        Offset(705, 510),
      ],
      <Offset>[
        Offset(550, 467),
        Offset(515, 525),
        Offset(570, 620),
        Offset(630, 690),
      ],
      <Offset>[Offset(808, 385), Offset(870, 350), Offset(925, 380)],
      <Offset>[Offset(780, 476), Offset(820, 548), Offset(816, 590)],
    ]) {
      canvas.drawPath(_mapPath(pathPoints, size), walkways);
    }
  }

  void _drawMapRoadLabel(
    Canvas canvas,
    Size size,
    String label,
    Offset position,
    double rotation,
  ) {
    final text = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Color(0xFF59605A),
          fontSize: 9,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.7,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final center = _project(position.dx, position.dy, 0, size);
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(rotation)
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: text.width + 8,
            height: text.height + 4,
          ),
          const Radius.circular(3),
        ),
        Paint()..color = const Color(0xFFFDFCF8).withValues(alpha: 0.82),
      )
      ..translate(-text.width / 2, -text.height / 2);
    text.paint(canvas, Offset.zero);
    canvas.restore();
  }

  void _drawCollegeBuildings(Canvas canvas, Size size) {
    final buildings =
        _collegeMapFeatures.where((feature) => !feature.isGround).toList()
          ..sort((a, b) => a.center.dy.compareTo(b.center.dy));

    for (final feature in buildings) {
      _drawCollegeBuilding(canvas, size, feature);
    }
  }

  void _drawCollegeBuilding(
    Canvas canvas,
    Size size,
    _CollegeMapFeature feature,
  ) {
    final angle = feature.rotationDeg * math.pi / 180;
    final cosAngle = math.cos(angle);
    final sinAngle = math.sin(angle);
    final hw = feature.width / 2;
    final hl = feature.length / 2;
    final base =
        <Offset>[
          Offset(-hw, -hl),
          Offset(hw, -hl),
          Offset(hw, hl),
          Offset(-hw, hl),
        ].map((corner) {
          return Offset(
            feature.center.dx + corner.dx * cosAngle - corner.dy * sinAngle,
            feature.center.dy + corner.dx * sinAngle + corner.dy * cosAngle,
          );
        }).toList();

    const height = 16.0;
    final ground = base.map((p) => _project(p.dx, p.dy, 0, size)).toList();
    final roof = base.map((p) => _project(p.dx, p.dy, height, size)).toList();
    final shade = Paint()..color = const Color(0xFFD7D0C1);
    final wall = Paint()..color = const Color(0xFFE7E1D5);
    for (var i = 0; i < base.length; i++) {
      final next = (i + 1) % base.length;
      final face = Path()
        ..moveTo(ground[i].dx, ground[i].dy)
        ..lineTo(ground[next].dx, ground[next].dy)
        ..lineTo(roof[next].dx, roof[next].dy)
        ..lineTo(roof[i].dx, roof[i].dy)
        ..close();
      canvas.drawPath(face, i.isEven ? wall : shade);
    }

    final top = Path()
      ..moveTo(roof.first.dx, roof.first.dy)
      ..lineTo(roof[1].dx, roof[1].dy)
      ..lineTo(roof[2].dx, roof[2].dy)
      ..lineTo(roof[3].dx, roof[3].dy)
      ..close();
    canvas.drawShadow(top, const Color(0x40000000), 3 * zoom, false);
    canvas.drawPath(top, Paint()..color = const Color(0xFFF4F0E7));
    canvas.drawPath(
      top,
      Paint()
        ..color = const Color(0xFFB8B0A2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25 * zoom,
    );
  }

  void _drawCollegeMapLabels(Canvas canvas, Size size) {
    for (final feature in _collegeMapFeatures) {
      final center = _project(feature.center.dx, feature.center.dy, 0, size);
      final text = TextPainter(
        text: TextSpan(
          text: feature.label,
          style: TextStyle(
            color: const Color(0xFF27312A),
            fontSize: 10.5,
            height: 1.05,
            fontWeight: feature.placeId == null
                ? FontWeight.w500
                : FontWeight.w600,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 132);

      final labelCenter = Offset(
        center.dx,
        center.dy - feature.length * 0.5 * zoom - text.height * 0.55 - 3,
      );
      final labelRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: labelCenter,
          width: text.width + 6,
          height: text.height + 3,
        ),
        const Radius.circular(3),
      );
      canvas.drawRRect(
        labelRect,
        Paint()..color = const Color(0xFFF8F8F2).withValues(alpha: 0.88),
      );
      text.paint(
        canvas,
        Offset(
          labelCenter.dx - text.width / 2,
          labelCenter.dy - text.height / 2,
        ),
      );
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
    final roadColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFF94A3B8);
    final pathColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFCBD5E1);

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

      final isMajorRoad =
          edge.pathName.contains('Road') ||
          edge.pathName.contains('Drive') ||
          edge.pathName.contains('Avenue');

      canvas.drawLine(p1, p2, isMajorRoad ? roadPaint : walkwayPaint);
    }

    // Road dash lines for major campus roads
    final centerDashPaint = Paint()
      ..color = isDark
          ? const Color(0xFF0284C7)
          : Colors.white.withValues(alpha: 0.8)
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
      final mapPosition = styleMode == MapStyleMode.collegeMap
          ? _collegeMapNodePositions[nodes[i].id]
          : null;
      final pt = _project(
        mapPosition?.dx ?? nodes[i].x,
        mapPosition?.dy ?? nodes[i].y,
        1.0,
        size,
      );
      if (i == 0) {
        routePath.moveTo(pt.dx, pt.dy);
      } else {
        routePath.lineTo(pt.dx, pt.dy);
      }
    }

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
      final mapPosition = styleMode == MapStyleMode.collegeMap
          ? _collegeMapNodePositions[nodes[i].id]
          : null;
      final pt = _project(
        mapPosition?.dx ?? nodes[i].x,
        mapPosition?.dy ?? nodes[i].y,
        1.2,
        size,
      );
      canvas.drawCircle(pt, 3.5 * zoom, dotPaint);
    }

    // Start Pin (Green)
    final startPosition = styleMode == MapStyleMode.collegeMap
        ? _collegeMapNodePositions[nodes.first.id]
        : null;
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
    final destPosition = styleMode == MapStyleMode.collegeMap
        ? _collegeMapNodePositions[nodes.last.id]
        : null;
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
  // 5. 3D BUILDING BLOCKS & MODELS
  // ---------------------------------------------------------------------------
  void _draw3DBuildings(Canvas canvas, Size size) {
    // Depth sort places back-to-front so closer buildings occlude background buildings
    final sortedPlaces = List<CampusPlace>.from(places)
      ..sort(
        (a, b) => _getDepth(
          a.campusX,
          a.campusY,
        ).compareTo(_getDepth(b.campusX, b.campusY)),
      );

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
  void _drawBuildingBlock3D(
    Canvas canvas,
    Size size,
    CampusPlace place, {
    Offset? center,
    double? width,
    double? length,
    double? rotationDeg,
    bool drawLabel = true,
  }) {
    final cx = center?.dx ?? place.campusX;
    final cy = center?.dy ?? place.campusY;
    final hw = (width ?? place.width) / 2;
    final hl = (length ?? place.length) / 2;
    final h = place.height;
    final isDark = styleMode == MapStyleMode.blueprint;
    final isSelected = selectedPlace?.id == place.id;

    // Local building rotation angle
    final rotRad = (rotationDeg ?? place.rotationDeg) * (math.pi / 180.0);
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

    final baseWallColor = isDark
        ? const Color(0xFF1E293B)
        : styleMode == MapStyleMode.collegeMap
        ? const Color(0xFFF1EBDD)
        : place.wallColor;

    for (int i = 0; i < 4; i++) {
      final info = wallCorners[i];
      final ptG_A = info[2];
      final ptG_B = info[3];
      final ptR_A = info[4];
      final ptR_B = info[5];

      // Calculate 2D screen cross product to check if face is camera-facing
      final cross =
          (ptG_B.dx - ptG_A.dx) * (ptR_A.dy - ptG_A.dy) -
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
          ..color = isDark
              ? const Color(0xFF38BDF8).withValues(alpha: 0.3)
              : Colors.black26
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
        : styleMode == MapStyleMode.collegeMap
        ? (isSelected
              ? const Color(0xFFE9A83A).withValues(alpha: 0.88)
              : const Color(0xFFE5DCCB).withValues(alpha: 0.74))
        : (isSelected ? const Color(0xFFF59E0B) : place.roofColor);

    final roofPaint = Paint()
      ..color = roofColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(roofPath, roofPaint);

    final roofBorderPaint = Paint()
      ..color = styleMode == MapStyleMode.collegeMap
          ? const Color(0xFF5E584E).withValues(alpha: 0.75)
          : isSelected
          ? Colors.amberAccent
          : Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = (isSelected ? 2.8 : 1.2) * zoom;
    canvas.drawPath(roofPath, roofBorderPaint);

    // 4. Rooftop Label Banner
    if (drawLabel) {
      _drawBuildingLabel(canvas, size, place, h + 8.0);
    }
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
      Rect.fromCenter(center: labelPt, width: badgeWidth, height: badgeHeight),
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
      Offset(
        labelPt.dx - textPainter.width / 2,
        labelPt.dy - textPainter.height / 2,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. USER LOCATION PIN
  // ---------------------------------------------------------------------------
  void _drawUserLocation(Canvas canvas, Size size) {
    final location = userLocationOffset!;
    final mapLocation = styleMode == MapStyleMode.collegeMap
        ? Offset(location.dx * 1.179, location.dy * 0.768)
        : location;
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
