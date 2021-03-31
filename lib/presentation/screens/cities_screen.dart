import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/widgets/CitiesGrid/cities_grid.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/weather_for_the_day.dart';
import 'package:weather_app2/presentation/widgets/common/FailureScreen/failure_screen.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';

class CitiesScreen extends StatelessWidget {
  void tryUpdatingLocation(BuildContext context) {
    BlocProvider.of<CitiesBloc>(context).add(UpdateCities());
  }

  void closeCitiesMenu(BuildContext context) {
    NavigationRouter.router
        .navigateTo(context, '/main', transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Sky(
          gradientColors: [
            Color(0xff631961),
            Color(0xffE94057),
            Color(0xffF27121)
          ],
        ),
        Positioned(
          child:
              BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
            if (state is CitiesLoaded || state is CitiesUpdating) {
              return CitiesGrid(cities: state.cities);
            } else {
              return FailureScreen();
            }
          }),
        ),
        Positioned(
            top: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.transparent,
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  iconSize: 35,
                  onPressed: () => closeCitiesMenu(context),
                ),
              ]),
            ))
      ],
    ));
  }
}
