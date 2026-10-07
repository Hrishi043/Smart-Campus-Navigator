import 'package:flutter/material.dart';
import '../data/campus_data.dart';
import '../models/navigation.dart';
import '../models/place.dart';
import '../services/location_service.dart';
import '../widgets/campus_3d_map.dart';
import '../widgets/campus_info_dialog.dart';
import '../widgets/directions_modal.dart';
import '../widgets/navigation_hud.dart';
import '../widgets/place_detail_sheet.dart';
import '../widgets/search_modal.dart';

class CampusHomeScreen extends StatefulWidget {
  const CampusHomeScreen({super.key});

  @override
  State<CampusHomeScreen> createState() => _CampusHomeScreenState();
}

class _CampusHomeScreenState extends State<CampusHomeScreen> {
  final GlobalKey<Campus3DMapState> _mapKey = GlobalKey<Campus3DMapState>();
  final List<CampusPlace> _places = CampusData.campusPlaces;

  CampusPlace? _selectedPlace;
  CampusRoute? _activeRoute;
  bool _isNavigating = false;
  MapStyleMode _styleMode = MapStyleMode.architectural;
  PlaceCategory? _activeCategoryFilter;

  @override
  void initState() {
    super.initState();
    LocationService.instance.addListener(_onLocationUpdated);
  }

  @override
  void dispose() {
    LocationService.instance.removeListener(_onLocationUpdated);
    super.dispose();
  }

  void _onLocationUpdated() {
    if (mounted) setState(() {});
  }

  void _onPlaceTapped(CampusPlace place) {
    setState(() {
      _selectedPlace = place;
    });
  }

  void _onSearchTapped() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchModal(
        places: _places,
        onPlaceSelected: (place) {
          setState(() {
            _selectedPlace = place;
          });
          _mapKey.currentState?.animateToPlace(place);
        },
      ),
    );
  }

  void _openDirectionsModal({CampusPlace? start, CampusPlace? dest}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DirectionsModal(
        places: _places,
        initialStart: start,
        initialDest: dest ?? _selectedPlace,
        onRouteCalculated: (route) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _activeRoute = route;
                _selectedPlace = null;
              });
              _mapKey.currentState?.fitRoute(route);
            }
          });
        },
        onStartLiveNavigation: (route) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _activeRoute = route;
                _isNavigating = true;
                _selectedPlace = null;
              });
              _mapKey.currentState?.fitRoute(route);
            }
          });
        },
      ),
    );
  }

  void _toggleStyleMode() {
    setState(() {
      final nextIdx = (_styleMode.index + 1) % MapStyleMode.values.length;
      _styleMode = MapStyleMode.values[nextIdx];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Switched to ${_styleMode.label} mode'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleMyLocationPressed() async {
    final success = await LocationService.instance.requestLocation();
    if (!mounted) return;

    if (success && LocationService.instance.campusOffset != null) {
      final offset = LocationService.instance.campusOffset!;
      _mapKey.currentState?.animateToPlace(
        CampusPlace(
          id: 'user_pos',
          name: 'My Position',
          shortCode: 'ME',
          category: PlaceCategory.landmark,
          description: '',
          approxLat: 0,
          approxLng: 0,
          campusX: offset.dx,
          campusY: offset.dy,
          width: 20,
          length: 20,
          height: 10,
          roofColor: Colors.blue,
          wallColor: Colors.white,
          walkwayNodeId: 'node_campus_road_mid',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acquired GPS location on campus'),
          backgroundColor: Color(0xFF16A34A),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Graceful fallback for permission denial or classroom demo
      final error = LocationService.instance.errorMessage ??
          'Location not available. Placing at Main Entrance for demo.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          action: SnackBarAction(
            label: 'Simulate',
            textColor: Colors.amberAccent,
            onPressed: () {
              // Simulate at Main Entrance
              LocationService.instance.setSimulatedPosition(420, 120);
            },
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _clearRoute() {
    setState(() {
      _activeRoute = null;
      _isNavigating = false;
    });
    LocationService.instance.clearSimulation();
    _mapKey.currentState?.resetToCampusOverview();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userOffset = LocationService.instance.campusOffset;

    // Filter places if category chip is selected
    final displayedPlaces = _activeCategoryFilter == null
        ? _places
        : _places.where((p) => p.category == _activeCategoryFilter).toList();

    return Scaffold(
      body: Stack(
        children: [
          // 1. Full-screen 3D Interactive Campus Map
          Positioned.fill(
            child: Campus3DMap(
              key: _mapKey,
              places: displayedPlaces,
              selectedPlace: _selectedPlace,
              activeRoute: _activeRoute,
              userLocationOffset: userOffset,
              styleMode: _styleMode,
              onPlaceTapped: _onPlaceTapped,
            ),
          ),

          // 2. Top Header & Search Area (if not in live navigation)
          if (!_isNavigating)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Bar Card
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(16),
                        color: theme.colorScheme.surface,
                        child: InkWell(
                          onTap: _onSearchTapped,
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E3A8A),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'MACE Smart Navigator',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Search buildings, labs, landmarks...',
                                        style: TextStyle(
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => const CampusInfoDialog(),
                                  ),
                                  icon: const Icon(Icons.info_outline_rounded),
                                  tooltip: 'About MACE Campus',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Quick Category Filter Scroll
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          FilterChip(
                            label: const Text('All Places'),
                            selected: _activeCategoryFilter == null,
                            onSelected: (_) {
                              setState(() => _activeCategoryFilter = null);
                            },
                          ),
                          const SizedBox(width: 6),
                          ...PlaceCategory.values.map((cat) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: FilterChip(
                                avatar: Icon(cat.icon, size: 14),
                                label: Text(cat.label),
                                selected: _activeCategoryFilter == cat,
                                onSelected: (sel) {
                                  setState(() => _activeCategoryFilter =
                                      sel ? cat : null);
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 3. Live Navigation Heads-Up Display (if navigating)
          if (_isNavigating && _activeRoute != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavigationHud(
                route: _activeRoute!,
                onStopNavigation: () {
                  setState(() => _isNavigating = false);
                },
                onUserMoved: (x, y) {
                  // User location updated during simulation or walking
                },
              ),
            ),

          // 4. Right Side Floating Map Controls (Floating Action Stack)
          Positioned(
            right: 14,
            bottom: _selectedPlace != null ? 310 : 96,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Reset to Full Campus View
                _buildMapButton(
                  icon: Icons.center_focus_strong_rounded,
                  tooltip: 'Full Campus View',
                  onPressed: () {
                    setState(() {
                      _selectedPlace = null;
                    });
                    _mapKey.currentState?.resetToCampusOverview();
                  },
                ),
                const SizedBox(height: 6),

                // Rotate Clockwise
                _buildMapButton(
                  icon: Icons.rotate_right_rounded,
                  tooltip: 'Rotate View 45°',
                  onPressed: () => _mapKey.currentState?.rotateClockwise(),
                ),
                const SizedBox(height: 6),

                // 2D / 3D Tilt Toggle
                _buildMapButton(
                  icon: _mapKey.currentState?.is3DTilt ?? true
                      ? Icons.view_in_ar_rounded
                      : Icons.crop_square_rounded,
                  tooltip: 'Toggle 3D Tilt',
                  onPressed: () => _mapKey.currentState?.toggleTilt(),
                ),
                const SizedBox(height: 6),

                // Map Style Switcher (3D Architecture / Satellite / Blueprint)
                _buildMapButton(
                  icon: _styleMode.icon,
                  tooltip: 'Style: ${_styleMode.label}',
                  onPressed: _toggleStyleMode,
                ),
                const SizedBox(height: 6),

                // Zoom Controls
                _buildMapButton(
                  icon: Icons.add_rounded,
                  tooltip: 'Zoom In',
                  onPressed: () => _mapKey.currentState?.zoomIn(),
                ),
                const SizedBox(height: 4),
                _buildMapButton(
                  icon: Icons.remove_rounded,
                  tooltip: 'Zoom Out',
                  onPressed: () => _mapKey.currentState?.zoomOut(),
                ),
                const SizedBox(height: 6),

                // My Location Button
                _buildMapButton(
                  icon: Icons.my_location_rounded,
                  tooltip: 'My Location',
                  color: const Color(0xFF0284C7),
                  iconColor: Colors.white,
                  onPressed: _handleMyLocationPressed,
                ),
              ],
            ),
          ),

          // 5. Active Route Floating Summary Bar (if route exists and detail sheet is closed)
          if (_activeRoute != null && !_isNavigating && _selectedPlace == null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_walk_rounded,
                          color: Color(0xFF16A34A),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${_activeRoute!.startPlace.shortCode} → ${_activeRoute!.destPlace.shortCode}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${_activeRoute!.totalDistanceMeters.round()} m • ~${_activeRoute!.estimatedMinutes} min',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: _clearRoute,
                        tooltip: 'Clear Route',
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          setState(() => _isNavigating = true);
                        },
                        icon: const Icon(Icons.navigation_rounded, size: 16),
                        label: const Text('Start'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 6. Bottom "Directions" floating button (if no place selected and no route active)
          if (_selectedPlace == null && _activeRoute == null && !_isNavigating)
            Positioned(
              left: 16,
              bottom: 24,
              child: FloatingActionButton.extended(
                onPressed: () => _openDirectionsModal(),
                icon: const Icon(Icons.directions_rounded),
                label: const Text('Directions'),
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
              ),
            ),

          // 7. Selected Place Detail Bottom Sheet
          if (_selectedPlace != null && !_isNavigating)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlaceDetailSheet(
                place: _selectedPlace!,
                onGetDirections: () {
                  final dest = _selectedPlace;
                  _openDirectionsModal(dest: dest);
                },
                onSetAsStart: () {
                  final start = _selectedPlace;
                  _openDirectionsModal(start: start);
                },
                onClose: () {
                  setState(() => _selectedPlace = null);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMapButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    Color? color,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? theme.colorScheme.onSurface, size: 20),
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: onPressed,
      ),
    );
  }
}
