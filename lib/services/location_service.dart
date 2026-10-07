import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../data/campus_data.dart';
import '../models/place.dart';

enum LocationState {
  initial,
  requesting,
  acquired,
  denied,
  disabled,
  simulated,
}

class LocationService extends ChangeNotifier {
  LocationService._();
  static final LocationService instance = LocationService._();

  LocationState _state = LocationState.initial;
  LocationState get state => _state;

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  Offset? _campusOffset;
  Offset? get campusOffset => _campusOffset;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSimulating = false;
  bool get isSimulating => _isSimulating;

  StreamSubscription<Position>? _positionSubscription;

  /// Request device location and update campus coordinate
  Future<bool> requestLocation() async {
    _state = LocationState.requesting;
    _errorMessage = null;
    notifyListeners();

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _state = LocationState.disabled;
        _errorMessage = 'Location services are disabled on this device. You can still navigate manually or use simulation mode.';
        notifyListeners();
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _state = LocationState.denied;
          _errorMessage = 'Location permission was denied. You can select your starting point from the campus list.';
          notifyListeners();
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _state = LocationState.denied;
        _errorMessage = 'Location permission is permanently denied. You can still select places manually.';
        notifyListeners();
        return false;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 8),
        ),
      );

      _currentPosition = position;
      _campusOffset = CampusData.gpsToCanvas(position.latitude, position.longitude);
      _state = LocationState.acquired;
      notifyListeners();
      return true;
    } catch (e) {
      _state = LocationState.denied;
      _errorMessage = 'Could not acquire GPS fix: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Create a synthetic CampusPlace representing the user's current or simulated location
  CampusPlace? getUserPlace() {
    if (_campusOffset == null) return null;

    final (lat, lng) = CampusData.canvasToGps(_campusOffset!.dx, _campusOffset!.dy);

    return CampusPlace(
      id: 'my_location',
      name: _isSimulating ? 'Simulated Location' : 'My Current Location',
      shortCode: 'YOU',
      category: PlaceCategory.landmark,
      description: 'Your real-time GPS position on campus.',
      approxLat: lat,
      approxLng: lng,
      campusX: _campusOffset!.dx,
      campusY: _campusOffset!.dy,
      width: 20,
      length: 20,
      height: 10,
      roofColor: Colors.blueAccent,
      wallColor: Colors.white,
      walkwayNodeId: 'node_campus_road_mid',
      facilities: const [],
    );
  }

  /// Set a simulated campus coordinate (e.g. for testing in emulator or classroom demo)
  void setSimulatedPosition(double canvasX, double canvasY) {
    _campusOffset = Offset(canvasX, canvasY);
    _isSimulating = true;
    _state = LocationState.simulated;
    notifyListeners();
  }

  /// Reset simulation and return to real device GPS
  void clearSimulation() {
    _isSimulating = false;
    if (_currentPosition != null) {
      _campusOffset = CampusData.gpsToCanvas(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      _state = LocationState.acquired;
    } else {
      _campusOffset = null;
      _state = LocationState.initial;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
