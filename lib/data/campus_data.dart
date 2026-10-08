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
  // CAMPUS WALKWAY NETWORK NODES
  // ---------------------------------------------------------------------------
  // Every node sits ON a road in the reference image (1179×768 canvas space).
  // Coordinates use the same space as campus_map_geometry.dart roads.
  // ===========================================================================
  static final Map<String, WalkNode> campusWalkNodes = {
    // ── MAIN KOZHIPPILLY ROAD (top diagonal) ──────────────────────────────────
    'rn_main_r1': const WalkNode(id: 'rn_main_r1', x: 60, y: 30, approxLat: 10.0578, approxLng: 76.6151, name: 'Kozhippilly Rd West'),
    'rn_main_r2': const WalkNode(id: 'rn_main_r2', x: 250, y: 82, approxLat: 10.0571, approxLng: 76.6167, name: 'Kozhippilly Rd Mid-W'),
    'rn_main_r3': const WalkNode(id: 'rn_main_r3', x: 435, y: 140, approxLat: 10.0564, approxLng: 76.6183, name: 'Kozhippilly Rd – Gate Junction'),
    'rn_main_r4': const WalkNode(id: 'rn_main_r4', x: 595, y: 190, approxLat: 10.0560, approxLng: 76.6196, name: 'Kozhippilly Rd Mid-E'),
    'rn_main_r5': const WalkNode(id: 'rn_main_r5', x: 775, y: 228, approxLat: 10.0558, approxLng: 76.6211, name: 'Kozhippilly Rd – Stadium Connector Jn'),
    'rn_main_r6': const WalkNode(id: 'rn_main_r6', x: 920, y: 228, approxLat: 10.0558, approxLng: 76.6223, name: 'Kozhippilly Rd – Hostels Connector Jn'),
    'rn_main_r7': const WalkNode(id: 'rn_main_r7', x: 1070, y: 196, approxLat: 10.0559, approxLng: 76.6236, name: 'Kozhippilly Rd East'),

    // ── MAIN GATE ACCESS ROAD ─────────────────────────────────────────────────
    'node_gate': const WalkNode(id: 'node_gate', x: 435, y: 140, approxLat: 10.0564, approxLng: 76.6183, name: 'Main Gate'),
    'rn_gate_1': const WalkNode(id: 'rn_gate_1', x: 430, y: 175, approxLat: 10.0562, approxLng: 76.6183, name: 'Gate Access Rd'),
    'rn_gate_2': const WalkNode(id: 'rn_gate_2', x: 422, y: 232, approxLat: 10.0559, approxLng: 76.6182, name: 'Gate–Cricket Loop Jn'),

    // ── PARKING ACCESS SPUR ───────────────────────────────────────────────────
    'node_parking': const WalkNode(id: 'node_parking', x: 386, y: 150, approxLat: 10.0563, approxLng: 76.6180, name: 'Vehicle Parking'),

    // ── CRICKET LOOP ROAD ─────────────────────────────────────────────────────
    'rn_cr_n':  const WalkNode(id: 'rn_cr_n',  x: 296, y: 156, approxLat: 10.0574, approxLng: 76.6170, name: 'Cricket Loop – North'),
    'rn_cr_ne': const WalkNode(id: 'rn_cr_ne', x: 388, y: 192, approxLat: 10.0572, approxLng: 76.6179, name: 'Cricket Loop – NE'),
    'rn_cr_e':  const WalkNode(id: 'rn_cr_e',  x: 418, y: 256, approxLat: 10.0568, approxLng: 76.6182, name: 'Cricket Loop – E (Gate Jn)'),
    'rn_cr_se': const WalkNode(id: 'rn_cr_se', x: 400, y: 324, approxLat: 10.0563, approxLng: 76.6181, name: 'Cricket Loop – SE'),
    'rn_cr_s':  const WalkNode(id: 'rn_cr_s',  x: 320, y: 372, approxLat: 10.0559, approxLng: 76.6174, name: 'Cricket Loop – South'),
    'rn_cr_sw': const WalkNode(id: 'rn_cr_sw', x: 232, y: 342, approxLat: 10.0561, approxLng: 76.6166, name: 'Cricket Loop – SW'),
    'rn_cr_w':  const WalkNode(id: 'rn_cr_w',  x: 202, y: 256, approxLat: 10.0567, approxLng: 76.6163, name: 'Cricket Loop – West'),
    'rn_cr_nw': const WalkNode(id: 'rn_cr_nw', x: 254, y: 173, approxLat: 10.0572, approxLng: 76.6167, name: 'Cricket Loop – NW'),

    // ── WEST PERIMETER ROAD ───────────────────────────────────────────────────
    'rn_wp_1': const WalkNode(id: 'rn_wp_1', x: 196, y: 235, approxLat: 10.0570, approxLng: 76.6162, name: 'West Perimeter Rd 1'),
    'rn_wp_2': const WalkNode(id: 'rn_wp_2', x: 156, y: 306, approxLat: 10.0566, approxLng: 76.6159, name: 'West Perimeter Rd 2'),
    'rn_wp_3': const WalkNode(id: 'rn_wp_3', x: 118, y: 408, approxLat: 10.0559, approxLng: 76.6156, name: 'West Perimeter – Hostel Jn'),
    'rn_wp_4': const WalkNode(id: 'rn_wp_4', x: 78, y: 454, approxLat: 10.0556, approxLng: 76.6152, name: 'West Perimeter Rd 4'),

    // ── LADIES HOSTEL ACCESS ROAD ─────────────────────────────────────────────
    'rn_lh_1': const WalkNode(id: 'rn_lh_1', x: 172, y: 416, approxLat: 10.0557, approxLng: 76.6160, name: 'Ladies Hostel Access 1'),
    'rn_lh_2': const WalkNode(id: 'rn_lh_2', x: 228, y: 428, approxLat: 10.0557, approxLng: 76.6165, name: 'Ladies Hostel Access 2'),
    'rn_lh_3': const WalkNode(id: 'rn_lh_3', x: 272, y: 464, approxLat: 10.0555, approxLng: 76.6168, name: 'Ladies Hostel Access 3'),
    'node_ladies_hostel': const WalkNode(id: 'node_ladies_hostel', x: 288, y: 484, approxLat: 10.0554, approxLng: 76.6170, name: 'Ladies Hostel Gate'),

    // ── INNER CAMPUS SPINE ────────────────────────────────────────────────────
    'rn_sp_1': const WalkNode(id: 'rn_sp_1', x: 420, y: 286, approxLat: 10.0566, approxLng: 76.6182, name: 'Campus Spine 1'),
    'rn_sp_2': const WalkNode(id: 'rn_sp_2', x: 432, y: 352, approxLat: 10.0562, approxLng: 76.6183, name: 'Campus Spine 2'),
    'rn_sp_3': const WalkNode(id: 'rn_sp_3', x: 456, y: 402, approxLat: 10.0559, approxLng: 76.6185, name: 'Campus Spine 3 – Canteen Jn'),
    'rn_sp_4': const WalkNode(id: 'rn_sp_4', x: 456, y: 462, approxLat: 10.0556, approxLng: 76.6185, name: 'Campus Spine 4'),
    'rn_sp_5': const WalkNode(id: 'rn_sp_5', x: 450, y: 490, approxLat: 10.0554, approxLng: 76.6185, name: 'Campus Spine 5 – Lab Road Jn'),

    // ── LAB ACCESS ROAD ───────────────────────────────────────────────────────
    'rn_lab_1': const WalkNode(id: 'rn_lab_1', x: 434, y: 542, approxLat: 10.0550, approxLng: 76.6184, name: 'Lab Rd 1'),
    'rn_lab_2': const WalkNode(id: 'rn_lab_2', x: 414, y: 594, approxLat: 10.0547, approxLng: 76.6183, name: 'Lab Rd 2'),
    'rn_lab_3': const WalkNode(id: 'rn_lab_3', x: 436, y: 648, approxLat: 10.0543, approxLng: 76.6185, name: 'Lab Rd 3 – SW Jn'),
    'rn_lab_4': const WalkNode(id: 'rn_lab_4', x: 452, y: 670, approxLat: 10.0541, approxLng: 76.6186, name: 'Lab Rd 4'),
    'rn_lab_5': const WalkNode(id: 'rn_lab_5', x: 466, y: 718, approxLat: 10.0537, approxLng: 76.6187, name: 'Lab Rd 5'),
    'rn_lab_6': const WalkNode(id: 'rn_lab_6', x: 506, y: 752, approxLat: 10.0534, approxLng: 76.6190, name: 'Lab Rd 6'),
    'rn_lab_7': const WalkNode(id: 'rn_lab_7', x: 574, y: 752, approxLat: 10.0534, approxLng: 76.6196, name: 'Lab Rd 7'),
    'rn_lab_8': const WalkNode(id: 'rn_lab_8', x: 648, y: 728, approxLat: 10.0536, approxLng: 76.6202, name: 'Lab Rd 8'),
    'rn_lab_9': const WalkNode(id: 'rn_lab_9', x: 714, y: 696, approxLat: 10.0539, approxLng: 76.6208, name: 'Lab Rd 9'),
    'rn_lab_10': const WalkNode(id: 'rn_lab_10', x: 756, y: 674, approxLat: 10.0541, approxLng: 76.6211, name: 'Lab Rd 10 – Stadium Outer Loop Jn'),

    // ── SOUTH-WEST ROAD ───────────────────────────────────────────────────────
    'rn_sw_1': const WalkNode(id: 'rn_sw_1', x: 306, y: 494, approxLat: 10.0553, approxLng: 76.6172, name: 'SW Rd 1'),
    'rn_sw_2': const WalkNode(id: 'rn_sw_2', x: 310, y: 562, approxLat: 10.0548, approxLng: 76.6172, name: 'SW Rd 2'),
    'rn_sw_3': const WalkNode(id: 'rn_sw_3', x: 346, y: 628, approxLat: 10.0544, approxLng: 76.6175, name: 'SW Rd 3'),
    'rn_sw_4': const WalkNode(id: 'rn_sw_4', x: 418, y: 662, approxLat: 10.0541, approxLng: 76.6181, name: 'SW Rd 4'),
    'rn_sw_5': const WalkNode(id: 'rn_sw_5', x: 452, y: 670, approxLat: 10.0541, approxLng: 76.6184, name: 'SW Rd 5 – Lab Rd Jn'),

    // ── STADIUM OUTER LOOP ────────────────────────────────────────────────────
    'rn_sol_n':  const WalkNode(id: 'rn_sol_n',  x: 808, y: 344, approxLat: 10.0562, approxLng: 76.6213, name: 'Stadium Loop – North'),
    'rn_sol_ne': const WalkNode(id: 'rn_sol_ne', x: 864, y: 350, approxLat: 10.0562, approxLng: 76.6218, name: 'Stadium Loop – NE'),
    'rn_sol_e1': const WalkNode(id: 'rn_sol_e1', x: 916, y: 374, approxLat: 10.0561, approxLng: 76.6222, name: 'Stadium Loop – E1'),
    'rn_sol_e2': const WalkNode(id: 'rn_sol_e2', x: 952, y: 414, approxLat: 10.0558, approxLng: 76.6225, name: 'Stadium Loop – E2'),
    'rn_sol_e3': const WalkNode(id: 'rn_sol_e3', x: 972, y: 460, approxLat: 10.0555, approxLng: 76.6227, name: 'Stadium Loop – E3 (Hostels Rd Jn)'),
    'rn_sol_e4': const WalkNode(id: 'rn_sol_e4', x: 978, y: 510, approxLat: 10.0551, approxLng: 76.6227, name: 'Stadium Loop – E4'),
    'rn_sol_se': const WalkNode(id: 'rn_sol_se', x: 966, y: 558, approxLat: 10.0547, approxLng: 76.6226, name: 'Stadium Loop – SE'),
    'rn_sol_s1': const WalkNode(id: 'rn_sol_s1', x: 944, y: 604, approxLat: 10.0543, approxLng: 76.6225, name: 'Stadium Loop – S1'),
    'rn_sol_s2': const WalkNode(id: 'rn_sol_s2', x: 912, y: 644, approxLat: 10.0539, approxLng: 76.6222, name: 'Stadium Loop – S2'),
    'rn_sol_sw': const WalkNode(id: 'rn_sol_sw', x: 868, y: 672, approxLat: 10.0537, approxLng: 76.6218, name: 'Stadium Loop – SW'),
    'rn_sol_s3': const WalkNode(id: 'rn_sol_s3', x: 816, y: 686, approxLat: 10.0536, approxLng: 76.6213, name: 'Stadium Loop – S3'),
    'rn_sol_s4': const WalkNode(id: 'rn_sol_s4', x: 756, y: 684, approxLat: 10.0536, approxLng: 76.6208, name: 'Stadium Loop – S4'),
    'rn_sol_w1': const WalkNode(id: 'rn_sol_w1', x: 714, y: 670, approxLat: 10.0537, approxLng: 76.6204, name: 'Stadium Loop – W1'),
    'rn_sol_w2': const WalkNode(id: 'rn_sol_w2', x: 674, y: 642, approxLat: 10.0539, approxLng: 76.6201, name: 'Stadium Loop – W2'),
    'rn_sol_w3': const WalkNode(id: 'rn_sol_w3', x: 648, y: 606, approxLat: 10.0542, approxLng: 76.6199, name: 'Stadium Loop – W3'),
    'rn_sol_w4': const WalkNode(id: 'rn_sol_w4', x: 638, y: 564, approxLat: 10.0546, approxLng: 76.6198, name: 'Stadium Loop – W4'),
    'rn_sol_w5': const WalkNode(id: 'rn_sol_w5', x: 650, y: 476, approxLat: 10.0553, approxLng: 76.6199, name: 'Stadium Loop – W5'),
    'rn_sol_w6': const WalkNode(id: 'rn_sol_w6', x: 674, y: 438, approxLat: 10.0556, approxLng: 76.6201, name: 'Stadium Loop – W6'),
    'rn_sol_w7': const WalkNode(id: 'rn_sol_w7', x: 710, y: 406, approxLat: 10.0558, approxLng: 76.6204, name: 'Stadium Loop – W7'),
    'rn_sol_nw': const WalkNode(id: 'rn_sol_nw', x: 754, y: 376, approxLat: 10.0560, approxLng: 76.6208, name: 'Stadium Loop – NW'),

    // ── NORTH STADIUM CONNECTOR ───────────────────────────────────────────────
    'rn_nsc_1': const WalkNode(id: 'rn_nsc_1', x: 940, y: 258, approxLat: 10.0567, approxLng: 76.6224, name: 'N Stadium Connector 1'),
    'rn_nsc_2': const WalkNode(id: 'rn_nsc_2', x: 952, y: 336, approxLat: 10.0562, approxLng: 76.6225, name: 'N Stadium Connector 2'),
    'rn_nsc_3': const WalkNode(id: 'rn_nsc_3', x: 882, y: 298, approxLat: 10.0565, approxLng: 76.6219, name: 'N Stadium Connector 3'),
    'rn_nsc_4': const WalkNode(id: 'rn_nsc_4', x: 792, y: 288, approxLat: 10.0565, approxLng: 76.6211, name: 'N Stadium Connector 4'),
    'rn_nsc_5': const WalkNode(id: 'rn_nsc_5', x: 722, y: 318, approxLat: 10.0563, approxLng: 76.6205, name: 'N Stadium Connector 5'),
    'rn_nsc_6': const WalkNode(id: 'rn_nsc_6', x: 710, y: 370, approxLat: 10.0561, approxLng: 76.6204, name: 'N Stadium Connector 6'),

    // ── MACE HOSTELS ROAD ─────────────────────────────────────────────────────
    'rn_hr_1': const WalkNode(id: 'rn_hr_1', x: 952, y: 348, approxLat: 10.0562, approxLng: 76.6225, name: 'Hostels Rd 1'),
    'rn_hr_2': const WalkNode(id: 'rn_hr_2', x: 980, y: 354, approxLat: 10.0562, approxLng: 76.6227, name: 'Hostels Rd 2'),
    'rn_hr_3': const WalkNode(id: 'rn_hr_3', x: 982, y: 402, approxLat: 10.0558, approxLng: 76.6227, name: 'Hostels Rd 3'),
    'rn_hr_4': const WalkNode(id: 'rn_hr_4', x: 978, y: 510, approxLat: 10.0551, approxLng: 76.6227, name: 'Hostels Rd 4 – N Spur'),
    'rn_hr_5': const WalkNode(id: 'rn_hr_5', x: 966, y: 558, approxLat: 10.0547, approxLng: 76.6226, name: 'Hostels Rd 5'),
    'rn_hr_6': const WalkNode(id: 'rn_hr_6', x: 950, y: 608, approxLat: 10.0543, approxLng: 76.6225, name: 'Hostels Rd 6 – S Spur'),
    'rn_hr_7': const WalkNode(id: 'rn_hr_7', x: 930, y: 658, approxLat: 10.0539, approxLng: 76.6223, name: 'Hostels Rd 7'),
    'rn_hr_8': const WalkNode(id: 'rn_hr_8', x: 916, y: 710, approxLat: 10.0535, approxLng: 76.6222, name: 'Hostels Rd 8 – South'),

    // ── HOSTEL ACCESS SPURS ───────────────────────────────────────────────────
    'node_mens_hostel': const WalkNode(id: 'node_mens_hostel', x: 1010, y: 520, approxLat: 10.0550, approxLng: 76.6231, name: 'Men\'s Hostel Gate'),
    'rn_hs_s1': const WalkNode(id: 'rn_hs_s1', x: 984, y: 620, approxLat: 10.0542, approxLng: 76.6228, name: 'Hostel South Spur'),

    // ── KEY BUILDING NODES (sit on nearest road) ──────────────────────────────
    'node_statue':        const WalkNode(id: 'node_statue',        x: 490, y: 200, approxLat: 10.0572, approxLng: 76.6188, name: 'Founder Statue'),
    'node_main_block':    const WalkNode(id: 'node_main_block',    x: 554, y: 310, approxLat: 10.0565, approxLng: 76.6193, name: 'Main Block Entrance'),
    'node_canteen':       const WalkNode(id: 'node_canteen',       x: 386, y: 436, approxLat: 10.0557, approxLng: 76.6181, name: 'Canteen'),
    'node_cricket':       const WalkNode(id: 'node_cricket',       x: 296, y: 156, approxLat: 10.0574, approxLng: 76.6170, name: 'Cricket Ground'),
    'node_pool':          const WalkNode(id: 'node_pool',          x: 638, y: 520, approxLat: 10.0550, approxLng: 76.6198, name: 'Swimming Pool'),
    'node_campus_road_mid': const WalkNode(id: 'node_campus_road_mid', x: 432, y: 352, approxLat: 10.0562, approxLng: 76.6183, name: 'Campus Road Mid'),
    'node_hydraulic_lab': const WalkNode(id: 'node_hydraulic_lab', x: 536, y: 514, approxLat: 10.0551, approxLng: 76.6192, name: 'Hydraulic Lab'),
    'node_heat_engines':  const WalkNode(id: 'node_heat_engines',  x: 476, y: 598, approxLat: 10.0544, approxLng: 76.6186, name: 'Heat Engines Lab'),
    'node_ec_block':      const WalkNode(id: 'node_ec_block',      x: 490, y: 670, approxLat: 10.0538, approxLng: 76.6187, name: 'EC Block'),
    'node_pg_block':      const WalkNode(id: 'node_pg_block',      x: 524, y: 692, approxLat: 10.0536, approxLng: 76.6190, name: 'PG Block'),
    'node_stadium':       const WalkNode(id: 'node_stadium',       x: 810, y: 516, approxLat: 10.0551, approxLng: 76.6213, name: 'Stadium'),
    'node_hostels_road':  const WalkNode(id: 'node_hostels_road',  x: 966, y: 558, approxLat: 10.0547, approxLng: 76.6226, name: 'Hostels Road Jn'),

    for (final spec in _referencePlaceSpecs)
      'node_ref_${spec.id}': WalkNode(
        id: 'node_ref_${spec.id}',
        x: spec.mapPosition.dx * 1000 / 1179,
        y: spec.mapPosition.dy * 1000 / 768,
        approxLat: referencePlaces.firstWhere((p) => p.id == spec.id).approxLat,
        approxLng: referencePlaces.firstWhere((p) => p.id == spec.id).approxLng,
        name: spec.name,
      ),
  };

  // ===========================================================================
  // CAMPUS WALKWAY EDGES — connect ADJACENT nodes only (no cross-grass shortcuts)
  // ===========================================================================
  static final List<WalkEdge> campusWalkEdges = [
    // ── MAIN KOZHIPPILLY ROAD ─────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_main_r1', toId: 'rn_main_r2', distanceMeters: 115, pathName: 'Kozhippilly – College Junction Road'),
    const WalkEdge(fromId: 'rn_main_r2', toId: 'rn_main_r3', distanceMeters: 120, pathName: 'Kozhippilly – College Junction Road'),
    const WalkEdge(fromId: 'rn_main_r3', toId: 'rn_main_r4', distanceMeters: 110, pathName: 'Kozhippilly – College Junction Road'),
    const WalkEdge(fromId: 'rn_main_r4', toId: 'rn_main_r5', distanceMeters: 130, pathName: 'Kozhippilly – College Junction Road'),
    const WalkEdge(fromId: 'rn_main_r5', toId: 'rn_main_r6', distanceMeters: 105, pathName: 'Kozhippilly – College Junction Road'),
    const WalkEdge(fromId: 'rn_main_r6', toId: 'rn_main_r7', distanceMeters: 115, pathName: 'Kozhippilly – College Junction Road'),

    // ── MAIN GATE ACCESS ──────────────────────────────────────────────────────
    const WalkEdge(fromId: 'node_gate',  toId: 'rn_main_r3', distanceMeters: 5,  pathName: 'Main Entrance'),
    const WalkEdge(fromId: 'node_gate',  toId: 'rn_gate_1',  distanceMeters: 35, pathName: 'Main Entrance Drive'),
    const WalkEdge(fromId: 'rn_gate_1', toId: 'rn_gate_2',  distanceMeters: 60, pathName: 'Main Entrance Drive'),
    const WalkEdge(fromId: 'rn_gate_2', toId: 'rn_cr_e',    distanceMeters: 25, pathName: 'Gate–Cricket Rd'),

    // ── PARKING ───────────────────────────────────────────────────────────────
    const WalkEdge(fromId: 'node_parking', toId: 'node_gate', distanceMeters: 50, pathName: 'Parking Spur'),
    const WalkEdge(fromId: 'node_parking', toId: 'rn_cr_nw',  distanceMeters: 90, pathName: 'Parking–Cricket Rd'),
    const WalkEdge(fromId: 'node_parking', toId: 'node_statue', distanceMeters: 75, pathName: 'Parking–Statue Path'),

    // ── CRICKET LOOP ROAD ─────────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_cr_n',  toId: 'rn_cr_nw', distanceMeters: 55,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_nw', toId: 'rn_cr_w',  distanceMeters: 60,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_w',  toId: 'rn_cr_sw', distanceMeters: 70,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_sw', toId: 'rn_cr_s',  distanceMeters: 65,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_s',  toId: 'rn_cr_se', distanceMeters: 70,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_se', toId: 'rn_cr_e',  distanceMeters: 70,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_e',  toId: 'rn_cr_ne', distanceMeters: 60,  pathName: 'Cricket Loop Road'),
    const WalkEdge(fromId: 'rn_cr_ne', toId: 'rn_cr_n',  distanceMeters: 70,  pathName: 'Cricket Loop Road'),
    // Cricket ground node is at north entry
    const WalkEdge(fromId: 'node_cricket', toId: 'rn_cr_n', distanceMeters: 5, pathName: 'Cricket Ground Entry'),

    // ── WEST PERIMETER ROAD ───────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_cr_w',  toId: 'rn_wp_1', distanceMeters: 30, pathName: 'West Perimeter Road'),
    const WalkEdge(fromId: 'rn_wp_1',  toId: 'rn_cr_nw', distanceMeters: 45, pathName: 'West Perimeter Road'),
    const WalkEdge(fromId: 'rn_wp_1',  toId: 'rn_wp_2', distanceMeters: 55, pathName: 'West Perimeter Road'),
    const WalkEdge(fromId: 'rn_wp_2',  toId: 'rn_wp_3', distanceMeters: 75, pathName: 'West Perimeter Road'),
    const WalkEdge(fromId: 'rn_wp_3',  toId: 'rn_wp_4', distanceMeters: 55, pathName: 'West Perimeter Road'),

    // ── LADIES HOSTEL ACCESS ──────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_wp_3',          toId: 'rn_lh_1',         distanceMeters: 40, pathName: 'Ladies Hostel Access'),
    const WalkEdge(fromId: 'rn_lh_1',          toId: 'rn_lh_2',         distanceMeters: 45, pathName: 'Ladies Hostel Access'),
    const WalkEdge(fromId: 'rn_lh_2',          toId: 'rn_lh_3',         distanceMeters: 45, pathName: 'Ladies Hostel Access'),
    const WalkEdge(fromId: 'rn_lh_3',          toId: 'node_ladies_hostel', distanceMeters: 25, pathName: 'Ladies Hostel Gate'),

    // ── INNER CAMPUS SPINE ────────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_gate_2', toId: 'rn_sp_1', distanceMeters: 55, pathName: 'Inner Campus Road'),
    const WalkEdge(fromId: 'rn_sp_1',   toId: 'rn_sp_2', distanceMeters: 65, pathName: 'Inner Campus Road'),
    const WalkEdge(fromId: 'rn_sp_2',   toId: 'rn_sp_3', distanceMeters: 50, pathName: 'Inner Campus Road'),
    const WalkEdge(fromId: 'rn_sp_3',   toId: 'rn_sp_4', distanceMeters: 60, pathName: 'Inner Campus Road'),
    const WalkEdge(fromId: 'rn_sp_4',   toId: 'rn_sp_5', distanceMeters: 30, pathName: 'Inner Campus Road'),
    // Cross-connect to campus_road_mid alias
    const WalkEdge(fromId: 'node_campus_road_mid', toId: 'rn_sp_2', distanceMeters: 5, pathName: 'Campus Road'),
    // Canteen is reached from spine junction
    const WalkEdge(fromId: 'rn_sp_3',   toId: 'node_canteen',  distanceMeters: 50, pathName: 'Canteen Walkway'),
    // Statue linkage (short cut across courtyard)
    const WalkEdge(fromId: 'rn_sp_1',   toId: 'node_statue',   distanceMeters: 70, pathName: 'Statue Avenue'),
    const WalkEdge(fromId: 'node_statue', toId: 'node_main_block', distanceMeters: 80, pathName: 'Main Block Avenue'),
    // SW Rd junction at spine-5
    const WalkEdge(fromId: 'rn_sp_5',   toId: 'node_ladies_hostel', distanceMeters: 140, pathName: 'West Walkway'),
    const WalkEdge(fromId: 'rn_sp_5',   toId: 'rn_sw_1',       distanceMeters: 45, pathName: 'SW Campus Road'),

    // ── LAB ACCESS ROAD ───────────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_sp_5',   toId: 'rn_lab_1', distanceMeters: 52, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_1',  toId: 'rn_lab_2', distanceMeters: 55, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_2',  toId: 'rn_lab_3', distanceMeters: 60, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_3',  toId: 'rn_lab_4', distanceMeters: 25, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_4',  toId: 'rn_lab_5', distanceMeters: 50, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_5',  toId: 'rn_lab_6', distanceMeters: 45, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_6',  toId: 'rn_lab_7', distanceMeters: 50, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_7',  toId: 'rn_lab_8', distanceMeters: 55, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_8',  toId: 'rn_lab_9', distanceMeters: 45, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_9',  toId: 'rn_lab_10', distanceMeters: 35, pathName: 'Lab Access Road'),
    const WalkEdge(fromId: 'rn_lab_10', toId: 'rn_sol_s4', distanceMeters: 10, pathName: 'Stadium Loop Jn'),
    // SW road meets lab road at rn_lab_4
    const WalkEdge(fromId: 'rn_sw_5',   toId: 'rn_lab_4', distanceMeters: 5, pathName: 'Road Junction'),

    // Building nodes connect to nearest lab road node
    const WalkEdge(fromId: 'node_hydraulic_lab', toId: 'rn_sp_5',  distanceMeters: 60, pathName: 'Hydraulic Lab Walkway'),
    const WalkEdge(fromId: 'node_hydraulic_lab', toId: 'rn_lab_1', distanceMeters: 50, pathName: 'Hydraulic Lab Walkway'),
    const WalkEdge(fromId: 'node_heat_engines',  toId: 'rn_lab_2', distanceMeters: 60, pathName: 'Heat Engines Walkway'),
    const WalkEdge(fromId: 'node_heat_engines',  toId: 'rn_lab_3', distanceMeters: 55, pathName: 'Heat Engines Walkway'),
    const WalkEdge(fromId: 'node_ec_block',      toId: 'rn_lab_4', distanceMeters: 40, pathName: 'EC Block Walkway'),
    const WalkEdge(fromId: 'node_pg_block',      toId: 'rn_lab_4', distanceMeters: 55, pathName: 'PG Block Walkway'),
    const WalkEdge(fromId: 'node_pg_block',      toId: 'rn_lab_5', distanceMeters: 50, pathName: 'PG Block Walkway'),
    const WalkEdge(fromId: 'node_pool',          toId: 'rn_sol_w4', distanceMeters: 20, pathName: 'Pool–Stadium Rd'),

    // ── SOUTH-WEST ROAD ───────────────────────────────────────────────────────
    const WalkEdge(fromId: 'node_ladies_hostel', toId: 'rn_sw_1', distanceMeters: 15, pathName: 'SW Campus Road'),
    const WalkEdge(fromId: 'rn_sw_1', toId: 'rn_sw_2', distanceMeters: 70, pathName: 'SW Campus Road'),
    const WalkEdge(fromId: 'rn_sw_2', toId: 'rn_sw_3', distanceMeters: 75, pathName: 'SW Campus Road'),
    const WalkEdge(fromId: 'rn_sw_3', toId: 'rn_sw_4', distanceMeters: 65, pathName: 'SW Campus Road'),
    const WalkEdge(fromId: 'rn_sw_4', toId: 'rn_sw_5', distanceMeters: 30, pathName: 'SW Campus Road'),

    // ── STADIUM OUTER LOOP ────────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_sol_n',  toId: 'rn_sol_ne', distanceMeters: 45, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_ne', toId: 'rn_sol_e1', distanceMeters: 50, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_e1', toId: 'rn_sol_e2', distanceMeters: 45, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_e2', toId: 'rn_sol_e3', distanceMeters: 50, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_e3', toId: 'rn_sol_e4', distanceMeters: 50, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_e4', toId: 'rn_sol_se', distanceMeters: 50, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_se', toId: 'rn_sol_s1', distanceMeters: 50, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_s1', toId: 'rn_sol_s2', distanceMeters: 52, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_s2', toId: 'rn_sol_sw', distanceMeters: 48, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_sw', toId: 'rn_sol_s3', distanceMeters: 45, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_s3', toId: 'rn_sol_s4', distanceMeters: 48, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_s4', toId: 'rn_sol_w1', distanceMeters: 30, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w1', toId: 'rn_sol_w2', distanceMeters: 38, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w2', toId: 'rn_sol_w3', distanceMeters: 40, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w3', toId: 'rn_sol_w4', distanceMeters: 45, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w4', toId: 'rn_sol_w5', distanceMeters: 95, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w5', toId: 'rn_sol_w6', distanceMeters: 40, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w6', toId: 'rn_sol_w7', distanceMeters: 40, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_w7', toId: 'rn_sol_nw', distanceMeters: 38, pathName: 'Stadium Loop Road'),
    const WalkEdge(fromId: 'rn_sol_nw', toId: 'rn_sol_n',  distanceMeters: 42, pathName: 'Stadium Loop Road'),
    // Stadium node is centre of loop
    const WalkEdge(fromId: 'node_stadium', toId: 'rn_sol_w4', distanceMeters: 15, pathName: 'Stadium Entry'),
    const WalkEdge(fromId: 'node_stadium', toId: 'rn_sol_w5', distanceMeters: 20, pathName: 'Stadium Entry'),

    // ── NORTH STADIUM CONNECTOR ───────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_main_r6', toId: 'rn_nsc_1', distanceMeters: 20, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_1',   toId: 'rn_nsc_2', distanceMeters: 80, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_2',   toId: 'rn_hr_1',  distanceMeters: 10, pathName: 'Hostels Rd Junction'),
    const WalkEdge(fromId: 'rn_nsc_2',   toId: 'rn_nsc_3', distanceMeters: 40, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_3',   toId: 'rn_nsc_4', distanceMeters: 65, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_4',   toId: 'rn_nsc_5', distanceMeters: 55, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_5',   toId: 'rn_nsc_6', distanceMeters: 45, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_nsc_6',   toId: 'rn_sol_w7', distanceMeters: 25, pathName: 'Stadium Entry Rd'),
    const WalkEdge(fromId: 'rn_main_r5', toId: 'rn_nsc_4', distanceMeters: 40, pathName: 'N Stadium Connector'),
    const WalkEdge(fromId: 'rn_sol_n',   toId: 'rn_nsc_4', distanceMeters: 45, pathName: 'N Stadium Connector'),

    // ── MACE HOSTELS ROAD ─────────────────────────────────────────────────────
    const WalkEdge(fromId: 'rn_hr_1', toId: 'rn_hr_2', distanceMeters: 20, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_2', toId: 'rn_hr_3', distanceMeters: 48, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_3', toId: 'rn_hr_4', distanceMeters: 108, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_4', toId: 'rn_hr_5', distanceMeters: 50, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_5', toId: 'rn_hr_6', distanceMeters: 50, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_6', toId: 'rn_hr_7', distanceMeters: 52, pathName: 'MACE Hostels Road'),
    const WalkEdge(fromId: 'rn_hr_7', toId: 'rn_hr_8', distanceMeters: 55, pathName: 'MACE Hostels Road'),
    // Hostels road shares nodes with stadium loop at e3/e4/se
    const WalkEdge(fromId: 'rn_hr_4',  toId: 'rn_sol_e4', distanceMeters: 5,  pathName: 'Hostels–Stadium Jn'),
    const WalkEdge(fromId: 'rn_hr_5',  toId: 'rn_sol_se', distanceMeters: 5,  pathName: 'Hostels–Stadium Jn'),
    const WalkEdge(fromId: 'rn_hr_6',  toId: 'rn_sol_s1', distanceMeters: 5,  pathName: 'Hostels–Stadium Jn'),
    // Hostels road aliases
    const WalkEdge(fromId: 'node_hostels_road', toId: 'rn_hr_5', distanceMeters: 5, pathName: 'Hostels Road Jn'),
    // Hostel spurs
    const WalkEdge(fromId: 'rn_hr_4',        toId: 'node_mens_hostel', distanceMeters: 32, pathName: 'Hostel N Spur'),
    const WalkEdge(fromId: 'rn_hr_6',        toId: 'rn_hs_s1',         distanceMeters: 30, pathName: 'Hostel S Spur'),
    const WalkEdge(fromId: 'node_mens_hostel', toId: 'rn_hs_s1',       distanceMeters: 105, pathName: 'Hostels Internal'),

    // ── MAIN BLOCK / STATUE SHORT CONNECTIONS ─────────────────────────────────
    const WalkEdge(fromId: 'node_main_block', toId: 'rn_nsc_5', distanceMeters: 80, pathName: 'East Campus Ave'),
    const WalkEdge(fromId: 'node_main_block', toId: 'rn_sp_1',  distanceMeters: 90, pathName: 'Main Block Ave'),
    const WalkEdge(fromId: 'node_main_block', toId: 'rn_sp_3',  distanceMeters: 80, pathName: 'Main Block South'),

    for (final spec in _referencePlaceSpecs)
      WalkEdge(
        fromId: 'node_ref_${spec.id}',
        toId: spec.anchorNodeId,
        distanceMeters: spec.connectorDistanceMeters,
        pathName: 'Campus Walkway',
      ),
  ];
}
