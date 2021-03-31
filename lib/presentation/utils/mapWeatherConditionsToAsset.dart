import 'package:weather_app2/domain/entities/Weather/weather.dart';

String mapWeatherConditionsToAsset(WeatherConditions conditions, DateTime time,
    DateTime sunrise, DateTime sunset) {
  DateTime nextDaySunrise = sunrise.add(Duration(days: 1));
  DateTime nextDaySunset = sunset.add(Duration(days: 1));
  DateTime inADaySunrise = sunrise.add(Duration(days: 2));
  DateTime inADaySunset = sunset.add(Duration(days: 2));

  switch (conditions) {
    case WeatherConditions.CLEAR:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_clear.png";
      } else {
        return "assets/128/day_clear.png";
      }
      break;
    case WeatherConditions.CLOUDS:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/cloudy.png";
      } else {
        return "assets/128/cloudy.png";
      }
      break;
    case WeatherConditions.PARTIAL_CLOUDS:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_partial_cloud.png";
      } else {
        return "assets/128/day_partial_cloud.png";
      }
      break;
    case WeatherConditions.MIST:
      return "assets/128/mist.png";
    case WeatherConditions.RAIN:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_rain.png";
      } else {
        return "assets/128/day_rain.png";
      }
      break;
    case WeatherConditions.OVERCAST:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/overcast.png";
      } else {
        return "assets/128/overcast.png";
      }
      break;
    case WeatherConditions.SNOW:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_snow.png";
      } else {
        return "assets/128/day_snow.png";
      }
      break;
    case WeatherConditions.THUNDER:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_rain_thunder.png";
      } else {
        return "assets/128/day_rain_thunder.png";
      }
      break;
    case WeatherConditions.SUNNY:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_clear.png";
      } else {
        return "assets/128/day_clear.png";
      }
      break;
    default:
      if (time.isBefore(sunrise) ||
          (time.isAfter(sunset) && time.isBefore(nextDaySunrise)) ||
          (time.isAfter(nextDaySunset) && time.isBefore(inADaySunrise)) ||
          time.isAfter(inADaySunset)) {
        return "assets/128/night_half_moon_partial_cloud.png";
      } else {
        return "assets/128/day_partial_cloud.png";
      }
      break;
  }
}
