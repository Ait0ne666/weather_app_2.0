import 'package:equatable/equatable.dart';

enum WeatherConditions { CLOUDS, RAIN, SUNNY, CLEAR, SNOW }

class WeatherWithHourlyForecast extends Weather {
  final Map<DateTime, Weather> hourlyForecast;
  final double temperature;
  final WeatherConditions conditions;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherWithHourlyForecast(
      {this.temperature, this.conditions, this.windSpeed, this.hourlyForecast, this.sunset, this.sunrise});

  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "windSpeed": windSpeed,
      "conditions": conditions,
      "hourlyForecast": hourlyForecast.map((key, value) => MapEntry(key.toString(), value.toJson()))
    };
  }


  WeatherWithHourlyForecast fromJson(Map<String, dynamic> json) {

    Map<DateTime, Weather> tempHourlyForecast = {};

    json["hourlyForecast"].forEach((key, value) => {
      tempHourlyForecast[DateTime.parse(key)] = Weather().fromJson(value)
    }); 


    return WeatherWithHourlyForecast(
      conditions: json["conditions"],
      temperature:  json["temperature"],
      windSpeed: json["windSpeed"],
      hourlyForecast: tempHourlyForecast
    );
  }

}

class Weather extends Equatable {
  final double temperature;
  final WeatherConditions conditions;
  final double windSpeed;
  final double dayTemp;
  final double nightTemp;
  final DateTime time;


  Weather({this.temperature, this.conditions, this.windSpeed, this.dayTemp, this.nightTemp, this.time});


  List<Object> get props => [temperature, conditions, windSpeed];



  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "windSpeed": windSpeed,
      "conditions": conditions
    };
  }


  Weather fromJson(Map<String, dynamic> json) {

    return Weather(
      conditions: json["conditions"],
      temperature:  json["temperature"],
      windSpeed: json["windSpeed"]
    );
  }



}
