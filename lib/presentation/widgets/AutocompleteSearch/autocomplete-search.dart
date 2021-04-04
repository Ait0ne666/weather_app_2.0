import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/data/datasources/remote_data_source.dart';
import 'package:weather_app2/data/repositories/cities_repository_implementation.dart';
import 'package:weather_app2/domain/usecases/get_city_suggestions.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_bloc.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_event.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/widgets/AutocompleteSearch/AutocompleteInput/autocomplete_input.dart';
import 'package:weather_app2/presentation/widgets/AutocompleteSearch/AutocompleteItem/autocomplete_item.dart';
import 'package:weather_app2/presentation/widgets/CitiesGrid/GridItem/grid_item.dart';

class AutocompleteSearch extends StatefulWidget {
  @override
  _AutocompleteSearchState createState() => _AutocompleteSearchState();
}

class _AutocompleteSearchState extends State<AutocompleteSearch> {
  AutocompleteBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = AutocompleteBloc(
      suggestionEngine: CitySuggestions(
        CityRepositoryImpl(
          RemoteDataSource(),
        ),
      ),
    );
  }

  void navigateBack(BuildContext context) {
    NavigationRouter.router.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: BlocProvider<AutocompleteBloc>(
        create: (context) => bloc,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          color: Colors.black.withOpacity(0.2),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => navigateBack(context),
                  ),
                  AutocompleteInput()
                ],
              ),
              Expanded(
                child: BlocBuilder<AutocompleteBloc, AutocompleteState>(
                  builder: (blocContext, state) {
                    if (state is SuggestionsReady &&
                        state.mainSuggestion == null) {
                      return Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 100),
                        child: Text('No suggestions', style: TextStyle(color:  Colors.white, fontSize: 16),),
                      );
                    } else if (state.mainSuggestion != null) {
                      return ListView(
                        children: [
                          AutocompleteItem(
                            city: state.mainSuggestion,
                          ),
                          ...state.suggestions
                              .map((e) => AutocompleteItem(
                                    autocompleteCity: e,
                                  ))
                              .toList()
                        ],
                      );
                    } else if (state is SuggestionsLoading && state.mainSuggestion == null) {
                      return Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 100),
                        child: Text('Loading', style: TextStyle(color:  Colors.white, fontSize: 16),),
                      );
                    }
                      
                    else {
                      return SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
