import 'package:flutter/material.dart';

/// Categories for campus places
enum PlaceCategory {
  academic('Academic Block', Icons.school_rounded, Color(0xFF1E3A8A)),
  lab('Lab & Workshop', Icons.science_rounded, Color(0xFF0D9488)),
  admin('Administration', Icons.business_rounded, Color(0xFFD97706)),
  sports('Sports & Grounds', Icons.sports_cricket_rounded, Color(0xFF16A34A)),
  hostel('Hostel & Residence', Icons.hotel_rounded, Color(0xFF9333EA)),
  amenity('Amenities & Food', Icons.restaurant_rounded, Color(0xFFEA580C)),
  landmark('Campus Landmark', Icons.account_balance_rounded, Color(0xFFDC2626));

  final String label;
  final IconData icon;
  final Color color;

  const PlaceCategory(this.label, this.icon, this.color);
}

/// Information about a specific floor inside a building
/// (Designed for easy extension to indoor floor plans)
class FloorInfo {
  final int level; // 0 = Ground, 1 = 1st Floor, etc.
  final String floorName;
  final List<String> rooms;
  final String? description;

  const FloorInfo({
    required this.level,
    required this.floorName,
    required this.rooms,
    this.description,
  });
}

/// Represents a building or landmark on the MACE campus
class CampusPlace {
  final String id;
  final String name;
  final String shortCode;
  final PlaceCategory category;
  final String description;

  /// Approximate geographic coordinates (for GPS mapping)
  final double approxLat;
  final double approxLng;

  /// Campus coordinate plane (0.0 to 1000.0) for 3D visual rendering
  final double campusX;
  final double campusY;

  /// 3D building block dimensions
  final double width;
  final double length;
  final double height; // 3D extrusion height

  /// Building orientation angle in degrees
  final double rotationDeg;

  /// Visual styling
  final Color roofColor;
  final Color wallColor;

  /// Whether this is a landmark rather than an enclosed building
  final bool isLandmark;

  /// Detailed indoor floor breakdown
  final List<FloorInfo> floors;

  /// Available amenities & facilities
  final List<String> facilities;

  /// Operating hours
  final String openHours;

  /// Search keywords (departments, labs, faculty names, etc.)
  final List<String> searchKeywords;

  /// Nearest node ID in the campus walkway graph
  final String walkwayNodeId;

  const CampusPlace({
    required this.id,
    required this.name,
    required this.shortCode,
    required this.category,
    required this.description,
    required this.approxLat,
    required this.approxLng,
    required this.campusX,
    required this.campusY,
    required this.width,
    required this.length,
    required this.height,
    this.rotationDeg = 0.0,
    required this.roofColor,
    required this.wallColor,
    this.isLandmark = false,
    this.floors = const [],
    this.facilities = const [],
    this.openHours = '8:30 AM – 5:00 PM',
    this.searchKeywords = const [],
    required this.walkwayNodeId,
  });

  /// Check if query matches this place by name, keyword, or room
  bool matchesQuery(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return true;

    if (name.toLowerCase().contains(q)) return true;
    if (shortCode.toLowerCase().contains(q)) return true;
    if (description.toLowerCase().contains(q)) return true;
    if (category.label.toLowerCase().contains(q)) return true;

    for (final kw in searchKeywords) {
      if (kw.toLowerCase().contains(q)) return true;
    }

    for (final floor in floors) {
      for (final room in floor.rooms) {
        if (room.toLowerCase().contains(q)) return true;
      }
    }

    return false;
  }
}
