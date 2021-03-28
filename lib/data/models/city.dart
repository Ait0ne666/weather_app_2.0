import 'package:equatable/equatable.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
// import 'package:weather_app2/domain/entities/Weather/weather.dart';

class CityModel extends Equatable{

  final String name;
  final LocationPoint coordinates;
  final WeatherWithHourlyForecast currentWeather;
  final List<Weather> dailyWeather;

  CityModel({this.coordinates, this.name, this.currentWeather, this.dailyWeather});


  List<Object> get props => [name, coordinates];

  CityModel fromJson(Map<String, dynamic> json) {

    List<Weather> tempWeatherArray = [];

    json["daily"].forEach((value) => {
          tempWeatherArray.add(Weather(
          windSpeed: value["wind_speed"],
          dayTemp: value["temp"]["day"],
          nightTemp: value["temp"]["night"],
          conditions: mapWeatherConditionsToApiResponse(value["weather"][0]["main"]),
          time: DateTime.fromMillisecondsSinceEpoch(value["dt"]*1000),
        ))
    });
    return CityModel(
      coordinates: LocationPoint(latitude: json["lat"], longitude: json["lon"]),
      dailyWeather: tempWeatherArray,
      currentWeather: WeatherWithHourlyForecast(
          conditions: mapWeatherConditionsToApiResponse(json["current"]["weather"][0]["main"]),
          sunrise: DateTime.fromMillisecondsSinceEpoch(json["current"]["sunrise"]),
          sunset: DateTime.fromMillisecondsSinceEpoch(json["current"]["sunset"]),
          temperature: json["current"]["temp"].toDouble(),
          windSpeed: json["current"]["wind_speed"].toDouble(),
          hourlyForecast: createWeatherMap(json["hourly"])
      )
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
      'coordinates': coordinates.toJson(),
      'name': name,
    };


  String cityNameFromJson(List<dynamic> json) {
    return json[0]["name"];
  }


  Map<DateTime, Weather> createWeatherMap(List<dynamic> jsonList) {
      Map<DateTime, Weather> tempHourlyForecast = {};
      DateTime now = DateTime.now();

      jsonList.forEach((element) { 
        var date = DateTime.fromMillisecondsSinceEpoch(element["dt"]*1000);
        if (date.day == now.day) {
          tempHourlyForecast[date] = Weather(
            temperature: element["temp"].toDouble(),
            windSpeed: element["wind_speed"].toDouble(),
            conditions: mapWeatherConditionsToApiResponse(element["weather"][0]["main"])
          );
        }
      });

      return tempHourlyForecast;
  }


  WeatherConditions mapWeatherConditionsToApiResponse(String responseString) {
    switch (responseString) {
      case "Thunderstorm":
        return WeatherConditions.RAIN;
      case "Drizzle": 
        return WeatherConditions.RAIN;
      case "rain": 
        return WeatherConditions.RAIN;
      case "Snow": 
        return WeatherConditions.SNOW;
      case "Clear":
        return WeatherConditions.CLEAR;
      case "Clouds":
        return WeatherConditions.CLOUDS;
      default:
        return WeatherConditions.CLOUDS;
    }
  }

}