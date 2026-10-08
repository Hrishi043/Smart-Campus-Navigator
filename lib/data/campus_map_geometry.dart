import 'package:flutter/material.dart';

enum CampusGroundStyle { lawn, cricket, athleticsTrack, theatre }

class CampusMapRoad {
  final String id;
  final String name;
  final List<Offset> points;
  final double width;

  const CampusMapRoad({
    required this.id,
    required this.name,
    required this.points,
    required this.width,
  });
}

class CampusMapBuilding {
  final String id;
  final String? placeId;
  final List<Offset> footprint;
  final double height;
  final bool hostel;

  const CampusMapBuilding({
    required this.id,
    required this.footprint,
    this.placeId,
    this.height = 14,
    this.hostel = false,
  });

  Offset get center {
    final sum = footprint.fold(Offset.zero, (total, point) => total + point);
    return sum / footprint.length.toDouble();
  }
}

class CampusMapGround {
  final String id;
  final String label;
  final Offset center;
  final double width;
  final double height;
  final CampusGroundStyle style;

  const CampusMapGround({
    required this.id,
    required this.label,
    required this.center,
    required this.width,
    required this.height,
    required this.style,
  });
}

class CampusMapLabel {
  final String id;
  final String text;
  final Offset position;
  final bool keyLabel;
  final double rotation;

  const CampusMapLabel({
    required this.id,
    required this.text,
    required this.position,
    this.keyLabel = true,
    this.rotation = 0,
  });
}

class CampusMapGeometry {
  CampusMapGeometry._();

  // ---------------------------------------------------------------------------
  // ROADS — traced precisely from the reference aerial image (1179×768 canvas)
  // ---------------------------------------------------------------------------
  static const List<CampusMapRoad> roads = [
    // Main Kozhippilly – College Junction Road (diagonal top road)
    CampusMapRoad(
      id: 'kozhippilly_college_junction',
      name: 'Kozhippilly – College Junction Road',
      points: [
        Offset(-20, 10),
        Offset(60, 30),
        Offset(150, 55),
        Offset(250, 82),
        Offset(355, 113),
        Offset(435, 140),
        Offset(510, 163),
        Offset(595, 190),
        Offset(680, 212),
        Offset(775, 228),
        Offset(855, 232),
        Offset(920, 228),
        Offset(990, 212),
        Offset(1070, 196),
        Offset(1160, 182),
        Offset(1230, 173),
      ],
      width: 24,
    ),

    // Loop road around Cricket Ground
    CampusMapRoad(
      id: 'cricket_loop_road',
      name: '',
      points: [
        Offset(296, 156),
        Offset(345, 164),
        Offset(388, 192),
        Offset(415, 232),
        Offset(418, 278),
        Offset(400, 324),
        Offset(366, 356),
        Offset(320, 373),
        Offset(272, 366),
        Offset(232, 342),
        Offset(208, 302),
        Offset(202, 256),
        Offset(218, 208),
        Offset(254, 173),
        Offset(296, 156),
      ],
      width: 16,
    ),

    // Main Gate access road (from main road down to gate)
    CampusMapRoad(
      id: 'main_gate_access_road',
      name: '',
      points: [
        Offset(435, 140),
        Offset(432, 160),
        Offset(428, 185),
        Offset(425, 210),
        Offset(422, 232),
        Offset(418, 256),
      ],
      width: 14,
    ),

    // Parking access spur (east from gate toward main block)
    CampusMapRoad(
      id: 'parking_access_road',
      name: '',
      points: [
        Offset(435, 140),
        Offset(420, 148),
        Offset(405, 152),
        Offset(386, 150),
        Offset(365, 143),
        Offset(344, 133),
      ],
      width: 12,
    ),

    // West perimeter road (curves south-west along campus edge)
    CampusMapRoad(
      id: 'west_perimeter_road',
      name: '',
      points: [
        Offset(218, 208),
        Offset(196, 235),
        Offset(174, 268),
        Offset(156, 306),
        Offset(142, 344),
        Offset(130, 378),
        Offset(118, 408),
        Offset(104, 432),
        Offset(78, 454),
        Offset(42, 468),
        Offset(-10, 478),
      ],
      width: 14,
    ),

    // Ladies hostel access road (branches east from west perimeter)
    CampusMapRoad(
      id: 'ladies_hostel_access',
      name: '',
      points: [
        Offset(118, 408),
        Offset(144, 414),
        Offset(172, 416),
        Offset(202, 418),
        Offset(228, 428),
        Offset(252, 444),
        Offset(272, 464),
        Offset(288, 484),
      ],
      width: 13,
    ),

    // Inner campus road – main spine (from gate area down to canteen + labs)
    CampusMapRoad(
      id: 'inner_campus_spine',
      name: '',
      points: [
        Offset(418, 256),
        Offset(420, 286),
        Offset(424, 318),
        Offset(432, 352),
        Offset(446, 378),
        Offset(456, 402),
        Offset(458, 432),
        Offset(456, 462),
        Offset(450, 490),
      ],
      width: 16,
    ),

    // South-west road (from ladies hostel area to EC block area)
    CampusMapRoad(
      id: 'southwest_campus_road',
      name: '',
      points: [
        Offset(288, 484),
        Offset(306, 494),
        Offset(320, 514),
        Offset(322, 540),
        Offset(310, 562),
        Offset(302, 584),
        Offset(316, 606),
        Offset(346, 628),
        Offset(382, 648),
        Offset(418, 662),
        Offset(452, 670),
      ],
      width: 13,
    ),

    // Lab access road (curved path from inner spine down through labs to PG block)
    CampusMapRoad(
      id: 'lab_access_road',
      name: '',
      points: [
        Offset(450, 490),
        Offset(444, 514),
        Offset(434, 542),
        Offset(420, 568),
        Offset(414, 594),
        Offset(420, 622),
        Offset(436, 648),
        Offset(452, 670),
        Offset(462, 692),
        Offset(466, 718),
        Offset(480, 740),
        Offset(506, 752),
        Offset(538, 756),
        Offset(574, 752),
        Offset(612, 742),
        Offset(648, 728),
        Offset(682, 710),
        Offset(714, 696),
        Offset(740, 684),
        Offset(756, 674),
      ],
      width: 14,
    ),

    // Stadium outer loop road (encircles the athletics track)
    CampusMapRoad(
      id: 'stadium_outer_loop',
      name: '',
      points: [
        Offset(808, 344),
        Offset(864, 350),
        Offset(916, 374),
        Offset(952, 414),
        Offset(972, 460),
        Offset(978, 510),
        Offset(966, 558),
        Offset(944, 604),
        Offset(912, 644),
        Offset(868, 672),
        Offset(816, 686),
        Offset(762, 684),
        Offset(714, 670),
        Offset(674, 642),
        Offset(648, 606),
        Offset(638, 564),
        Offset(638, 520),
        Offset(650, 476),
        Offset(674, 438),
        Offset(710, 406),
        Offset(754, 376),
        Offset(808, 344),
      ],
      width: 16,
    ),

    // MACE Hostels Road (vertical road on right side)
    CampusMapRoad(
      id: 'mace_hostels_road',
      name: 'MACE Hostels Road',
      points: [
        Offset(952, 348),
        Offset(978, 354),
        Offset(982, 402),
        Offset(980, 450),
        Offset(978, 510),
        Offset(970, 558),
        Offset(950, 608),
        Offset(930, 658),
        Offset(916, 710),
        Offset(908, 750),
      ],
      width: 17,
    ),

    // North connector (from main road to stadium outer road)
    CampusMapRoad(
      id: 'north_stadium_connector',
      name: '',
      points: [
        Offset(920, 228),
        Offset(940, 258),
        Offset(950, 296),
        Offset(952, 336),
        Offset(952, 348),
        Offset(920, 320),
        Offset(882, 298),
        Offset(838, 286),
        Offset(792, 288),
        Offset(754, 298),
        Offset(722, 318),
        Offset(706, 342),
        Offset(710, 370),
        Offset(710, 406),
      ],
      width: 14,
    ),

    // Hostel north access spur
    CampusMapRoad(
      id: 'hostel_north_access',
      name: '',
      points: [
        Offset(978, 510),
        Offset(994, 516),
        Offset(1010, 520),
      ],
      width: 11,
    ),

    // Hostel south access spur
    CampusMapRoad(
      id: 'hostel_south_access',
      name: '',
      points: [
        Offset(950, 608),
        Offset(968, 614),
        Offset(984, 620),
        Offset(1000, 624),
      ],
      width: 11,
    ),
  ];

  // ---------------------------------------------------------------------------
  // GROUNDS — elliptical areas (cricket, athletics track, OAT, north lawn)
  // ---------------------------------------------------------------------------
  static const List<CampusMapGround> grounds = [
    CampusMapGround(
      id: 'cricket_ground',
      label: 'Cricket Ground',
      center: Offset(308, 268),
      width: 164,
      height: 178,
      style: CampusGroundStyle.cricket,
    ),
    CampusMapGround(
      id: 'open_air_theatre',
      label: 'Open Air Theatre',
      center: Offset(520, 432),
      width: 72,
      height: 66,
      style: CampusGroundStyle.theatre,
    ),
    CampusMapGround(
      id: 'large_sports_ground',
      label: 'Sports Ground',
      center: Offset(810, 516),
      width: 228,
      height: 272,
      style: CampusGroundStyle.athleticsTrack,
    ),
    CampusMapGround(
      id: 'north_lawn',
      label: '',
      center: Offset(572, 200),
      width: 168,
      height: 86,
      style: CampusGroundStyle.lawn,
    ),
  ];

  // ---------------------------------------------------------------------------
  // BUILDINGS — precise footprints traced from the reference image
  // ---------------------------------------------------------------------------
  static const List<CampusMapBuilding> buildings = [
    // ── MAIN ACADEMIC BLOCK (MA College of Engineering) ──
    // West wing
    CampusMapBuilding(
      id: 'main_block_west_wing',
      placeId: 'main_block',
      height: 20,
      footprint: [
        Offset(444, 268),
        Offset(476, 248),
        Offset(528, 268),
        Offset(520, 290),
        Offset(488, 308),
        Offset(462, 296),
      ],
    ),
    // Central wing (taller)
    CampusMapBuilding(
      id: 'main_block_central_wing',
      placeId: 'main_block',
      height: 22,
      footprint: [
        Offset(496, 292),
        Offset(532, 270),
        Offset(582, 290),
        Offset(574, 318),
        Offset(546, 336),
        Offset(512, 322),
      ],
    ),
    // East wing
    CampusMapBuilding(
      id: 'main_block_east_wing',
      placeId: 'main_block',
      height: 20,
      footprint: [
        Offset(568, 316),
        Offset(596, 292),
        Offset(642, 308),
        Offset(658, 336),
        Offset(630, 356),
        Offset(596, 346),
      ],
    ),
    // South connector
    CampusMapBuilding(
      id: 'main_block_south',
      placeId: 'main_block',
      height: 18,
      footprint: [
        Offset(524, 336),
        Offset(560, 322),
        Offset(608, 342),
        Offset(600, 370),
        Offset(566, 384),
        Offset(530, 370),
      ],
    ),

    // ── NORTH EAST BUILDINGS (top right area near school) ──
    CampusMapBuilding(
      id: 'ne_building_west',
      height: 16,
      footprint: [
        Offset(752, 14),
        Offset(790, 8),
        Offset(796, 118),
        Offset(762, 124),
      ],
    ),
    CampusMapBuilding(
      id: 'ne_building_east',
      height: 16,
      footprint: [
        Offset(872, 56),
        Offset(912, 62),
        Offset(910, 208),
        Offset(880, 214),
      ],
    ),

    // ── SMALL BUILDINGS AROUND MAIN BLOCK ──
    CampusMapBuilding(
      id: 'campus_building_01',
      height: 13,
      footprint: [
        Offset(456, 338),
        Offset(486, 320),
        Offset(516, 334),
        Offset(508, 356),
        Offset(476, 366),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_02',
      height: 13,
      footprint: [
        Offset(626, 258),
        Offset(652, 242),
        Offset(682, 256),
        Offset(672, 280),
        Offset(644, 286),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_03',
      height: 13,
      footprint: [
        Offset(688, 304),
        Offset(712, 284),
        Offset(744, 300),
        Offset(736, 326),
        Offset(710, 332),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_04',
      height: 13,
      footprint: [
        Offset(656, 350),
        Offset(682, 334),
        Offset(710, 348),
        Offset(702, 372),
        Offset(674, 378),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_05',
      height: 12,
      footprint: [
        Offset(572, 412),
        Offset(602, 396),
        Offset(630, 412),
        Offset(620, 436),
        Offset(588, 442),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_06',
      height: 12,
      footprint: [
        Offset(604, 446),
        Offset(632, 430),
        Offset(658, 444),
        Offset(650, 470),
        Offset(622, 476),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_07',
      height: 12,
      footprint: [
        Offset(540, 456),
        Offset(568, 442),
        Offset(594, 456),
        Offset(586, 480),
        Offset(558, 486),
      ],
    ),

    // ── LADIES HOSTEL ──
    CampusMapBuilding(
      id: 'ladies_hostel',
      placeId: 'ladies_hostel',
      height: 18,
      hostel: true,
      footprint: [
        Offset(114, 446),
        Offset(160, 422),
        Offset(232, 444),
        Offset(252, 470),
        Offset(224, 492),
        Offset(158, 478),
      ],
    ),
    CampusMapBuilding(
      id: 'ladies_hostel_annex',
      height: 12,
      hostel: true,
      footprint: [
        Offset(176, 490),
        Offset(218, 484),
        Offset(270, 504),
        Offset(262, 528),
        Offset(218, 524),
      ],
    ),

    // ── CANTEEN ──
    CampusMapBuilding(
      id: 'canteen',
      placeId: 'canteen',
      height: 13,
      footprint: [
        Offset(352, 424),
        Offset(386, 406),
        Offset(426, 422),
        Offset(418, 452),
        Offset(380, 464),
        Offset(348, 448),
      ],
    ),

    // ── HYDRAULIC MACHINES LAB ──
    CampusMapBuilding(
      id: 'hydraulic_lab',
      placeId: 'hydraulic_lab',
      height: 17,
      footprint: [
        Offset(492, 498),
        Offset(534, 480),
        Offset(582, 496),
        Offset(574, 530),
        Offset(536, 548),
        Offset(498, 532),
      ],
    ),

    // ── HEAT ENGINES LAB ──
    CampusMapBuilding(
      id: 'heat_engines_lab',
      placeId: 'heat_engines_lab',
      height: 17,
      footprint: [
        Offset(430, 578),
        Offset(470, 556),
        Offset(530, 578),
        Offset(520, 618),
        Offset(476, 636),
        Offset(436, 616),
      ],
    ),

    // ── PG BLOCK ──
    CampusMapBuilding(
      id: 'pg_block',
      placeId: 'pg_block',
      height: 17,
      footprint: [
        Offset(484, 672),
        Offset(514, 652),
        Offset(556, 668),
        Offset(564, 696),
        Offset(532, 718),
        Offset(492, 706),
      ],
    ),

    // ── MEN'S HOSTELS (right side) ──
    CampusMapBuilding(
      id: 'hostel_west',
      placeId: 'mens_hostel',
      height: 17,
      hostel: true,
      footprint: [
        Offset(1002, 494),
        Offset(1038, 480),
        Offset(1054, 562),
        Offset(1022, 580),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_central',
      height: 17,
      hostel: true,
      footprint: [
        Offset(1062, 508),
        Offset(1104, 514),
        Offset(1092, 578),
        Offset(1052, 572),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_east',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1114, 548),
        Offset(1154, 554),
        Offset(1170, 580),
        Offset(1124, 590),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_south',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1000, 618),
        Offset(1038, 606),
        Offset(1064, 630),
        Offset(1052, 668),
        Offset(1012, 658),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_south_east',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1082, 614),
        Offset(1114, 606),
        Offset(1142, 626),
        Offset(1126, 658),
        Offset(1090, 650),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // LABELS — positioned to match the reference image exactly
  // ---------------------------------------------------------------------------
  static const List<CampusMapLabel> labels = [
    CampusMapLabel(
      id: 'road_kozhippilly',
      text: 'Kozhippilly – College Junction Road',
      position: Offset(546, 160),
      rotation: 0.33,
    ),
    CampusMapLabel(
      id: 'road_kozhippilly_east',
      text: 'Kozhippilly – College Junction Road',
      position: Offset(1006, 222),
      rotation: -0.15,
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'road_hostels',
      text: 'MACE Hostels Road',
      position: Offset(962, 544),
      rotation: -1.34,
    ),
    CampusMapLabel(
      id: 'cricket_ground',
      text: 'Cricket\nGround',
      position: Offset(308, 268),
    ),
    CampusMapLabel(
      id: 'main_block',
      text: 'MA College\nof Engineering',
      position: Offset(554, 310),
    ),
    CampusMapLabel(
      id: 'ladies_hostel',
      text: 'Ladies Hostel',
      position: Offset(184, 458),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'canteen',
      text: 'Canteen',
      position: Offset(386, 436),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'open_air_theatre',
      text: 'Open Air\nTheatre',
      position: Offset(520, 432),
    ),
    CampusMapLabel(
      id: 'hydraulic_lab',
      text: 'Hydraulic\nMachines Lab',
      position: Offset(540, 514),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'heat_engines_lab',
      text: 'Heat Engines Lab',
      position: Offset(480, 598),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'pg_block',
      text: 'PG Block',
      position: Offset(524, 692),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'sports_ground',
      text: 'Sports Ground',
      position: Offset(810, 516),
    ),
    CampusMapLabel(
      id: 'hostels',
      text: 'Hostels',
      position: Offset(1094, 596),
      keyLabel: false,
    ),
  ];
}
