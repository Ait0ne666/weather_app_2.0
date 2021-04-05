import 'package:animations/animations.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/screens/ScreenWrapper/screen-wrapper.dart';
import 'package:weather_app2/presentation/screens/city_search_screen.dart';
import 'package:weather_app2/presentation/widgets/CitiesGrid/cities_grid.dart';
import 'package:weather_app2/presentation/widgets/common/FailureScreen/failure_screen.dart';

class CitiesScreen extends StatelessWidget {
  void tryUpdatingLocation(BuildContext context) {
    BlocProvider.of<CitiesBloc>(context).add(UpdateCities());
  }

  void closeCitiesMenu(BuildContext context) {
    NavigationRouter.router
        .navigateTo(context, '/main', transition: TransitionType.fadeIn);
  }

  void navigateToSearch(BuildContext context) {
    NavigationRouter.router.navigateTo(context, '/citySearch',
        transition: TransitionType.cupertino);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      fab: OpenContainer(
        closedBuilder: (context, callback) {
          return Container(
            height: 56,
            width: 56,
            color: Color(0xff631961),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          );
        },
        middleColor: Color(0xff631961),
        closedColor: Color(0xff631961),
        openBuilder: (context, callback) {
          return CitySearchScreen();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
        ),
      ),
      children: [
        Positioned(
          child:
              BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
            if (state is CitiesLoaded || state is CitiesUpdating) {
              return CitiesGrid(
                cities: state.cities,
                currentCity: state.currentCity,
              );
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
    );
  }
}
