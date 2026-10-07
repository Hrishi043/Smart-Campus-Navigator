import 'package:flutter/material.dart';
import '../models/navigation.dart';
import '../models/place.dart';
import '../services/location_service.dart';
import '../services/pathfinding_service.dart';

class DirectionsModal extends StatefulWidget {
  final List<CampusPlace> places;
  final CampusPlace? initialStart;
  final CampusPlace? initialDest;
  final Function(CampusRoute route) onRouteCalculated;
  final Function(CampusRoute route) onStartLiveNavigation;

  const DirectionsModal({
    super.key,
    required this.places,
    this.initialStart,
    this.initialDest,
    required this.onRouteCalculated,
    required this.onStartLiveNavigation,
  });

  @override
  State<DirectionsModal> createState() => _DirectionsModalState();
}

class _DirectionsModalState extends State<DirectionsModal> {
  CampusPlace? _startPlace;
  CampusPlace? _destPlace;
  CampusRoute? _route;

  @override
  void initState() {
    super.initState();
    _startPlace = widget.initialStart ??
        LocationService.instance.getUserPlace() ??
        widget.places.firstWhere((p) => p.id == 'main_gate', orElse: () => widget.places.first);

    _destPlace = widget.initialDest ??
        widget.places.firstWhere((p) => p.id == 'main_block', orElse: () => widget.places.last);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _calculateRoute();
      }
    });
  }

  void _calculateRoute() {
    if (_startPlace == null || _destPlace == null) return;
    final r = PathfindingService.instance.findRoute(
      startPlace: _startPlace!,
      destPlace: _destPlace!,
    );
    setState(() {
      _route = r;
    });
    if (r != null) {
      widget.onRouteCalculated(r);
    }
  }

  void _swapPlaces() {
    setState(() {
      final tmp = _startPlace;
      _startPlace = _destPlace;
      _destPlace = tmp;
    });
    _calculateRoute();
  }

  void _useMyLocationAsStart() async {
    final hasLoc = await LocationService.instance.requestLocation();
    if (hasLoc && mounted) {
      final userPlace = LocationService.instance.getUserPlace();
      if (userPlace != null) {
        setState(() {
          _startPlace = userPlace;
        });
        _calculateRoute();
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocationService.instance.errorMessage ??
              'Using simulated campus entrance for testing.'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Campus Walking Directions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Origin and Destination Selector
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    // Column of icons
                    Column(
                      children: [
                        const Icon(
                          Icons.trip_origin_rounded,
                          color: Color(0xFF16A34A),
                          size: 20,
                        ),
                        Container(
                          width: 2,
                          height: 32,
                          color: Colors.grey.withValues(alpha: 0.4),
                        ),
                        const Icon(
                          Icons.location_on_rounded,
                          color: Color(0xFFDC2626),
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),

                    // Dropdowns
                    Expanded(
                      child: Column(
                        children: [
                          _buildPlaceDropdown(
                            label: 'Start Location',
                            selected: _startPlace,
                            onChanged: (p) {
                              setState(() => _startPlace = p);
                              _calculateRoute();
                            },
                          ),
                          const Divider(height: 12),
                          _buildPlaceDropdown(
                            label: 'Destination',
                            selected: _destPlace,
                            onChanged: (p) {
                              setState(() => _destPlace = p);
                              _calculateRoute();
                            },
                          ),
                        ],
                      ),
                    ),

                    // Swap & GPS Buttons
                    Column(
                      children: [
                        IconButton(
                          onPressed: _swapPlaces,
                          icon: const Icon(Icons.swap_vert_rounded),
                          tooltip: 'Swap locations',
                        ),
                        IconButton(
                          onPressed: _useMyLocationAsStart,
                          icon: const Icon(Icons.my_location_rounded),
                          tooltip: 'Use current GPS location',
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Route Metrics Card
              if (_route != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF1E3A8A).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_walk_rounded,
                              color: Color(0xFF1E3A8A)),
                          const SizedBox(width: 8),
                          Text(
                            '${_route!.totalDistanceMeters.round()} meters',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Container(width: 1, height: 24, color: Colors.grey.shade300),
                      Row(
                        children: [
                          const Icon(Icons.schedule_rounded,
                              color: Color(0xFF1E3A8A)),
                          const SizedBox(width: 8),
                          Text(
                            '~${_route!.estimatedMinutes} min walk',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Step-by-step guidance list
                Text(
                  'Route Steps',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 140),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _route!.steps.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, idx) {
                      final step = _route!.steps[idx];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(step.icon, size: 18, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              step.instruction,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Start Navigation Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onStartLiveNavigation(_route!);
                    },
                    icon: const Icon(Icons.navigation_rounded),
                    label: const Text('Start Live Walking Navigation'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF16A34A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceDropdown({
    required String label,
    required CampusPlace? selected,
    required ValueChanged<CampusPlace?> onChanged,
  }) {
    // Add current location if available
    final allOptions = <CampusPlace>[];
    final userPlace = LocationService.instance.getUserPlace();
    if (userPlace != null) {
      allOptions.add(userPlace);
    }
    allOptions.addAll(widget.places);

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: selected?.id,
        hint: Text(label, style: const TextStyle(fontSize: 13)),
        items: allOptions.map((p) {
          return DropdownMenuItem<String>(
            value: p.id,
            child: Row(
              children: [
                Icon(p.category.icon, size: 16, color: p.category.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    p.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (id) {
          if (id != null) {
            final p = allOptions.firstWhere((item) => item.id == id);
            onChanged(p);
          }
        },
      ),
    );
  }
}
