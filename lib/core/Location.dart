

import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:weather_app2/core/Failures/Failure.dart';

class LocationPoint {
  final double latitude;
  final double longitude;

  LocationPoint({this.latitude, this.longitude});


    LocationPoint fromJson(Map<String, dynamic> json) {
  return LocationPoint(
    latitude: json['latitude'] as double,
    longitude: json['longitude'] as double,
  );
}

Map<String, dynamic> toJson() => <String, dynamic>{
      'longitude': longitude,
      'latitude': latitude,
    };
}



class LocationService {
  Location _location = new Location();



  Future<Either<Failure,LocationPoint>> getLocation() async {
    bool serviceEnabled;
    PermissionStatus grantedPermission;

    serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();

      if (!serviceEnabled) {
        return Left(LocationFailure('Location permission is required'));
      }
    } 

    grantedPermission = await _location.hasPermission();

    if (grantedPermission == PermissionStatus.denied) {
      grantedPermission = await _location.requestPermission();

      if (grantedPermission != PermissionStatus.granted) {
        return Left(LocationFailure('Location permission is required'));
      }
    }

    LocationData data = await _location.getLocation();

    print(data);
    return Right(LocationPoint(latitude: data.latitude, longitude: data.longitude));

  }

}