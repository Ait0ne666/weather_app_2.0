import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/repositories/cities_repository.dart';

class CitySuggestions {
  final CityRepository repository;


  CitySuggestions(this.repository);

  Future<Suggestions> getSuggestions(String query) async {
    return  repository.getCitySuggestions(query);
  }

}