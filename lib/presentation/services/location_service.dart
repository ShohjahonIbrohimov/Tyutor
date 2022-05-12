import 'dart:async';

import 'package:location/location.dart';
import 'package:moreinfo/presentation/services/location_model.dart';

class LocationService {
  LocationModel? _currentLocation;

  Location location = Location();

  final StreamController<LocationModel> _locationContoller =
      StreamController<LocationModel>.broadcast();

  LocationService() {
    // location.requestService();
    location.requestPermission().then(
          (granted) => {
            if (granted == true)
              {
                location.onLocationChanged.listen((event) {
                  _locationContoller.add(LocationModel(
                    latitude: event.latitude,
                    longtitude: event.longitude,
                  ));
                })
              }
          },
        );
  }

  Stream<LocationModel> get locationStream => _locationContoller.stream;

  Future<LocationModel?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = LocationModel(
        latitude: userLocation.latitude,
        longtitude: userLocation.longitude,
      );
    } catch (e) {
      print("Could not get the location $e");
    }

    return _currentLocation;
  }

  Future<bool> checkServiceStatus() async {
    bool serviceStatus = await location.serviceEnabled();
    if (!serviceStatus) {
      serviceStatus = await location.requestService();
      print('status -> $serviceStatus');
    }
    return serviceStatus;
  }
}
