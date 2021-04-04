import 'package:equatable/equatable.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/City/city.dart';

class AutocompleteCity extends Equatable {
  final String name;
  final String country;
  final LocationPoint location;

  AutocompleteCity({this.name, this.country, this.location});


  List<Object> get props => [name, country, location];

}



class Suggestions extends Equatable {

  final City mainSuggestion;
  final List<AutocompleteCity> suggestions;


  Suggestions({this.mainSuggestion, this.suggestions});

  @override
  List<Object> get props => [suggestions, mainSuggestion];


  factory Suggestions.fromJson(List<dynamic> json) {
    List<AutocompleteCity> newSuggestions = [];

    var sublist =  json.length > 5 && json.length!=0? json.sublist(0,5) : json;


    sublist.forEach((element) {  
      newSuggestions.add(
        AutocompleteCity(country: element["country_name"], name: element["name"], location: LocationPoint(latitude: element["coordinates"]["lat"], longitude: element["coordinates"]["lon"]),)
      );
     });
    return Suggestions(mainSuggestion: null, suggestions: newSuggestions);
  }

}