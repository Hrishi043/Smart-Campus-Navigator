import 'dart:async';
import 'package:flutter/material.dart';
import '../models/navigation.dart';
import '../services/location_service.dart';

class NavigationHud extends StatefulWidget {
  final CampusRoute route;
  final VoidCallback onStopNavigation;
  final Function(double x, double y) onUserMoved;

  const NavigationHud({
    super.key,
    required this.route,
    required this.onStopNavigation,
    required this.onUserMoved,
  });

  @override
  State<NavigationHud> createState() => _NavigationHudState();
}

class _NavigationHudState extends State<NavigationHud> {
  int _currentStepIndex = 0;
  bool _isSimulating = false;
  Timer? _simulationTimer;
  int _simNodeIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.route.steps.isNotEmpty) {
      _currentStepIndex = 0;
    }
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }

  void _toggleSimulation() {
    if (_isSimulating) {
      _simulationTimer?.cancel();
      setState(() => _isSimulating = false);
    } else {
      setState(() {
        _isSimulating = true;
        _simNodeIndex = 0;
      });
      _startSimulation();
    }
  }

  void _startSimulation() {
    _simulationTimer?.cancel();
    final nodes = widget.route.pathNodes;
    if (nodes.isEmpty) return;

    // Place user at first node
    widget.onUserMoved(nodes.first.x, nodes.first.y);
    LocationService.instance.setSimulatedPosition(nodes.first.x, nodes.first.y);

    _simulationTimer = Timer.periodic(const Duration(milliseconds: 1400), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      _simNodeIndex++;
      if (_simNodeIndex >= nodes.length) {
        timer.cancel();
        setState(() {
          _isSimulating = false;
          _currentStepIndex = widget.route.steps.length - 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Arrived at ${widget.route.destPlace.name}!'),
            backgroundColor: const Color(0xFF16A34A),
          ),
        );
      } else {
        final node = nodes[_simNodeIndex];
        widget.onUserMoved(node.x, node.y);
        LocationService.instance.setSimulatedPosition(node.x, node.y);

        setState(() {
          _currentStepIndex = (_simNodeIndex + 1).clamp(0, widget.route.steps.length - 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.route.steps.isNotEmpty &&
            _currentStepIndex < widget.route.steps.length
        ? widget.route.steps[_currentStepIndex]
        : null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Turn Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      currentStep?.icon ?? Icons.straight_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentStep?.instruction ?? 'Proceed along campus path',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Destination: ${widget.route.destPlace.name} (~${widget.route.totalDistanceMeters.round()}m)',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onStopNavigation,
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    tooltip: 'Stop navigation',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Simulation & Walk Controls Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonalIcon(
                  onPressed: _toggleSimulation,
                  icon: Icon(
                    _isSimulating
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 18,
                  ),
                  label: Text(_isSimulating ? 'Pause Walk' : 'Simulate Walking'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1E3A8A),
                    elevation: 3,
                  ),
                ),
                const SizedBox(width: 8),
                if (_currentStepIndex < widget.route.steps.length - 1)
                  FilledButton.tonalIcon(
                    onPressed: () {
                      setState(() {
                        _currentStepIndex++;
                        final nodeIdx = _currentStepIndex.clamp(0, widget.route.pathNodes.length - 1);
                        final node = widget.route.pathNodes[nodeIdx];
                        widget.onUserMoved(node.x, node.y);
                        LocationService.instance.setSimulatedPosition(node.x, node.y);
                      });
                    },
                    icon: const Icon(Icons.skip_next_rounded, size: 18),
                    label: const Text('Next Turn'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 3,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
