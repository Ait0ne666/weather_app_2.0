import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app2/core/Failures/Failure.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/domain/repositories/cities_repository.dart';

class GetCity {
  final CityRepository repository;
  final LocationService locationService;

  GetCity({@required this.repository, @required this.locationService});

  Future<Either<Failure, City>> getCityFromCurrentLocation() async {
    Either<Failure, City> finalResult;
    LocationPoint location;


    var result = await locationService.getLocation();


    print(result);

    result.fold(
      (l) => finalResult = Left(l),
      (r) => location = r,
    );

    if (location !=null) {
      finalResult = await repository.getCityFromCurrentLocation(location);
    }



    return finalResult;
  }

  Future<Either<Failure, City>> getCityByLocation(LocationPoint location) async {
    Either<Failure, City> finalResult;

    if (location !=null) {
      finalResult = await repository.getCityFromCurrentLocation(location);
    }



    return finalResult;
  }


}
