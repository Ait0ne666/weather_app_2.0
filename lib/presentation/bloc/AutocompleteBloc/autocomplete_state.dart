import 'package:equatable/equatable.dart';
import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';

class AutocompleteState extends Equatable {
  
  final List<AutocompleteCity> suggestions;
  final City mainSuggestion;


  AutocompleteState({this.mainSuggestion, this.suggestions});


  @override
  List<Object> get props => [suggestions, mainSuggestion];

}




class InitialState extends AutocompleteState {
  InitialState(): super(suggestions: [], mainSuggestion: null);
}


class SuggestionsLoading extends AutocompleteState {
  final List<AutocompleteCity> suggestions;
  final City mainSuggestion;


  SuggestionsLoading({this.mainSuggestion, this.suggestions}): super(suggestions: suggestions, mainSuggestion: mainSuggestion);

}


class SuggestionsError extends AutocompleteState {
    final List<AutocompleteCity> suggestions;
  final City mainSuggestion;
  final String message;

  SuggestionsError({this.message, this.mainSuggestion, this.suggestions}): super(suggestions: suggestions, mainSuggestion: mainSuggestion);

    @override
  List<Object> get props => [suggestions, mainSuggestion, message];

}



class SuggestionsReady extends AutocompleteState {

  final List<AutocompleteCity> suggestions;
  final City mainSuggestion;


  SuggestionsReady({this.mainSuggestion, this.suggestions}): super(suggestions: suggestions, mainSuggestion: mainSuggestion);

}

