import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_campus_navigator/data/campus_map_geometry.dart';

void main() {
  test('traced road branches meet at their shared junctions', () {
    final roads = {for (final road in CampusMapGeometry.roads) road.id: road};

    expect(
      roads['main_gate_access_road']!.points,
      contains(const Offset(410, 91)),
    );
    expect(
      roads['parking_access_road']!.points,
      contains(const Offset(410, 91)),
    );
    expect(
      roads['main_gate_access_road']!.points,
      contains(const Offset(411, 247)),
    );
    expect(
      roads['cricket_loop_road']!.points,
      contains(const Offset(411, 247)),
    );
    expect(roads['lab_access_road']!.points, contains(const Offset(748, 681)));
    expect(
      roads['stadium_outer_loop']!.points,
      contains(const Offset(748, 681)),
    );
    expect(
      roads['mace_hostels_road']!.points,
      contains(const Offset(975, 481)),
    );
    expect(
      roads['stadium_outer_loop']!.points,
      contains(const Offset(975, 481)),
    );
  });

  test('campus roads do not cross either sports ground', () {
    final grounds = CampusMapGeometry.grounds.where(
      (ground) =>
          ground.style == CampusGroundStyle.cricket ||
          ground.style == CampusGroundStyle.athleticsTrack,
    );

    for (final ground in grounds) {
      for (final road in CampusMapGeometry.roads) {
        for (var i = 0; i < road.points.length - 1; i++) {
          final start = road.points[i];
          final end = road.points[i + 1];
          for (var sample = 0; sample <= 20; sample++) {
            final t = sample / 20;
            final point = Offset.lerp(start, end, t)!;
            final radius = math.sqrt(
              math.pow((point.dx - ground.center.dx) / (ground.width / 2), 2) +
                  math.pow(
                    (point.dy - ground.center.dy) / (ground.height / 2),
                    2,
                  ),
            );
            expect(
              radius,
              greaterThan(1),
              reason: '${road.id} crosses ${ground.id}',
            );
          }
        }
      }
    }
  });

  test('key campus labels preserve the requested spatial relationships', () {
    final labels = {
      for (final label in CampusMapGeometry.labels) label.id: label.position,
    };

    expect(labels['cricket_ground']!.dx, lessThan(labels['main_block']!.dx));
    expect(
      labels['ladies_hostel']!.dx,
      lessThan(labels['open_air_theatre']!.dx),
    );
    expect(labels['canteen']!.dx, lessThan(labels['open_air_theatre']!.dx));
    expect(labels['canteen']!.dy, greaterThan(labels['open_air_theatre']!.dy));
    expect(
      labels['open_air_theatre']!.dy,
      greaterThan(labels['main_block']!.dy),
    );
    expect(
      labels['hydraulic_lab']!.dy,
      greaterThan(labels['open_air_theatre']!.dy),
    );
    expect(
      labels['heat_engines_lab']!.dy,
      greaterThan(labels['hydraulic_lab']!.dy),
    );
    expect(labels['pg_block']!.dy, greaterThan(labels['heat_engines_lab']!.dy));
    expect(labels['hostels']!.dx, greaterThan(labels['sports_ground']!.dx));
  });

  test('named campus buildings have traced polygon footprints', () {
    final placeIds = CampusMapGeometry.buildings
        .map((building) => building.placeId)
        .toSet();

    expect(
      placeIds,
      containsAll([
        'main_block',
        'ladies_hostel',
        'canteen',
        'hydraulic_lab',
        'heat_engines_lab',
        'pg_block',
      ]),
    );
    expect(
      CampusMapGeometry.buildings.every(
        (building) => building.footprint.length >= 4,
      ),
      isTrue,
    );
  });
}
