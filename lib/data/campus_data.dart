import 'package:flutter/material.dart';

import '../models/place.dart';
import '../models/navigation.dart';

/// Central repository of campus data for Mar Athanasius College of Engineering (MACE)
///
/// NOTE FOR DEVELOPERS / STUDENTS:
/// - To add or edit places: Update [campusPlaces] below.
/// - To edit walkways: Update [campusWalkNodes] and [campusWalkEdges].
/// - Campus plane coordinates (campusX, campusY) are normalized to a 0.0 to 1000.0 grid.
/// - Geographic coordinates (approxLat, approxLng) are approximate coordinates centered
///   around MACE Kothamangalam (~10.0538° N, 76.6193° E).
class CampusData {
  CampusData._();

  /// Campus center geographic anchor (MACE Kothamangalam)
  static const double centerLat = 10.05383;
  static const double centerLng = 10.05383 == 0 ? 76.61935 : 76.61935;

  /// Bounding geographic box for coordinate projection
  static const double minLat = 10.0495;
  static const double maxLat = 10.0580;
  static const double minLng = 76.6145;
  static const double maxLng = 76.6235;

  /// Convert GPS (lat, lng) to canvas (campusX, campusY)
  static Offset gpsToCanvas(double lat, double lng) {
    final normX = (lng - minLng) / (maxLng - minLng);
    // Invert Y because latitude increases North, whereas canvas Y increases Downwards (South)
    final normY = 1.0 - ((lat - minLat) / (maxLat - minLat));
    return Offset(
      normX.clamp(0.0, 1.0) * 1000.0,
      normY.clamp(0.0, 1.0) * 1000.0,
    );
  }

  /// Convert canvas (campusX, campusY) to GPS (lat, lng)
  static (double lat, double lng) canvasToGps(double campusX, double campusY) {
    final normX = (campusX / 1000.0).clamp(0.0, 1.0);
    final normY = (campusY / 1000.0).clamp(0.0, 1.0);
    final lng = minLng + normX * (maxLng - minLng);
    final lat = minLat + (1.0 - normY) * (maxLat - minLat);
    return (lat, lng);
  }

  // ===========================================================================
  // CAMPUS BUILDINGS AND LANDMARKS
  // ===========================================================================
  static final List<CampusPlace> campusPlaces = [
    // -------------------------------------------------------------------------
    // 1. MACE MAIN ADMINISTRATIVE & ACADEMIC BLOCK
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'main_block',
      name: 'Main Academic & Admin Block',
      shortCode: 'MB',
      category: PlaceCategory.academic,
      description: 'Historic main college building housing Principal & Dean offices, Central Administration, Civil & Mechanical departments, and College Auditorium.',
      approxLat: 10.05490,
      approxLng: 10.05490 == 0 ? 76.61935 : 76.61940,
      campusX: 580,
      campusY: 270,
      width: 140,
      length: 80,
      height: 38,
      rotationDeg: -10,
      roofColor: Color(0xFFC2410C), // Characteristic MACE Terracotta Red Roof
      wallColor: Color(0xFFFDE68A),
      walkwayNodeId: 'node_main_block',
      searchKeywords: [
        'principal',
        'dean',
        'office',
        'civil',
        'mechanical',
        'auditorium',
        'admin',
        'accounts',
        'exam cell',
        'seminar hall',
      ],
      facilities: [
        'Wi-Fi',
        'Restrooms',
        'RO Water',
        'Ramp Access',
        'Notice Boards',
      ],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'Principal Office',
            'College Administration & Accounts',
            'Dean of Academics Office',
            'Main College Auditorium',
            'Civil Engineering Staff Room',
          ],
        ),
        FloorInfo(
          level: 1,
          floorName: 'First Floor',
          rooms: [
            'Mechanical Engineering Department',
            'HOD Mechanical Office',
            'Faculty Rooms (Civil & Mech)',
            'Lecture Halls 101 – 108',
            'Conference Room',
          ],
        ),
        FloorInfo(
          level: 2,
          floorName: 'Second Floor',
          rooms: [
            'Civil CAD Design Lab',
            'Fluid Machinery Seminar Hall',
            'Classrooms 201 – 210',
            'Exam Cell & Evaluation Wing',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 2. ELECTRONICS & COMMUNICATION (EC) BLOCK
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'ec_block',
      name: 'Electronics & Communication (EC) Block',
      shortCode: 'EC',
      category: PlaceCategory.academic,
      description: 'Dedicated block for the Department of Electronics and Communication Engineering with advanced hardware labs and smart seminar rooms.',
      approxLat: 10.05260,
      approxLng: 10.05260 == 0 ? 76.61860 : 76.61855,
      campusX: 430,
      campusY: 690,
      width: 80,
      length: 60,
      height: 30,
      rotationDeg: 5,
      roofColor: Color(0xFF1E3A8A),
      wallColor: Color(0xFFE2E8F0),
      walkwayNodeId: 'node_ec_block',
      searchKeywords: [
        'ec',
        'electronics',
        'communication',
        'vlsi',
        'dsp',
        'iot',
        'embedded',
        'hod ec',
        'hardware lab',
      ],
      facilities: ['Wi-Fi', 'Restrooms', 'Drinking Water', 'Smart Classrooms'],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'EC Department Office & HOD Cabin',
            'Electronic Devices & Circuits Lab',
            'Digital Electronics Lab',
            'EC Seminar Hall',
          ],
        ),
        FloorInfo(
          level: 1,
          floorName: 'First Floor',
          rooms: [
            'VLSI & Embedded Systems Research Lab',
            'DSP & Image Processing Lab',
            'Classrooms EC 101 – 104',
            'Faculty Cubicles',
          ],
        ),
        FloorInfo(
          level: 2,
          floorName: 'Second Floor',
          rooms: [
            'Microwave & Optical Fiber Lab',
            'IoT & Robotics Innovation Lab',
            'Department Library',
            'Classrooms EC 201 – 204',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 3. HYDRAULIC MACHINES LAB BLOCK
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'hydraulic_lab',
      name: 'Hydraulic Machines Lab',
      shortCode: 'HL',
      category: PlaceCategory.lab,
      description: 'Mechanical Engineering fluid dynamics testing laboratory with heavy-duty Francis and Pelton turbines, pumps, and flumes.',
      approxLat: 10.05320,
      approxLng: 10.05320 == 0 ? 76.61945 : 76.61950,
      campusX: 560,
      campusY: 580,
      width: 85,
      length: 55,
      height: 24,
      rotationDeg: 12,
      roofColor: Color(0xFF0F766E),
      wallColor: Color(0xFFCBD5E1),
      walkwayNodeId: 'node_hydraulic_lab',
      searchKeywords: [
        'hydraulics',
        'hydraulic machines',
        'fluid mechanics',
        'turbines',
        'pumps',
        'mechanical lab',
      ],
      facilities: ['Safety Showers', 'First Aid Station', 'Restrooms'],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'Pelton Wheel Turbine Rig',
            'Francis Turbine Test Section',
            'Centrifugal & Reciprocating Pump Benches',
            'Open Channel Flow Flume',
            'Lab Instructor Office',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 4. HEAT ENGINES LAB
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'heat_engines_lab',
      name: 'Heat Engines & Thermal Lab',
      shortCode: 'HE',
      category: PlaceCategory.lab,
      description: 'Advanced internal combustion engine test rigs, emissions analyzer, refrigeration test benches, and heat transfer labs.',
      approxLat: 10.05250,
      approxLng: 10.05250 == 0 ? 76.61940 : 76.61945,
      campusX: 550,
      campusY: 680,
      width: 75,
      length: 50,
      height: 22,
      rotationDeg: 10,
      roofColor: Color(0xFFB45309),
      wallColor: Color(0xFFE2E8F0),
      walkwayNodeId: 'node_heat_engines',
      searchKeywords: [
        'heat engines',
        'thermal',
        'ic engines',
        'automobile',
        'refrigeration',
        'mechanical workshop',
      ],
      facilities: ['Exhaust Ventilation', 'Fire Safety Rig', 'Restrooms'],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'Multi-cylinder Petrol & Diesel Engine Test Bed',
            'Gas Turbine Simulation Bench',
            'Refrigeration & Air Conditioning Rig',
            'Emissions Testing Bay',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 5. POSTGRADUATE (PG) BLOCK & CENTRAL LIBRARY
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'pg_block',
      name: 'PG Block & Research Center',
      shortCode: 'PG',
      category: PlaceCategory.academic,
      description: 'Multi-story modern complex hosting postgraduate M.Tech courses, doctoral research labs, and college digital repository.',
      approxLat: 10.05170,
      approxLng: 10.05170 == 0 ? 76.61960 : 76.61965,
      campusX: 550,
      campusY: 810,
      width: 90,
      length: 65,
      height: 34,
      rotationDeg: 0,
      roofColor: Color(0xFF4338CA),
      wallColor: Color(0xFFF1F5F9),
      walkwayNodeId: 'node_pg_block',
      searchKeywords: [
        'pg',
        'postgraduate',
        'mtech',
        'phd',
        'research',
        'library',
        'data science',
        'ai lab',
      ],
      facilities: [
        'High-speed Wi-Fi',
        'Air-conditioned Labs',
        'Elevator',
        'Restrooms',
      ],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'M.Tech Computer Science Lab',
            'AI & Deep Learning Computing Facility',
            'PG Dean & Coordinator Office',
          ],
        ),
        FloorInfo(
          level: 1,
          floorName: 'First Floor',
          rooms: [
            'Advanced Power Systems Lab',
            'Structural Engineering Research Bay',
            'PG Lecture Halls PG 101 – 104',
          ],
        ),
        FloorInfo(
          level: 2,
          floorName: 'Second Floor',
          rooms: [
            'PG Digital Library & Journal Reading Room',
            'Ph.D. Scholars Research Cubicles',
            'PG Conference Hall',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 6. LADIES HOSTEL
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'ladies_hostel',
      name: 'Ladies Hostel Campus',
      shortCode: 'LH',
      category: PlaceCategory.hostel,
      description: 'Secured on-campus residential facility for female students with dining mess, study halls, and 24/7 security.',
      approxLat: 10.05350,
      approxLng: 10.05350 == 0 ? 76.61740 : 76.61735,
      campusX: 320,
      campusY: 560,
      width: 70,
      length: 60,
      height: 26,
      rotationDeg: -5,
      roofColor: Color(0xFF7E22CE),
      wallColor: Color(0xFFF3E8FF),
      walkwayNodeId: 'node_ladies_hostel',
      searchKeywords: ['hostel', 'ladies', 'girls hostel', 'mess', 'residence'],
      facilities: ['24/7 Security', 'Mess Hall', 'Study Hall', 'Wi-Fi'],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'Warden Office',
            'Central Dining Mess',
            'Visitors Lounge',
            'Recreation Room',
          ],
        ),
        FloorInfo(
          level: 1,
          floorName: 'First & Second Floors',
          rooms: ['Student Living Quarters', 'Quiet Reading Rooms'],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 7. MEN\'S HOSTELS (HS-I & HS-II)
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'mens_hostel',
      name: 'Men\'s Hostels (HS-I & HS-II)',
      shortCode: 'MH',
      category: PlaceCategory.hostel,
      description: 'Multi-wing residence halls for male students located along MACE Hostels Road, featuring badminton courts and cafeteria.',
      approxLat: 10.05370,
      approxLng: 10.05370 == 0 ? 76.62250 : 76.62255,
      campusX: 850,
      campusY: 550,
      width: 80,
      length: 55,
      height: 26,
      rotationDeg: 0,
      roofColor: Color(0xFF6B21A8),
      wallColor: Color(0xFFFAF5FF),
      walkwayNodeId: 'node_mens_hostel',
      searchKeywords: ['hostel', 'mens', 'hs 1', 'hs 2', 'boys hostel', 'mess'],
      facilities: ['Hostel Mess', 'Badminton Court', 'Wi-Fi', 'Common Room'],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'HS-I & HS-II Mess Halls',
            'Warden Cabin',
            'Common Room & TV Lounge',
          ],
        ),
        FloorInfo(
          level: 1,
          floorName: 'Upper Floors',
          rooms: ['Student Rooms (Blocks A, B, C)', 'Study Halls'],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 8. CAMPUS CANTEEN & STUDENT AMENITIES
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'canteen',
      name: 'Campus Canteen & Cafeteria',
      shortCode: 'CN',
      category: PlaceCategory.amenity,
      description: 'Popular student hub offering South Indian meals, snacks, fresh juices, and stationery/co-operative store.',
      approxLat: 10.05390,
      approxLng: 10.05390 == 0 ? 76.61870 : 76.61875,
      campusX: 490,
      campusY: 490,
      width: 60,
      length: 45,
      height: 18,
      rotationDeg: 0,
      roofColor: Color(0xFFEA580C),
      wallColor: Color(0xFFFFF7ED),
      walkwayNodeId: 'node_canteen',
      searchKeywords: [
        'canteen',
        'food',
        'cafeteria',
        'coffee',
        'tea',
        'snacks',
        'stationery',
        'store',
      ],
      facilities: [
        'Indoor Dining',
        'Takeaway Counter',
        'Drinking Water',
        'Restrooms',
      ],
      floors: [
        FloorInfo(
          level: 0,
          floorName: 'Ground Floor',
          rooms: [
            'Student Dining Hall',
            'Staff Dining Section',
            'Snack Counter',
            'Co-operative Stationery',
          ],
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // LANDMARK 1: PROFESSOR MP VARGHESE STATUE
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'statue',
      name: 'Prof. M.P. Varghese Statue',
      shortCode: 'MPV',
      category: PlaceCategory.landmark,
      isLandmark: true,
      description: 'Iconic statue honoring the visionary founder of Mar Athanasius College Association, located at the heart of the main entrance avenue.',
      approxLat: 10.05530,
      approxLng: 10.05530 == 0 ? 76.61890 : 76.61885,
      campusX: 520,
      campusY: 200,
      width: 35,
      length: 35,
      height: 16,
      roofColor: Color(0xFFDC2626),
      wallColor: Color(0xFFFEF2F2),
      walkwayNodeId: 'node_statue',
      searchKeywords: [
        'statue',
        'founder',
        'mp varghese',
        'landmark',
        'monument',
        'circle',
      ],
      facilities: ['Garden Benches', 'Lighting', 'Photo Point'],
    ),

    // -------------------------------------------------------------------------
    // LANDMARK 2: CRICKET GROUND
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'cricket_ground',
      name: 'College Cricket Ground',
      shortCode: 'CG',
      category: PlaceCategory.sports,
      isLandmark: true,
      description: 'Expansive natural turf cricket ground surrounded by scenic greenery, equipped with a central turf pitch and spectator pavilions.',
      approxLat: 10.05430,
      approxLng: 10.05430 == 0 ? 76.61810 : 76.61815,
      campusX: 420,
      campusY: 440,
      width: 110,
      length: 140,
      height: 8,
      roofColor: Color(0xFF15803D),
      wallColor: Color(0xFFDCFCE7),
      walkwayNodeId: 'node_cricket',
      searchKeywords: [
        'cricket',
        'ground',
        'pitch',
        'sports',
        'pavilion',
        'matches',
      ],
      facilities: ['Turf Pitch', 'Practice Nets', 'Pavilion Seating'],
    ),

    // -------------------------------------------------------------------------
    // LANDMARK 3: MAR ATHANASIUS COLLEGE STADIUM
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'stadium',
      name: 'Mar Athanasius College Stadium',
      shortCode: 'STD',
      category: PlaceCategory.sports,
      isLandmark: true,
      description: 'Full-scale college athletic stadium with a 400m synthetic running track, standard football arena, and elevated spectator gallery.',
      approxLat: 10.05280,
      approxLng: 10.05280 == 0 ? 76.62120 : 76.62125,
      campusX: 720,
      campusY: 660,
      width: 140,
      length: 170,
      height: 12,
      roofColor: Color(0xFF991B1B), // Terracotta clay track
      wallColor: Color(0xFFFEE2E2),
      walkwayNodeId: 'node_stadium',
      searchKeywords: [
        'stadium',
        'track',
        'athletics',
        'football',
        'running',
        'sports',
        'gallery',
      ],
      facilities: [
        '400m Track',
        'Football Field',
        'Floodlights',
        'Spectator Gallery',
      ],
    ),

    // -------------------------------------------------------------------------
    // LANDMARK 4: SWIMMING POOL
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'swimming_pool',
      name: 'College Swimming Pool',
      shortCode: 'SP',
      category: PlaceCategory.sports,
      isLandmark: true,
      description: 'Semi-Olympic competition swimming pool complex with modern filtration, diving blocks, and coaching facilities.',
      approxLat: 10.05470,
      approxLng: 10.05470 == 0 ? 76.62020 : 76.62025,
      campusX: 640,
      campusY: 390,
      width: 60,
      length: 40,
      height: 6,
      roofColor: Color(0xFF0284C7), // Blue pool basin
      wallColor: Color(0xFFE0F2FE),
      walkwayNodeId: 'node_pool',
      searchKeywords: [
        'pool',
        'swimming',
        'water',
        'dive',
        'sports',
        'aquatics',
      ],
      facilities: [
        'Diving Blocks',
        'Shower Rooms',
        'Changing Rooms',
        'Lifebuoys',
      ],
    ),

    // -------------------------------------------------------------------------
    // LANDMARK 5: MAIN ENTRANCE & COLLEGE POST OFFICE
    // -------------------------------------------------------------------------
    const CampusPlace(
      id: 'main_gate',
      name: 'Main Campus Entrance & Post Office',
      shortCode: 'MG',
      category: PlaceCategory.admin,
      isLandmark: true,
      description: 'Northern gateway to MACE on MA College Road, featuring the grand entrance arch, security cabin, and Kothamangalam College Post Office.',
      approxLat: 10.05600,
      approxLng: 10.05600 == 0 ? 76.61830 : 76.61835,
      campusX: 420,
      campusY: 120,
      width: 50,
      length: 35,
      height: 14,
      roofColor: Color(0xFF475569),
      wallColor: Color(0xFFF8FAFC),
      walkwayNodeId: 'node_gate',
      searchKeywords: [
        'gate',
        'entrance',
        'post office',
        'arch',
        'security',
        'entry',
        'ma college road',
      ],
      facilities: [
        'Security Cabin',
        'Postal Services',
        'Speed Post',
        'Bus Waiting Shed',
      ],
    ),
  ];

  static const _referencePlaceSpecs =
      <
        ({
          String id,
          String name,
          String shortCode,
          PlaceCategory category,
          Offset mapPosition,
          String anchorNodeId,
          double connectorDistanceMeters,
        })
      >[
        (
          id: 'students_centre',
          name: 'Students Centre',
          shortCode: 'SC',
          category: PlaceCategory.amenity,
          mapPosition: Offset(624, 47),
          anchorNodeId: 'node_parking',
          connectorDistanceMeters: 95,
        ),
        (
          id: 'chapel',
          name: 'Chapel',
          shortCode: 'CH',
          category: PlaceCategory.landmark,
          mapPosition: Offset(712, 128),
          anchorNodeId: 'node_parking',
          connectorDistanceMeters: 90,
        ),
        (
          id: 'tennis_court',
          name: 'MACE Tennis Court',
          shortCode: 'TC',
          category: PlaceCategory.sports,
          mapPosition: Offset(590, 222),
          anchorNodeId: 'node_statue',
          connectorDistanceMeters: 35,
        ),
        (
          id: 'botanical_garden',
          name: 'MACE Botanical Garden',
          shortCode: 'BG',
          category: PlaceCategory.landmark,
          mapPosition: Offset(726, 233),
          anchorNodeId: 'node_cricket',
          connectorDistanceMeters: 35,
        ),
        (
          id: 'geotech_lab',
          name: 'Geotech Lab',
          shortCode: 'GT',
          category: PlaceCategory.lab,
          mapPosition: Offset(579, 389),
          anchorNodeId: 'node_hydraulic_lab',
          connectorDistanceMeters: 25,
        ),
        (
          id: 'pta_seminar_hall',
          name: 'PTA Seminar Hall 2',
          shortCode: 'PTA',
          category: PlaceCategory.academic,
          mapPosition: Offset(694, 390),
          anchorNodeId: 'node_main_block',
          connectorDistanceMeters: 45,
        ),
        (
          id: 'placement_cell',
          name: 'Training and Placement Cell',
          shortCode: 'TPC',
          category: PlaceCategory.admin,
          mapPosition: Offset(810, 379),
          anchorNodeId: 'node_pool',
          connectorDistanceMeters: 45,
        ),
        (
          id: 'open_air_theatre',
          name: 'Open Air Theatre',
          shortCode: 'OAT',
          category: PlaceCategory.amenity,
          mapPosition: Offset(633, 436),
          anchorNodeId: 'node_canteen',
          connectorDistanceMeters: 40,
        ),
        (
          id: 'mca_block',
          name: 'MCA Block',
          shortCode: 'MCA',
          category: PlaceCategory.academic,
          mapPosition: Offset(713, 622),
          anchorNodeId: 'node_stadium',
          connectorDistanceMeters: 65,
        ),
        (
          id: 'fab_lab',
          name: 'MACE Fab Lab',
          shortCode: 'FAB',
          category: PlaceCategory.lab,
          mapPosition: Offset(676, 648),
          anchorNodeId: 'node_stadium',
          connectorDistanceMeters: 75,
        ),
        (
          id: 'material_testing_lab',
          name: 'Material Testing Lab',
          shortCode: 'MTL',
          category: PlaceCategory.lab,
          mapPosition: Offset(631, 692),
          anchorNodeId: 'node_ec_block',
          connectorDistanceMeters: 45,
        ),
        (
          id: 'kennedy_hostel',
          name: 'Kennedy Hostel',
          shortCode: 'KH',
          category: PlaceCategory.hostel,
          mapPosition: Offset(982, 570),
          anchorNodeId: 'node_hostels_road',
          connectorDistanceMeters: 25,
        ),
        (
          id: 'hostel_mess',
          name: 'Hostel Mess',
          shortCode: 'HM',
          category: PlaceCategory.amenity,
          mapPosition: Offset(1017, 618),
          anchorNodeId: 'node_hostels_road',
          connectorDistanceMeters: 45,
        ),
        (
          id: 'diamond_jubilee_hostel',
          name: 'Diamond Jubilee Hostel',
          shortCode: 'DJH',
          category: PlaceCategory.hostel,
          mapPosition: Offset(1086, 644),
          anchorNodeId: 'node_mens_hostel',
          connectorDistanceMeters: 65,
        ),
        (
          id: 'mb_hostel',
          name: 'MB Hostel MACE',
          shortCode: 'MBH',
          category: PlaceCategory.hostel,
          mapPosition: Offset(940, 679),
          anchorNodeId: 'node_stadium',
          connectorDistanceMeters: 60,
        ),
        (
          id: 'amrutha_homely_food',
          name: 'Amrutha Homely Food',
          shortCode: 'AHF',
          category: PlaceCategory.amenity,
          mapPosition: Offset(166, 626),
          anchorNodeId: 'node_ladies_hostel',
          connectorDistanceMeters: 85,
        ),
        (
          id: 'chillam',
          name: 'Chillam',
          shortCode: 'CHL',
          category: PlaceCategory.amenity,
          mapPosition: Offset(309, 636),
          anchorNodeId: 'node_ladies_hostel',
          connectorDistanceMeters: 65,
        ),
        (
          id: 'thaavalam',
          name: 'Thaavalam',
          shortCode: 'THA',
          category: PlaceCategory.amenity,
          mapPosition: Offset(369, 687),
          anchorNodeId: 'node_ec_block',
          connectorDistanceMeters: 75,
        ),
        (
          id: 'nss_park',
          name: 'NSS Park',
          shortCode: 'NSS',
          category: PlaceCategory.landmark,
          mapPosition: Offset(608, 159),
          anchorNodeId: 'node_parking',
          connectorDistanceMeters: 45,
        ),
        (
          id: 'international_school',
          name: 'Mar Athanasius International School',
          shortCode: 'MAIS',
          category: PlaceCategory.academic,
          mapPosition: Offset(962, 89),
          anchorNodeId: 'node_pool',
          connectorDistanceMeters: 95,
        ),
      ];

  static final List<CampusPlace> referencePlaces = _referencePlaceSpecs
      .map((spec) {
        final campusX = spec.mapPosition.dx * 1000 / 1179;
        final campusY = spec.mapPosition.dy * 1000 / 768;
        final (latitude, longitude) = canvasToGps(campusX, campusY);
        return CampusPlace(
          id: spec.id,
          name: spec.name,
          shortCode: spec.shortCode,
          category: spec.category,
          description: '${spec.name} on the MACE campus.',
          approxLat: latitude,
          approxLng: longitude,
          campusX: campusX,
          campusY: campusY,
          width: 34,
          length: 26,
          height: 12,
          roofColor: spec.category == PlaceCategory.hostel
              ? const Color(0xFF9333EA)
              : const Color(0xFFE99462),
          wallColor: const Color(0xFFFDE7D7),
          isLandmark: spec.category == PlaceCategory.landmark,
          walkwayNodeId: 'node_ref_${spec.id}',
        );
      })
      .toList(growable: false);

  static List<CampusPlace> get allPlaces => [
    ...campusPlaces,
    ...referencePlaces,
  ];

  // ===========================================================================
  // CAMPUS WALKWAY NETWORK NODES (Waypoints)
  // ===========================================================================
  static final Map<String, WalkNode> campusWalkNodes = {
    'node_gate': const WalkNode(
      id: 'node_gate',
      x: 420,
      y: 120,
      approxLat: 10.05600,
      approxLng: 76.61835,
      name: 'Main Gate & Post Office',
    ),
    'node_parking': const WalkNode(
      id: 'node_parking',
      x: 440,
      y: 220,
      approxLat: 10.05530,
      approxLng: 76.61845,
      name: 'Vehicle Parking Area',
    ),
    'node_statue': const WalkNode(
      id: 'node_statue',
      x: 520,
      y: 200,
      approxLat: 10.05530,
      approxLng: 76.61885,
      name: 'Prof. MP Varghese Statue Circle',
    ),
    'node_main_block': const WalkNode(
      id: 'node_main_block',
      x: 560,
      y: 260,
      approxLat: 10.05490,
      approxLng: 76.61940,
      name: 'Main Academic Block Entrance',
    ),
    'node_pool': const WalkNode(
      id: 'node_pool',
      x: 620,
      y: 380,
      approxLat: 10.05470,
      approxLng: 76.62025,
      name: 'Swimming Pool Gate',
    ),
    'node_campus_road_mid': const WalkNode(
      id: 'node_campus_road_mid',
      x: 490,
      y: 360,
      approxLat: 10.05450,
      approxLng: 76.61870,
      name: 'MACE Campus Road Mid-Junction',
    ),
    'node_cricket': const WalkNode(
      id: 'node_cricket',
      x: 390,
      y: 430,
      approxLat: 10.05430,
      approxLng: 76.61815,
      name: 'Cricket Ground Pavilion Path',
    ),
    'node_canteen': const WalkNode(
      id: 'node_canteen',
      x: 490,
      y: 490,
      approxLat: 10.05390,
      approxLng: 76.61875,
      name: 'Canteen & Co-operative Plaza',
    ),
    'node_ladies_hostel': const WalkNode(
      id: 'node_ladies_hostel',
      x: 330,
      y: 550,
      approxLat: 10.05350,
      approxLng: 76.61735,
      name: 'Ladies Hostel Gate',
    ),
    'node_hydraulic_lab': const WalkNode(
      id: 'node_hydraulic_lab',
      x: 540,
      y: 570,
      approxLat: 10.05320,
      approxLng: 76.61950,
      name: 'Hydraulic Machines Lab Front',
    ),
    'node_heat_engines': const WalkNode(
      id: 'node_heat_engines',
      x: 530,
      y: 670,
      approxLat: 10.05250,
      approxLng: 76.61945,
      name: 'Heat Engines Lab Entrance',
    ),
    'node_ec_block': const WalkNode(
      id: 'node_ec_block',
      x: 440,
      y: 680,
      approxLat: 10.05260,
      approxLng: 76.61855,
      name: 'EC Block Main Portico',
    ),
    'node_pg_block': const WalkNode(
      id: 'node_pg_block',
      x: 540,
      y: 800,
      approxLat: 10.05170,
      approxLng: 76.61965,
      name: 'PG Block Entrance Plaza',
    ),
    'node_stadium': const WalkNode(
      id: 'node_stadium',
      x: 680,
      y: 650,
      approxLat: 10.05280,
      approxLng: 76.62125,
      name: 'College Stadium Pavilion Entrance',
    ),
    'node_hostels_road': const WalkNode(
      id: 'node_hostels_road',
      x: 770,
      y: 540,
      approxLat: 10.05370,
      approxLng: 76.62180,
      name: 'MACE Hostels Road Junction',
    ),
    'node_mens_hostel': const WalkNode(
      id: 'node_mens_hostel',
      x: 840,
      y: 540,
      approxLat: 10.05370,
      approxLng: 76.62255,
      name: 'HS-I / HS-II Men\'s Hostel Gate',
    ),
    for (final spec in _referencePlaceSpecs)
      'node_ref_${spec.id}': WalkNode(
        id: 'node_ref_${spec.id}',
        x: spec.mapPosition.dx * 1000 / 1179,
        y: spec.mapPosition.dy * 1000 / 768,
        approxLat: referencePlaces
            .firstWhere((place) => place.id == spec.id)
            .approxLat,
        approxLng: referencePlaces
            .firstWhere((place) => place.id == spec.id)
            .approxLng,
        name: spec.name,
      ),
  };

  // ===========================================================================
  // CAMPUS WALKWAY NETWORK EDGES (Connections & distances in meters)
  // ===========================================================================
  static final List<WalkEdge> campusWalkEdges = [
    // Gate to Parking
    const WalkEdge(
      fromId: 'node_gate',
      toId: 'node_parking',
      distanceMeters: 60,
      pathName: 'Main Entrance Drive',
    ),
    // Gate to Statue
    const WalkEdge(
      fromId: 'node_gate',
      toId: 'node_statue',
      distanceMeters: 75,
      pathName: 'Founder Avenue',
    ),
    // Parking to Statue
    const WalkEdge(
      fromId: 'node_parking',
      toId: 'node_statue',
      distanceMeters: 50,
      pathName: 'Parking Walkway',
    ),
    // Parking to Cricket Ground
    const WalkEdge(
      fromId: 'node_parking',
      toId: 'node_cricket',
      distanceMeters: 110,
      pathName: 'Cricket Ground North Path',
    ),
    // Statue to Main Block
    const WalkEdge(
      fromId: 'node_statue',
      toId: 'node_main_block',
      distanceMeters: 45,
      pathName: 'Main Block Portico Walk',
    ),
    // Statue to Mid Campus Road
    const WalkEdge(
      fromId: 'node_statue',
      toId: 'node_campus_road_mid',
      distanceMeters: 90,
      pathName: 'MACE Campus Road',
    ),
    // Main Block to Swimming Pool
    const WalkEdge(
      fromId: 'node_main_block',
      toId: 'node_pool',
      distanceMeters: 80,
      pathName: 'East Campus Avenue',
    ),
    // Mid Campus Road to Cricket Ground
    const WalkEdge(
      fromId: 'node_campus_road_mid',
      toId: 'node_cricket',
      distanceMeters: 65,
      pathName: 'Cricket Perimeter Path',
    ),
    // Mid Campus Road to Canteen
    const WalkEdge(
      fromId: 'node_campus_road_mid',
      toId: 'node_canteen',
      distanceMeters: 75,
      pathName: 'MACE Campus Road',
    ),
    // Swimming Pool to Hostels Road
    const WalkEdge(
      fromId: 'node_pool',
      toId: 'node_hostels_road',
      distanceMeters: 130,
      pathName: 'East Perimeter Path',
    ),
    // Cricket Ground to Ladies Hostel
    const WalkEdge(
      fromId: 'node_cricket',
      toId: 'node_ladies_hostel',
      distanceMeters: 105,
      pathName: 'Ladies Hostel Link Path',
    ),
    // Canteen to Ladies Hostel
    const WalkEdge(
      fromId: 'node_canteen',
      toId: 'node_ladies_hostel',
      distanceMeters: 120,
      pathName: 'West Campus Walkway',
    ),
    // Canteen to Hydraulic Lab
    const WalkEdge(
      fromId: 'node_canteen',
      toId: 'node_hydraulic_lab',
      distanceMeters: 70,
      pathName: 'MACE Campus Road',
    ),
    // Hydraulic Lab to Heat Engines Lab
    const WalkEdge(
      fromId: 'node_hydraulic_lab',
      toId: 'node_heat_engines',
      distanceMeters: 60,
      pathName: 'Lab Complex Lane',
    ),
    // Hydraulic Lab to EC Block
    const WalkEdge(
      fromId: 'node_hydraulic_lab',
      toId: 'node_ec_block',
      distanceMeters: 90,
      pathName: 'EC Connector Road',
    ),
    // Ladies Hostel to EC Block
    const WalkEdge(
      fromId: 'node_ladies_hostel',
      toId: 'node_ec_block',
      distanceMeters: 120,
      pathName: 'South-West Walkway',
    ),
    // EC Block to Heat Engines Lab
    const WalkEdge(
      fromId: 'node_ec_block',
      toId: 'node_heat_engines',
      distanceMeters: 55,
      pathName: 'Electronics-Mech Walkway',
    ),
    // Heat Engines to PG Block
    const WalkEdge(
      fromId: 'node_heat_engines',
      toId: 'node_pg_block',
      distanceMeters: 75,
      pathName: 'South Campus Avenue',
    ),
    // EC Block to PG Block
    const WalkEdge(
      fromId: 'node_ec_block',
      toId: 'node_pg_block',
      distanceMeters: 110,
      pathName: 'PG Link Walkway',
    ),
    // Hydraulic Lab to Stadium
    const WalkEdge(
      fromId: 'node_hydraulic_lab',
      toId: 'node_stadium',
      distanceMeters: 115,
      pathName: 'Stadium West Entrance Road',
    ),
    // Heat Engines to Stadium
    const WalkEdge(
      fromId: 'node_heat_engines',
      toId: 'node_stadium',
      distanceMeters: 95,
      pathName: 'Sports Complex Road',
    ),
    // Stadium to Hostels Road
    const WalkEdge(
      fromId: 'node_stadium',
      toId: 'node_hostels_road',
      distanceMeters: 90,
      pathName: 'MACE Hostels Road',
    ),
    // Hostels Road to Men\'s Hostel
    const WalkEdge(
      fromId: 'node_hostels_road',
      toId: 'node_mens_hostel',
      distanceMeters: 65,
      pathName: 'Men\'s Hostel Drive',
    ),
    for (final spec in _referencePlaceSpecs)
      WalkEdge(
        fromId: 'node_ref_${spec.id}',
        toId: spec.anchorNodeId,
        distanceMeters: spec.connectorDistanceMeters,
        pathName: 'Campus Walkway',
      ),
  ];
}
