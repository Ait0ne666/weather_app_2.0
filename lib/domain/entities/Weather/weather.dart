import 'package:equatable/equatable.dart';

enum WeatherConditions {
  CLOUDS,
  RAIN,
  SUNNY,
  CLEAR,
  SNOW,
  THUNDER,
  PARTIAL_CLOUDS,
  OVERCAST,
  MIST
}

class WeatherWithHourlyForecast extends Weather {
  final List<Weather> hourlyForecast;
  final double temperature;
  final WeatherConditions conditions;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime time;

  WeatherWithHourlyForecast(
      {this.temperature,
      this.conditions,
      this.windSpeed,
      this.hourlyForecast,
      this.sunset,
      this.sunrise,
      this.time});

  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "windSpeed": windSpeed,
      "conditions": conditions,
      "hourlyForecast": hourlyForecast.map((value) => value.toJson()),
      "time": time.toString(),
      "sunset": sunset.toString(),
      "sunrise": sunrise.toString()
    };
  }

  WeatherWithHourlyForecast fromJson(Map<String, dynamic> json) {
    List<Weather> tempHourlyForecast = [];

    json["hourlyForecast"].forEach(
        (value) => {tempHourlyForecast.add(Weather().fromJson(value))});

    return WeatherWithHourlyForecast(
        conditions: json["conditions"],
        temperature: json["temperature"],
        windSpeed: json["windSpeed"],
        hourlyForecast: tempHourlyForecast,
        time: DateTime.parse(json["time"]),
        sunrise: DateTime.parse(json["sunrise"]),
        sunset: DateTime.parse(json["sunset"]));
  }
}

class Weather extends Equatable {
  final double temperature;
  final WeatherConditions conditions;
  final double windSpeed;
  final double dayTemp;
  final double nightTemp;
  final double eveTemp;
  final double mornTemp;
  final DateTime time;
  final DateTime sunset;
  final DateTime sunrise;
  final int pressure;
  final int humidity;
  final int pop;
  final double dewPoint;
  final int clouds;
  final double uvi;

  Weather(
      {this.temperature,
      this.conditions,
      this.windSpeed,
      this.dayTemp,
      this.nightTemp,
      this.time,
      this.sunrise,
      this.sunset,
      this.eveTemp,
      this.humidity,
      this.mornTemp,
      this.pop,
      this.pressure,
      this.clouds,
      this.dewPoint,
      this.uvi});

  List<Object> get props => [temperature, conditions, windSpeed];

  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "windSpeed": windSpeed,
      "conditions": conditions,
      "dayTemp": dayTemp,
      "nightTemp": nightTemp,
      "time": time.toString(),
      "sunset": sunset.toString(),
      "sunrise": sunrise.toString(),
      "eveTemp": eveTemp,
      "mornTemp": mornTemp,
      "humidity": humidity,
      "pressure": pressure,
      "pop": pop,
      "uvi": uvi,
      "dewPoint": dewPoint,
      "clouds": clouds
    };
  }

  Weather fromJson(Map<String, dynamic> json) {
    return Weather(
        conditions: json["conditions"],
        temperature: json["temperature"],
        windSpeed: json["windSpeed"],
        dayTemp: json["dayTemp"],
        nightTemp: json["nightTemp"],
        time: DateTime.parse(json["time"]),
        sunrise: DateTime.parse(json["sunrise"]),
        sunset: DateTime.parse(json["sunset"]),
        eveTemp: json["eveTemp"],
        mornTemp: json["mornTemp"],
        humidity: json["humidity"],
        pressure: json["pressure"],
        pop: json["pop"],
        clouds: json["clouds"],
        dewPoint: json["dewPoint"],
        uvi: json["uvi"]);
  }
}
