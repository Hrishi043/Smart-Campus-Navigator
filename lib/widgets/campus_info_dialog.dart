import 'package:flutter/material.dart';

class CampusInfoDialog extends StatelessWidget {
  const CampusInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: Color(0xFF1E3A8A),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'About Smart Campus Navigator',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Mar Athanasius College of Engineering (MACE)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              'Established in 1961 in Kothamangalam, Kerala, MACE is a premier government-aided engineering college. This app provides interactive 3D navigation across college buildings, workshops, sports facilities, and landmarks.',
              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
            ),
            const Divider(height: 20),
            const Text(
              'Interactive Map Controls',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 6),
            _buildFeatureRow(
              Icons.touch_app_rounded,
              'Drag with 1 finger to pan across campus.',
            ),
            _buildFeatureRow(
              Icons.pinch_rounded,
              'Pinch with 2 fingers to zoom in and out.',
            ),
            _buildFeatureRow(
              Icons.rotate_right_rounded,
              'Twist with 2 fingers to rotate the 3D campus view.',
            ),
            _buildFeatureRow(
              Icons.view_in_ar_rounded,
              'Toggle between 3D Building Blocks and 2D Plan views.',
            ),
            _buildFeatureRow(
              Icons.directions_walk_rounded,
              'Shortest path walking route calculation with turn directions.',
            ),
            _buildFeatureRow(
              Icons.play_circle_fill_rounded,
              'Simulate Walking mode for indoor lab presentations.',
            ),
            const Divider(height: 20),
            Text(
              'Android Lab Project • Smart Campus Navigator\nBuilt with Flutter & Dart',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
          ),
          child: const Text('Got it'),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1E3A8A)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
