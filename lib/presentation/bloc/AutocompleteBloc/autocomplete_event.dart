import 'package:equatable/equatable.dart';

class AutocompleteEvent extends Equatable {


  AutocompleteEvent();

  @override
  List<Object> get props => [];

}



class GetSuggestion extends AutocompleteEvent {
  final String query;

  GetSuggestion(this.query);

    @override
  List<Object> get props => [query];

}





