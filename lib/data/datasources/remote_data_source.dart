import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app2/config.dart';
import 'package:weather_app2/core/Failures/Failure.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/data/models/city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import "package:http/http.dart" as http;

class RemoteDataSource {
  ConfigOptions options = ConfigOptions();

  Future<Either<Failure, City>> getCityFromCurrentLocation(
      LocationPoint coordinates) async {
    try {
      final locationResponse = await http.get(
          options.locationNameByCoordinateRequest(
              coordinates.latitude, coordinates.longitude));

      if (locationResponse.statusCode == 200) {
        print(locationResponse.body);
        final currentCity =
            CityModel().cityNameFromJson(jsonDecode(locationResponse.body));

        print(currentCity);

        final weatherResponse = await http.get(
            options.weatherByLocationRequestUrl(
                coordinates.latitude, coordinates.longitude));

        if (weatherResponse.statusCode == 200) {
          CityModel city =
              CityModel().fromJson(jsonDecode(weatherResponse.body));
          print(333);
          print(city.currentWeather.sunrise);
          return Future(() => Right(City(
                coordinates: city.coordinates,
                currentWeather: city.currentWeather,
                dailyWeather: city.dailyWeather,
                name: currentCity,
              )));
        } else {
          print('No location response');
          return Future(() => Left(NetworkFailure('No location response')));
        }
      } else {
        print('no weather response');
        return Future(() => Left(NetworkFailure('no weather response')));
      }
    } catch (error) {
      print(error.toString());
      return Future(() => Left(NetworkFailure(error.toString())));
    }
  }

  Future<List<City>> getCitySuggestions(String query) {}
}
