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

  /// Hand-traced canvas coordinates based on the supplied campus map image.
  /// These are relative drawing units, not surveyed GPS coordinates.
  static const List<CampusMapRoad> roads = [
    CampusMapRoad(
      id: 'kozhippilly_college_junction',
      name: 'Kozhippilly – College Junction Road',
      points: [
        Offset(-30, -10),
        Offset(80, 6),
        Offset(190, 29),
        Offset(300, 56),
        Offset(410, 91),
        Offset(510, 129),
        Offset(610, 169),
        Offset(710, 207),
        Offset(800, 237),
        Offset(875, 251),
        Offset(934, 247),
        Offset(1002, 222),
        Offset(1095, 195),
        Offset(1210, 175),
      ],
      width: 22,
    ),
    CampusMapRoad(
      id: 'cricket_loop_road',
      name: '',
      points: [
        Offset(296, 161),
        Offset(349, 172),
        Offset(389, 202),
        Offset(411, 247),
        Offset(408, 296),
        Offset(385, 338),
        Offset(346, 362),
        Offset(294, 369),
        Offset(245, 357),
        Offset(207, 331),
        Offset(184, 290),
        Offset(183, 242),
        Offset(204, 199),
        Offset(244, 171),
        Offset(296, 161),
      ],
      width: 15,
    ),
    CampusMapRoad(
      id: 'north_access_road',
      name: '',
      points: [
        Offset(402, 67),
        Offset(414, 108),
        Offset(425, 151),
        Offset(434, 191),
        Offset(414, 220),
        Offset(411, 247),
      ],
      width: 13,
    ),
    CampusMapRoad(
      id: 'west_perimeter_road',
      name: '',
      points: [
        Offset(204, 199),
        Offset(167, 250),
        Offset(146, 300),
        Offset(136, 350),
        Offset(124, 388),
        Offset(130, 404),
        Offset(100, 420),
        Offset(65, 445),
        Offset(-20, 466),
      ],
      width: 14,
    ),
    CampusMapRoad(
      id: 'ladies_hostel_access',
      name: '',
      points: [
        Offset(130, 404),
        Offset(155, 416),
        Offset(190, 418),
        Offset(225, 420),
        Offset(248, 435),
        Offset(264, 454),
        Offset(284, 476),
      ],
      width: 12,
    ),
    CampusMapRoad(
      id: 'west_campus_road',
      name: '',
      points: [
        Offset(411, 247),
        Offset(420, 280),
        Offset(420, 320),
        Offset(430, 350),
        Offset(455, 378),
        Offset(464, 396),
        Offset(460, 430),
        Offset(460, 458),
      ],
      width: 15,
    ),
    CampusMapRoad(
      id: 'southwest_campus_road',
      name: '',
      points: [
        Offset(284, 476),
        Offset(307, 490),
        Offset(326, 518),
        Offset(320, 548),
        Offset(292, 566),
        Offset(350, 609),
        Offset(400, 644),
        Offset(440, 661),
      ],
      width: 13,
    ),
    CampusMapRoad(
      id: 'lab_access_road',
      name: '',
      points: [
        Offset(460, 458),
        Offset(450, 480),
        Offset(430, 515),
        Offset(414, 552),
        Offset(416, 585),
        Offset(428, 616),
        Offset(450, 649),
        Offset(440, 661),
        Offset(466, 680),
        Offset(470, 716),
        Offset(500, 742),
        Offset(550, 750),
        Offset(600, 744),
        Offset(650, 729),
        Offset(700, 705),
        Offset(731, 692),
        Offset(748, 681),
      ],
      width: 14,
    ),
    CampusMapRoad(
      id: 'stadium_outer_loop',
      name: '',
      points: [
        Offset(807, 350),
        Offset(871, 358),
        Offset(925, 388),
        Offset(959, 435),
        Offset(975, 481),
        Offset(963, 548),
        Offset(944, 605),
        Offset(912, 654),
        Offset(862, 682),
        Offset(804, 691),
        Offset(748, 681),
        Offset(701, 653),
        Offset(671, 607),
        Offset(656, 552),
        Offset(657, 497),
        Offset(673, 443),
        Offset(708, 394),
        Offset(755, 363),
        Offset(807, 350),
      ],
      width: 15,
    ),
    CampusMapRoad(
      id: 'mace_hostels_road',
      name: 'MACE Hostels Road',
      points: [
        Offset(942, 359),
        Offset(976, 365),
        Offset(977, 421),
        Offset(975, 481),
        Offset(966, 541),
        Offset(949, 596),
        Offset(930, 651),
        Offset(916, 710),
      ],
      width: 16,
    ),
    CampusMapRoad(
      id: 'hostel_north_access',
      name: '',
      points: [Offset(975, 481), Offset(986, 486), Offset(995, 491)],
      width: 11,
    ),
    CampusMapRoad(
      id: 'hostel_south_access',
      name: '',
      points: [
        Offset(949, 596),
        Offset(968, 600),
        Offset(983, 609),
        Offset(992, 611),
      ],
      width: 11,
    ),
    CampusMapRoad(
      id: 'oval_north_connector',
      name: '',
      points: [
        Offset(934, 247),
        Offset(953, 282),
        Offset(957, 321),
        Offset(942, 359),
        Offset(912, 330),
        Offset(871, 309),
        Offset(820, 303),
        Offset(770, 314),
        Offset(730, 333),
        Offset(710, 363),
        Offset(708, 394),
      ],
      width: 14,
    ),
  ];

  static const List<CampusMapGround> grounds = [
    CampusMapGround(
      id: 'cricket_ground',
      label: 'Cricket Ground',
      center: Offset(296, 267),
      width: 154,
      height: 170,
      style: CampusGroundStyle.cricket,
    ),
    CampusMapGround(
      id: 'open_air_theatre',
      label: 'Open Air Theatre',
      center: Offset(521, 432),
      width: 74,
      height: 69,
      style: CampusGroundStyle.theatre,
    ),
    CampusMapGround(
      id: 'large_sports_ground',
      label: 'MACE Sports Ground',
      center: Offset(807, 520),
      width: 222,
      height: 265,
      style: CampusGroundStyle.athleticsTrack,
    ),
    CampusMapGround(
      id: 'north_lawn',
      label: '',
      center: Offset(664, 254),
      width: 222,
      height: 117,
      style: CampusGroundStyle.lawn,
    ),
  ];

  static const List<CampusMapBuilding> buildings = [
    CampusMapBuilding(
      id: 'main_block_west_wing',
      placeId: 'main_block',
      height: 19,
      footprint: [
        Offset(440, 269),
        Offset(470, 250),
        Offset(526, 270),
        Offset(518, 291),
        Offset(485, 306),
        Offset(461, 294),
      ],
    ),
    CampusMapBuilding(
      id: 'main_block_central_wing',
      placeId: 'main_block',
      height: 21,
      footprint: [
        Offset(494, 294),
        Offset(531, 273),
        Offset(582, 294),
        Offset(572, 321),
        Offset(545, 338),
        Offset(511, 326),
      ],
    ),
    CampusMapBuilding(
      id: 'main_block_east_wing',
      placeId: 'main_block',
      height: 20,
      footprint: [
        Offset(568, 318),
        Offset(594, 291),
        Offset(638, 307),
        Offset(656, 335),
        Offset(627, 357),
        Offset(595, 348),
      ],
    ),
    CampusMapBuilding(
      id: 'engineering_south_wing',
      placeId: 'main_block',
      height: 18,
      footprint: [
        Offset(525, 337),
        Offset(560, 326),
        Offset(608, 346),
        Offset(599, 373),
        Offset(565, 388),
        Offset(532, 372),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_01',
      height: 13,
      footprint: [
        Offset(456, 337),
        Offset(485, 321),
        Offset(516, 334),
        Offset(505, 355),
        Offset(474, 365),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_02',
      height: 13,
      footprint: [
        Offset(627, 261),
        Offset(650, 246),
        Offset(681, 258),
        Offset(670, 282),
        Offset(643, 287),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_03',
      height: 12,
      footprint: [
        Offset(690, 306),
        Offset(712, 287),
        Offset(742, 302),
        Offset(734, 327),
        Offset(708, 334),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_04',
      height: 12,
      footprint: [
        Offset(658, 352),
        Offset(682, 337),
        Offset(708, 350),
        Offset(699, 372),
        Offset(674, 379),
      ],
    ),
    CampusMapBuilding(
      id: 'ladies_hostel',
      placeId: 'ladies_hostel',
      height: 18,
      hostel: true,
      footprint: [
        Offset(115, 448),
        Offset(159, 425),
        Offset(230, 447),
        Offset(250, 472),
        Offset(223, 494),
        Offset(158, 479),
      ],
    ),
    CampusMapBuilding(
      id: 'ladies_hostel_annex',
      height: 12,
      hostel: true,
      footprint: [
        Offset(178, 491),
        Offset(216, 486),
        Offset(269, 506),
        Offset(260, 529),
        Offset(217, 526),
      ],
    ),
    CampusMapBuilding(
      id: 'canteen',
      placeId: 'canteen',
      height: 12,
      footprint: [
        Offset(355, 425),
        Offset(388, 407),
        Offset(426, 423),
        Offset(417, 453),
        Offset(380, 465),
        Offset(350, 450),
      ],
    ),
    CampusMapBuilding(
      id: 'hydraulic_lab',
      placeId: 'hydraulic_lab',
      height: 17,
      footprint: [
        Offset(493, 500),
        Offset(534, 481),
        Offset(581, 497),
        Offset(572, 530),
        Offset(535, 549),
        Offset(499, 534),
      ],
    ),
    CampusMapBuilding(
      id: 'heat_engines_lab',
      placeId: 'heat_engines_lab',
      height: 17,
      footprint: [
        Offset(431, 579),
        Offset(470, 558),
        Offset(528, 580),
        Offset(518, 619),
        Offset(476, 637),
        Offset(438, 618),
      ],
    ),
    CampusMapBuilding(
      id: 'pg_block',
      placeId: 'pg_block',
      height: 16,
      footprint: [
        Offset(485, 674),
        Offset(512, 653),
        Offset(553, 670),
        Offset(563, 697),
        Offset(531, 720),
        Offset(494, 708),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_05',
      height: 12,
      footprint: [
        Offset(574, 413),
        Offset(601, 397),
        Offset(630, 413),
        Offset(620, 437),
        Offset(589, 443),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_06',
      height: 12,
      footprint: [
        Offset(606, 447),
        Offset(633, 432),
        Offset(658, 444),
        Offset(653, 470),
        Offset(625, 478),
      ],
    ),
    CampusMapBuilding(
      id: 'campus_building_07',
      height: 12,
      footprint: [
        Offset(543, 458),
        Offset(570, 444),
        Offset(594, 458),
        Offset(587, 480),
        Offset(559, 488),
      ],
    ),
    CampusMapBuilding(
      id: 'north_residence_west',
      height: 15,
      footprint: [
        Offset(749, 16),
        Offset(781, 7),
        Offset(789, 119),
        Offset(759, 123),
      ],
    ),
    CampusMapBuilding(
      id: 'north_residence_east',
      height: 15,
      footprint: [
        Offset(872, 58),
        Offset(911, 64),
        Offset(910, 208),
        Offset(881, 215),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_west',
      placeId: 'mens_hostel',
      height: 17,
      hostel: true,
      footprint: [
        Offset(1004, 496),
        Offset(1037, 480),
        Offset(1051, 563),
        Offset(1023, 582),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_central',
      height: 17,
      hostel: true,
      footprint: [
        Offset(1061, 508),
        Offset(1102, 515),
        Offset(1090, 577),
        Offset(1051, 570),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_east',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1114, 547),
        Offset(1153, 552),
        Offset(1168, 579),
        Offset(1123, 589),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_south',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1002, 620),
        Offset(1038, 609),
        Offset(1064, 632),
        Offset(1052, 670),
        Offset(1014, 660),
      ],
    ),
    CampusMapBuilding(
      id: 'hostel_south_east',
      height: 14,
      hostel: true,
      footprint: [
        Offset(1080, 616),
        Offset(1113, 607),
        Offset(1141, 626),
        Offset(1125, 657),
        Offset(1091, 651),
      ],
    ),
  ];

  static const List<CampusMapLabel> labels = [
    CampusMapLabel(
      id: 'road_kozhippilly',
      text: 'Kozhippilly – College Junction Road',
      position: Offset(566, 149),
      rotation: 0.34,
    ),
    CampusMapLabel(
      id: 'road_hostels',
      text: 'MACE Hostels Road',
      position: Offset(962, 543),
      rotation: -1.34,
    ),
    CampusMapLabel(
      id: 'cricket_ground',
      text: 'Cricket Ground',
      position: Offset(296, 267),
    ),
    CampusMapLabel(
      id: 'main_block',
      text: 'MA College of Engineering',
      position: Offset(555, 207),
    ),
    CampusMapLabel(
      id: 'ladies_hostel',
      text: 'Ladies Hostel',
      position: Offset(184, 394),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'canteen',
      text: 'Canteen',
      position: Offset(386, 481),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'open_air_theatre',
      text: 'Open Air Theatre',
      position: Offset(521, 432),
    ),
    CampusMapLabel(
      id: 'hydraulic_lab',
      text: 'Hydraulic Machines Lab',
      position: Offset(580, 570),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'heat_engines_lab',
      text: 'Heat Engines Lab',
      position: Offset(590, 610),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'pg_block',
      text: 'PG Block',
      position: Offset(580, 720),
      keyLabel: false,
    ),
    CampusMapLabel(
      id: 'sports_ground',
      text: 'Sports Ground',
      position: Offset(807, 520),
    ),
    CampusMapLabel(
      id: 'hostels',
      text: 'Hostels',
      position: Offset(1094, 594),
      keyLabel: false,
    ),
  ];
}
