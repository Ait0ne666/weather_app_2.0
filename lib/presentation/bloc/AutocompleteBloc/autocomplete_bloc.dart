import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/domain/usecases/get_city_suggestions.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_event.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final CitySuggestions suggestionEngine;
  List<AutocompleteCity> suggestions = [];
  City mainSuggestion;


  AutocompleteBloc({this.suggestionEngine}): super(InitialState());



  @override
  Stream<AutocompleteState> mapEventToState(AutocompleteEvent event) async* {

    if (event is GetSuggestion) {
      yield SuggestionsLoading(suggestions: suggestions, mainSuggestion: mainSuggestion);
      try {
        Suggestions newSuggestion = await suggestionEngine.getSuggestions(event.query);


        suggestions = newSuggestion.suggestions;
        mainSuggestion = newSuggestion.mainSuggestion;


        print(newSuggestion);

        yield SuggestionsReady(suggestions: newSuggestion.suggestions, mainSuggestion: newSuggestion.mainSuggestion);

      } catch (error) {
        yield SuggestionsError(mainSuggestion: mainSuggestion, suggestions: suggestions, message: error.toString());
      }
    }

  }

}