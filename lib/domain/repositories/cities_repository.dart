

import 'package:dartz/dartz.dart';
import 'package:weather_app2/core/Failures/Failure.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';

abstract class CityRepository {
  Future<Either<Failure,City>> getCityFromCurrentLocation(LocationPoint coordinates);

  Future<Suggestions> getCitySuggestions(String query); 

}