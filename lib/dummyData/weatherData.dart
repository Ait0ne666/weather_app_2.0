import 'package:weather_app2/domain/entities/Weather/weather.dart';

List<Weather> weatherData = [
  Weather(conditions: WeatherConditions.CLEAR, temperature: 28, windSpeed: 5.0),
  Weather(
      conditions: WeatherConditions.CLEAR, temperature: 26, windSpeed: 15.2),
  Weather(conditions: WeatherConditions.SUNNY, temperature: 20, windSpeed: 6.3),
  Weather(conditions: WeatherConditions.CLEAR, temperature: 15, windSpeed: 5.8),
  Weather(conditions: WeatherConditions.CLEAR, temperature: 22, windSpeed: 5.9),
  Weather(conditions: WeatherConditions.SNOW, temperature: 26, windSpeed: 5.6),
  Weather(
      conditions: WeatherConditions.CLOUDS, temperature: 24, windSpeed: 5.5),
];

WeatherWithHourlyForecast dummyWeather = WeatherWithHourlyForecast(
    conditions: WeatherConditions.CLOUDS,
    temperature: 28,
    windSpeed: 6.5,
    hourlyForecast: {
      DateTime(2021, 3, 26, 10, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 30, windSpeed: 6.3),
      DateTime(2021, 3, 26, 11, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 27, windSpeed: 6.3),
      DateTime(2021, 3, 26, 12, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 23, windSpeed: 6.3),
      DateTime(2021, 3, 26, 13, 0, 0): Weather(
          conditions: WeatherConditions.CLEAR, temperature: 15, windSpeed: 5.8),
      DateTime(2021, 3, 26, 14, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 18, windSpeed: 6.3),
      DateTime(2021, 3, 26, 15, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 28, windSpeed: 6.3),
      DateTime(2021, 3, 26, 16, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 22, windSpeed: 6.9),
      DateTime(2021, 3, 26, 17, 0, 0): Weather(
          conditions: WeatherConditions.SNOW, temperature: 26, windSpeed: 5.6),
      DateTime(2021, 3, 26, 18, 0, 0): Weather(
          conditions: WeatherConditions.SUNNY, temperature: 20, windSpeed: 6.3),
    });
