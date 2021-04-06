class ConfigOptions {
  final String openWeatherAPIKey = '9e014068eb87f6f44c8823201f0e9aa7';
  final String worldWeatherAPIKey = 'd5aa7351195f4a21ba1120430210604';

  Uri weatherByLocationRequestUrl(
    double lat,
    double lon,
  ) {
    return Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$openWeatherAPIKey&units=metric');
  }

  Uri locationNameByCoordinateRequest(double lat, double lon) {
    return Uri.parse(
        'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$openWeatherAPIKey');
  }

  Uri autocompleteRequest(String query) {
    return Uri.parse(
        'https://autocomplete.travelpayouts.com/places2?term=$query&locale=en&types[]=city');
  }

  Uri astronomyDataByLocation(double lat, double lon) {
    return Uri.parse(
        'https://api.worldweatheronline.com/premium/v1/weather.ashx?key=$worldWeatherAPIKey&q=$lat,$lon&format=json&num_of_days=7');
  }
}
