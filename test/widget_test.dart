import 'package:flutter_test/flutter_test.dart';
import 'package:smart_campus_navigator/data/campus_data.dart';
import 'package:smart_campus_navigator/main.dart';
import 'package:smart_campus_navigator/services/pathfinding_service.dart';

void main() {
  testWidgets('App loads campus navigator and displays search bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SmartCampusNavigatorApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('MACE Smart Navigator'), findsOneWidget);
    expect(find.text('Search buildings, labs, landmarks...'), findsOneWidget);
    expect(find.text('All Places'), findsOneWidget);
  });

  test('Pathfinding calculates valid walking route across campus', () {
    final start = CampusData.campusPlaces.firstWhere((p) => p.id == 'main_gate');
    final dest = CampusData.campusPlaces.firstWhere((p) => p.id == 'ec_block');

    final route = PathfindingService.instance.findRoute(
      startPlace: start,
      destPlace: dest,
    );

    expect(route, isNotNull);
    expect(route!.totalDistanceMeters, greaterThan(0));
    expect(route.estimatedMinutes, greaterThan(0));
    expect(route.steps.length, greaterThan(2));
    expect(route.pathNodes.first.id, equals('node_gate'));
    expect(route.pathNodes.last.id, equals('node_ec_block'));
  });

  test('Place keyword matching finds classrooms and departments', () {
    final ec = CampusData.campusPlaces.firstWhere((p) => p.id == 'ec_block');
    expect(ec.matchesQuery('vlsi'), isTrue);
    expect(ec.matchesQuery('electronics'), isTrue);
    expect(ec.matchesQuery('dsp'), isTrue);

    final mb = CampusData.campusPlaces.firstWhere((p) => p.id == 'main_block');
    expect(mb.matchesQuery('principal'), isTrue);
    expect(mb.matchesQuery('civil'), isTrue);
    expect(mb.matchesQuery('auditorium'), isTrue);
  });
}
