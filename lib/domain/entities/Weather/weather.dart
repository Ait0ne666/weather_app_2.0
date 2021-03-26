enum WeatherConditions { CLOUDS, RAIN, SUNNY, CLEAR, SNOW }

class WeatherWithHourlyForecast extends Weather {
  final Map<DateTime, Weather> hourlyForecast;
  final int temperature;
  final WeatherConditions conditions;
  final double windSpeed;

  WeatherWithHourlyForecast(
      {this.temperature, this.conditions, this.windSpeed, this.hourlyForecast});
}

class Weather {
  final int temperature;
  final WeatherConditions conditions;
  final double windSpeed;

  Weather({this.temperature, this.conditions, this.windSpeed});
}
