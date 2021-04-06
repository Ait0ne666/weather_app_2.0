import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app2/config.dart';
import 'package:weather_app2/core/Failures/Failure.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/core/NetworkInfo.dart';
import 'package:weather_app2/data/datasources/local_data_source.dart';
import 'package:weather_app2/data/models/city.dart';
import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import "package:http/http.dart" as http;

class RemoteDataSource {
  LocalDataSource localDataSource = LocalDataSource();
  ConfigOptions options = ConfigOptions();
  NetworkInfo network = NetworkInfo();

  Future<Either<Failure, City>> getCityFromCurrentLocation(
      LocationPoint coordinates) async {
    try {
      bool connected = await network.isConnected();
      if (connected) {
        final locationResponse = await http.get(
            options.locationNameByCoordinateRequest(
                coordinates.latitude, coordinates.longitude));

        if (locationResponse.statusCode == 200) {
          final currentCity =
              CityModel().cityNameFromJson(jsonDecode(locationResponse.body));

          final weatherResponse = await http.get(
              options.weatherByLocationRequestUrl(
                  coordinates.latitude, coordinates.longitude));

          final astronomyResponse = await http.get(
              options.astronomyDataByLocation(
                  coordinates.latitude, coordinates.longitude));

          if (weatherResponse.statusCode == 200 &&
              astronomyResponse.statusCode == 200) {
            CityModel city = CityModel().fromJson(
                jsonDecode(weatherResponse.body),
                jsonDecode(astronomyResponse.body));

            localDataSource.saveCityModel(CityModel(
                coordinates: city.coordinates,
                currentWeather: city.currentWeather,
                dailyWeather: city.dailyWeather,
                name: currentCity));

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
      } else {
        CityModel city = localDataSource.getCityModel(coordinates);
        print(city);
        if (city != null) {
          return Future(() => Right(City(
                coordinates: city.coordinates,
                currentWeather: city.currentWeather,
                dailyWeather: city.dailyWeather,
                name: city.name,
              )));
        } else {
          return Future(() => Left(NetworkFailure('No internet connection')));
        }
      }
    } catch (error) {
      print(error.toString());
      return Future(() => Left(NetworkFailure(error.toString())));
    }
  }

  Future<Suggestions> getCitySuggestions(String query) async {
    try {
      final suggestionsResponse =
          await http.get(options.autocompleteRequest(query));

      if (suggestionsResponse.statusCode == 200) {
        CityModel city;

        Suggestions newSuggestions =
            Suggestions.fromJson(jsonDecode(suggestionsResponse.body));

        var mainSuggestion = newSuggestions.suggestions[0];

        final weatherResponse = await http.get(
            options.weatherByLocationRequestUrl(
                mainSuggestion.location.latitude,
                mainSuggestion.location.longitude));

        if (weatherResponse.statusCode == 200) {
          city = CityModel().fromJson(jsonDecode(weatherResponse.body), null);
        }

        return Suggestions(
            suggestions: newSuggestions.suggestions.sublist(1),
            mainSuggestion: City(
                coordinates: city.coordinates,
                currentWeather: city.currentWeather,
                dailyWeather: city.dailyWeather,
                name: mainSuggestion.name));
      } else {
        return Future(() => Suggestions(mainSuggestion: null, suggestions: []));
      }
    } catch (error) {
      print(error);
      return Future(() => Suggestions(mainSuggestion: null, suggestions: []));
    }
  }
}
