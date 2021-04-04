import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/AutocompleteCity/autocomplete_city.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/widgets/CitiesGrid/GridItem/grid_weather_item/grid_weather_item.dart';

class AutocompleteItem extends StatelessWidget {
  final City city;
  final AutocompleteCity autocompleteCity;

  AutocompleteItem({this.city, this.autocompleteCity});

  void addCity(BuildContext context, LocationPoint location) {
    BlocProvider.of<CitiesBloc>(context).add(AddCity(location));
  }

  @override
  Widget build(BuildContext context) {
    if (city != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white.withOpacity(0.1)),
          height: 180,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        city.name,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                      child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white,),
                    onPressed: () => addCity(context, city.coordinates),
                  ))
                ],
              ),
              SizedBox(height: 5),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              SizedBox(height: 5),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: city.dailyWeather
                        .sublist(0, 5)
                        .map((e) => GridWeatherItem(
                              weather: e,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white.withOpacity(0.1)),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              autocompleteCity.name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              autocompleteCity.country,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white,),
                        onPressed: () => addCity(
                          context,
                          autocompleteCity.location,
                        ),
                      ),
                    )
                  ]),
            ],
          ),
        ),
      );
    }
  }
}
