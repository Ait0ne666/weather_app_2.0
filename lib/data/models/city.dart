import 'package:equatable/equatable.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
// import 'package:weather_app2/domain/entities/Weather/weather.dart';

class CityModel extends Equatable {
  final String name;
  final LocationPoint coordinates;
  final WeatherWithHourlyForecast currentWeather;
  final List<Weather> dailyWeather;

  CityModel(
      {this.coordinates, this.name, this.currentWeather, this.dailyWeather});

  List<Object> get props => [name, coordinates];

  CityModel fromJson(Map<String, dynamic> json) {
    List<Weather> tempWeatherArray = [];

    json["daily"].forEach((value) => {
          tempWeatherArray.add(Weather(
            windSpeed: value["wind_speed"].toDouble(),
            dayTemp: value["temp"]["day"].toDouble(),
            nightTemp: value["temp"]["night"].toDouble(),
            eveTemp: value["temp"]["eve"].toDouble(),
            mornTemp: value["temp"]["morn"].toDouble(),
            humidity: value["humidity"].toInt(),
            pressure: value["pressure"].toDouble() / 1.33,
            pop: value["pop"].toInt(),
            uvi: value["uvi"].toDouble(),
            clouds: value["clouds"].toInt(),
            dewPoint: value["dew_point"].toDouble(),
            conditions: mapWeatherConditionsToApiResponse(
                value["weather"][0]["main"], value["weather"][0]["id"]),
            time: DateTime.fromMillisecondsSinceEpoch(value["dt"] * 1000),
            sunrise:
                DateTime.fromMillisecondsSinceEpoch(value["sunrise"] * 1000),
            sunset: DateTime.fromMillisecondsSinceEpoch(value["sunset"] * 1000),
          ))
        });
    print(
        DateTime.fromMillisecondsSinceEpoch(json["current"]["sunrise"] * 1000));
    return CityModel(
        coordinates:
            LocationPoint(latitude: json["lat"], longitude: json["lon"]),
        dailyWeather: tempWeatherArray,
        currentWeather: WeatherWithHourlyForecast(
            conditions: mapWeatherConditionsToApiResponse(
                json["current"]["weather"][0]["main"],
                json["current"]["weather"][0]["id"]),
            sunrise: DateTime.fromMillisecondsSinceEpoch(
                json["current"]["sunrise"] * 1000),
            sunset: DateTime.fromMillisecondsSinceEpoch(
                json["current"]["sunset"] * 1000),
            temperature: json["current"]["temp"].toDouble(),
            windSpeed: json["current"]["wind_speed"].toDouble(),
            hourlyForecast: createHourlyWeatherList(json["hourly"])));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'coordinates': coordinates.toJson(),
        'name': name,
      };

  String cityNameFromJson(List<dynamic> json) {
    return json[0]["name"];
  }

  List<Weather> createHourlyWeatherList(List<dynamic> jsonList) {
    List<Weather> tempHourlyForecast = [];
    DateTime now = DateTime.now();

    jsonList.forEach((element) {
      var date = DateTime.fromMillisecondsSinceEpoch(element["dt"] * 1000);
      print(element["weather"][0]["main"]);
      tempHourlyForecast.add(
        Weather(
          time: date,
          temperature: element["temp"].toDouble(),
          windSpeed: element["wind_speed"].toDouble(),
          conditions: mapWeatherConditionsToApiResponse(
              element["weather"][0]["main"],
              element["weather"][0]["id"].toInt()),
        ),
      );
    });

    return tempHourlyForecast;
  }

  WeatherConditions mapWeatherConditionsToApiResponse(
      String weatherType, int weatherId) {
    switch (weatherType) {
      case "Thunderstorm":
        return WeatherConditions.THUNDER;
      case "Drizzle":
        return WeatherConditions.RAIN;
      case "rain":
        return WeatherConditions.RAIN;
      case "Snow":
        return WeatherConditions.SNOW;
      case "Clear":
        return WeatherConditions.CLEAR;
      case "Clouds":
        if (weatherId == 804) {
          return WeatherConditions.OVERCAST;
        } else if (weatherId == 801) {
          return WeatherConditions.PARTIAL_CLOUDS;
        } else {
          return WeatherConditions.CLOUDS;
        }
        break;
      case "Mist":
        return WeatherConditions.MIST;
      default:
        return WeatherConditions.CLOUDS;
    }
  }
}
