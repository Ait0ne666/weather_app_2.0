import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/widgets/CitiesGrid/GridItem/grid_item.dart';

class CitiesGrid extends StatelessWidget {
  final Map<String, City> cities;
  final String currentCity;

  CitiesGrid({this.cities, this.currentCity});

  void navigateToCity(BuildContext context, String name) {
      if (name != currentCity) {
        BlocProvider.of<CitiesBloc>(context).add(ChangeCity(name));
      } else {
        NavigationRouter.router.navigateTo(context, '/main', transition: TransitionType.fadeIn, clearStack: true);
      }
  }



  List<Widget> getCitiesList(final Map<String, City> cities) {
    return cities.entries.map((e) {
      return GridItem(e.value, navigateToCity);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(top: 100, bottom: 50),
        color: Colors.black.withOpacity(0.2),
        child: ListView(
          padding: EdgeInsets.only(top: 100, bottom: 50, left: 20, right: 20),
          children: getCitiesList(cities),
        ));
  }
}
