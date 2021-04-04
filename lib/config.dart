class ConfigOptions {

  final String openWeatherAPIKey = '9e014068eb87f6f44c8823201f0e9aa7';



  Uri weatherByLocationRequestUrl(double lat, double lon, ) {
    return Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$openWeatherAPIKey&units=metric');
  }

  Uri locationNameByCoordinateRequest(double lat, double lon) {
    return Uri.parse('https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$openWeatherAPIKey');
  }



  Uri autocompleteRequest(String query) {
    return Uri.parse('https://autocomplete.travelpayouts.com/places2?term=$query&locale=en&types[]=city');
  }



}