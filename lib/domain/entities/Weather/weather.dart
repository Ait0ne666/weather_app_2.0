import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 2)
enum WeatherConditions {
  @HiveField(0)
  CLOUDS,
  @HiveField(1)
  RAIN,
  @HiveField(2)
  SUNNY,
  @HiveField(3)
  CLEAR,
  @HiveField(4)
  SNOW,
  @HiveField(5)
  THUNDER,
  @HiveField(6)
  PARTIAL_CLOUDS,
  @HiveField(7)
  OVERCAST,
  @HiveField(8)
  MIST
}

@HiveType(typeId: 4)
class WeatherWithHourlyForecast {
  @HiveField(0)
  final List<Weather> hourlyForecast;
  @HiveField(1)
  final double temperature;
  @HiveField(2)
  final WeatherConditions conditions;
  @HiveField(3)
  final double windSpeed;
  @HiveField(4)
  final DateTime sunrise;
  @HiveField(5)
  final DateTime sunset;
  @HiveField(6)
  final DateTime time;
  @HiveField(23)
  final double dayTemp;
  @HiveField(24)
  final double nightTemp;
  @HiveField(25)
  final double eveTemp;
  @HiveField(26)
  final double mornTemp;
  @HiveField(10)
  final int pressure;
  @HiveField(11)
  final int humidity;
  @HiveField(12)
  final int pop;
  @HiveField(13)
  final double dewPoint;
  @HiveField(14)
  final int clouds;
  @HiveField(15)
  final double uvi;
  @HiveField(16)
  final String moonrise;
  @HiveField(17)
  final String moonset;
  @HiveField(18)
  final String moonPhase;
  @HiveField(19)
  final String moonIllumination;

  WeatherWithHourlyForecast(
      {this.temperature,
      this.conditions,
      this.windSpeed,
      this.hourlyForecast,
      this.sunset,
      this.sunrise,
      this.time,
      this.clouds,
      this.dayTemp,
      this.dewPoint,
      this.eveTemp,
      this.humidity,
      this.moonIllumination,
      this.moonPhase,
      this.moonrise,
      this.moonset,
      this.mornTemp,
      this.nightTemp,
      this.pop,
      this.pressure,
      this.uvi});

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

@HiveType(typeId: 1)
class Weather extends Equatable {
  @HiveField(20)
  final double temperature;
  @HiveField(21)
  final WeatherConditions conditions;
  @HiveField(22)
  final double windSpeed;
  @HiveField(23)
  final double dayTemp;
  @HiveField(24)
  final double nightTemp;
  @HiveField(25)
  final double eveTemp;
  @HiveField(26)
  final double mornTemp;
  @HiveField(7)
  final DateTime time;
  @HiveField(8)
  final DateTime sunset;
  @HiveField(9)
  final DateTime sunrise;
  @HiveField(10)
  final int pressure;
  @HiveField(11)
  final int humidity;
  @HiveField(12)
  final int pop;
  @HiveField(13)
  final double dewPoint;
  @HiveField(14)
  final int clouds;
  @HiveField(15)
  final double uvi;
  @HiveField(16)
  final String moonrise;
  @HiveField(17)
  final String moonset;
  @HiveField(18)
  final String moonPhase;
  @HiveField(19)
  final String moonIllumination;

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
      this.uvi,
      this.moonIllumination,
      this.moonPhase,
      this.moonrise,
      this.moonset});

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
      "clouds": clouds,
      "moonset": moonset.toString(),
      "moonrise": moonrise.toString(),
      "illumination": moonIllumination,
      "moonPhase": moonPhase
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
        uvi: json["uvi"],
        moonIllumination: json['illumination'],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json['moonPhase']);
  }
}
