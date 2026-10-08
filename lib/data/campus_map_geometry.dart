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
    // Cricket Ground — oval, left-center of campus
    CampusMapGround(
      id: 'cricket_ground',
      label: 'Cricket Ground',
      center: Offset(278, 268),
      width: 178,
      height: 190,
      style: CampusGroundStyle.cricket,
    ),
    // Open Air Theatre — semi-circular, center campus
    CampusMapGround(
      id: 'open_air_theatre',
      label: 'Open Air Theatre',
      center: Offset(466, 418),
      width: 74,
      height: 62,
      style: CampusGroundStyle.theatre,
    ),
    // Athletics / Sports Ground — large oval on right
    CampusMapGround(
      id: 'large_sports_ground',
      label: 'Sports Ground',
      center: Offset(738, 492),
      width: 240,
      height: 256,
      style: CampusGroundStyle.athleticsTrack,
    ),
    // North courtyard / lawn between Main Block wings
    CampusMapGround(
      id: 'north_lawn',
      label: '',
      center: Offset(582, 210),
      width: 120,
      height: 74,
      style: CampusGroundStyle.lawn,
    ),
  ];

  // ---------------------------------------------------------------------------
  // BUILDINGS — precise footprints traced from the reference aerial image
  // Canvas: 1179 x 768.  Reference image displayed at ~1030 x 770.
  // ---------------------------------------------------------------------------
  static const List<CampusMapBuilding> buildings = [

    // MAIN ACADEMIC BLOCK — large H-shaped complex, center of campus
    CampusMapBuilding(
      id: 'main_block_west',
      placeId: 'main_block',
      height: 22,
      footprint: [
        Offset(448, 242),
        Offset(500, 220),
        Offset(544, 238),
        Offset(536, 270),
        Offset(490, 288),
        Offset(452, 270),
      ],
    ),
    CampusMapBuilding(
      id: 'main_block_central',
      placeId: 'main_block',
      height: 26,
      footprint: [
        Offset(494, 268),
        Offset(550, 244),
        Offset(598, 264),
        Offset(592, 304),
        Offset(546, 322),
        Offset(504, 304),
      ],
    ),
    CampusMapBuilding(
      id: 'main_block_east',
      placeId: 'main_block',
      height: 22,
      footprint: [
        Offset(582, 300),
        Offset(624, 278),
        Offset(672, 296),
        Offset(678, 330),
        Offset(640, 350),
        Offset(598, 334),
      ],
    ),
    CampusMapBuilding(
      id: 'main_block_south',
      placeId: 'main_block',
      height: 18,
      footprint: [
        Offset(516, 318),
        Offset(562, 302),
        Offset(598, 318),
        Offset(592, 350),
        Offset(552, 366),
        Offset(520, 350),
      ],
    ),

    // SEMINAR HALL — right of Main Block
    CampusMapBuilding(
      id: 'seminar_hall',
      placeId: 'seminar_hall',
      height: 18,
      footprint: [
        Offset(668, 286),
        Offset(718, 266),
        Offset(754, 282),
        Offset(748, 316),
        Offset(704, 332),
        Offset(670, 318),
      ],
    ),

    // LIBRARY — east of Seminar Hall
    CampusMapBuilding(
      id: 'library',
      placeId: 'library',
      height: 18,
      footprint: [
        Offset(754, 272),
        Offset(806, 254),
        Offset(836, 268),
        Offset(832, 302),
        Offset(790, 316),
        Offset(758, 304),
      ],
    ),

    // NORTH-EAST large buildings (top-right, near school boundary)
    CampusMapBuilding(
      id: 'ne_block_west',
      height: 18,
      footprint: [
        Offset(812, 16),
        Offset(850, 6),
        Offset(858, 136),
        Offset(820, 144),
      ],
    ),
    CampusMapBuilding(
      id: 'ne_block_east',
      height: 18,
      footprint: [
        Offset(920, 52),
        Offset(958, 58),
        Offset(960, 194),
        Offset(924, 200),
      ],
    ),

    // UNNAMED CAMPUS BLOCKS around main block / inner spine
    CampusMapBuilding(
      id: 'campus_bldg_01',
      height: 14,
      footprint: [
        Offset(460, 346),
        Offset(500, 330),
        Offset(526, 344),
        Offset(520, 368),
        Offset(484, 380),
        Offset(462, 368),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_bldg_02',
      height: 14,
      footprint: [
        Offset(644, 244),
        Offset(678, 232),
        Offset(706, 244),
        Offset(698, 270),
        Offset(668, 278),
        Offset(646, 266),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_bldg_03',
      height: 14,
      footprint: [
        Offset(714, 282),
        Offset(750, 268),
        Offset(774, 280),
        Offset(768, 306),
        Offset(736, 318),
        Offset(716, 308),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_bldg_04',
      height: 12,
      footprint: [
        Offset(576, 390),
        Offset(614, 376),
        Offset(638, 388),
        Offset(632, 412),
        Offset(598, 422),
        Offset(578, 412),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_bldg_05',
      height: 12,
      footprint: [
        Offset(538, 448),
        Offset(574, 436),
        Offset(600, 448),
        Offset(594, 472),
        Offset(560, 480),
        Offset(540, 470),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_bldg_06',
      height: 12,
      footprint: [
        Offset(608, 432),
        Offset(642, 420),
        Offset(664, 432),
        Offset(658, 456),
        Offset(626, 466),
        Offset(610, 454),
      ],
    ),

    // LADIES HOSTEL — far-left complex
    CampusMapBuilding(
      id: 'ladies_hostel_a',
      placeId: 'ladies_hostel',
      height: 18,
      hostel: true,
      footprint: [
        Offset(98,  416),
        Offset(152, 392),
        Offset(218, 412),
        Offset(226, 440),
        Offset(194, 460),
        Offset(130, 446),
      ],
    ),
    CampusMapBuilding(
      id: 'ladies_hostel_b',
      height: 14,
      hostel: true,
      footprint: [
        Offset(136, 454),
        Offset(192, 444),
        Offset(244, 462),
        Offset(238, 490),
        Offset(188, 502),
        Offset(138, 484),
      ],
    ),

    // CANTEEN — left of Open Air Theatre
    CampusMapBuilding(
      id: 'canteen',
      placeId: 'canteen',
      height: 14,
      footprint: [
        Offset(326, 398),
        Offset(368, 380),
        Offset(412, 396),
        Offset(406, 428),
        Offset(366, 444),
        Offset(328, 428),
      ],
    ),

    // HYDRAULIC MACHINES LAB — below Open Air Theatre
    CampusMapBuilding(
      id: 'hydraulic_lab',
      placeId: 'hydraulic_lab',
      height: 18,
      footprint: [
        Offset(470, 468),
        Offset(518, 448),
        Offset(566, 466),
        Offset(558, 502),
        Offset(514, 520),
        Offset(472, 502),
      ],
    ),

    // HEAT ENGINES LAB — below Hydraulic Lab
    CampusMapBuilding(
      id: 'heat_engines_lab',
      placeId: 'heat_engines_lab',
      height: 18,
      footprint: [
        Offset(432, 546),
        Offset(476, 526),
        Offset(530, 546),
        Offset(522, 580),
        Offset(476, 598),
        Offset(434, 580),
      ],
    ),

    // PG BLOCK — bottom center
    CampusMapBuilding(
      id: 'pg_block',
      placeId: 'pg_block',
      height: 18,
      footprint: [
        Offset(400, 636),
        Offset(440, 616),
        Offset(498, 636),
        Offset(494, 668),
        Offset(456, 688),
        Offset(404, 670),
      ],
    ),

    // MEN'S HOSTELS — right-side cluster
    CampusMapBuilding(
      id: 'hostel_block_a',
      placeId: 'mens_hostel',
      height: 18,
      hostel: true,
      footprint: [
        Offset(988, 464),
        Offset(1026, 456),
        Offset(1044, 528),
        Offset(1010, 540),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_block_b',
      height: 16,
      hostel: true,
      footprint: [
        Offset(1044, 482),
        Offset(1082, 488),
        Offset(1076, 558),
        Offset(1040, 552),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_block_c',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1062, 542),
        Offset(1104, 548),
        Offset(1098, 604),
        Offset(1058, 598),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_block_south',
      height: 14,
      hostel: true,
      footprint: [
        Offset(978, 572),
        Offset(1018, 560),
        Offset(1044, 580),
        Offset(1034, 624),
        Offset(992, 618),
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // LABELS — positions matched precisely to reference image
  // ---------------------------------------------------------------------------
  static const List<CampusMapLabel> labels = [
    // Road labels
    CampusMapLabel(
      id: 'road_kozhippilly_west',
      text: 'Kozhippilly – College Junction Road',
      position: Offset(464, 112),
      rotation: 0.30,
    ),
    CampusMapLabel(
      id: 'road_kozhippilly_east',
      text: 'Kozhippilly – College Junction Road',
      position: Offset(984, 208),
      rotation: -0.14,
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'road_mace_hostels',
      text: 'MACE Hostels Road',
      position: Offset(940, 500),
      rotation: -1.35,
    ),

    // Campus landmark labels
    CampusMapLabel(
      id: 'lbl_parking_lot',
      text: 'Parking Lot',
      position: Offset(330, 148),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_main_gate',
      text: 'Main Gate',
      position: Offset(432, 188),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_cricket_ground',
      text: 'Cricket\nGround',
      position: Offset(278, 264),
    ),
    CampusMapLabel(
      id: 'lbl_main_block',
      text: 'Main Block',
      position: Offset(534, 268),
    ),
    CampusMapLabel(
      id: 'lbl_seminar_hall',
      text: 'Seminar Hall',
      position: Offset(694, 296),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_library',
      text: 'Library',
      position: Offset(782, 284),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_ladies_hostel',
      text: 'Ladies Hostel',
      position: Offset(172, 418),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_canteen',
      text: 'Canteen',
      position: Offset(336, 380),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_open_air_theatre',
      text: 'Open Air\nTheatre',
      position: Offset(432, 402),
    ),
    CampusMapLabel(
      id: 'lbl_parking_lot_east',
      text: 'Parking Lot',
      position: Offset(596, 440),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_hydraulic_lab',
      text: 'Hydraulic\nMachines Lab',
      position: Offset(490, 454),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_heat_engines_lab',
      text: 'Heat Engines Lab',
      position: Offset(462, 526),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_pg_block',
      text: 'PG Block',
      position: Offset(440, 622),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'lbl_hostels',
      text: 'Hostels',
      position: Offset(1010, 492),
      keyLabel: false,
    ),
  ];
}
