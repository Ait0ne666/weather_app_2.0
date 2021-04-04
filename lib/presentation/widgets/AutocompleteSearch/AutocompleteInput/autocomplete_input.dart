import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_bloc.dart';
import 'package:weather_app2/presentation/bloc/AutocompleteBloc/autocomplete_event.dart';



class AutocompleteInput extends StatefulWidget {
  @override
  _AutocompleteInputState createState() => _AutocompleteInputState();
}

class _AutocompleteInputState extends State<AutocompleteInput> {
  Timer timer;

  void onAutocompleteChange(String query, BuildContext context) {

    if (query.length > 2) {
      if (timer !=null) {
        timer.cancel();
      }
      timer = Timer(Duration(milliseconds: 300), () => {
        BlocProvider.of<AutocompleteBloc>(context).add(GetSuggestion(query))
      } );
    }

  }




  @override
  Widget build(BuildContext context) {
    return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: TextField(
                        onChanged: (String query) => onAutocompleteChange(query, context),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          enabledBorder: OutlineInputBorder(
                            gapPadding: 20,
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 20,
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintText: 'Enter city name',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                          border: OutlineInputBorder(
                            gapPadding: 20,
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  );
  }
}