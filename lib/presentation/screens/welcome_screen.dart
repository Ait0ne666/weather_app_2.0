import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/screens/ScreenWrapper/screen-wrapper.dart';
import 'package:weather_app2/presentation/widgets/WelcomeForm/welcome_Form.dart';

class WelcomeScreen extends StatelessWidget {
  final List<Color> gradientColors = [
    Color(0xff631961),
    Color(0xffE94057),
    Color(0xffF27121)
  ];

  void handleNavigation(BuildContext context) {
    NavigationRouter.router
        .navigateTo(context, '/main', transition: TransitionType.native);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      children: [
                  WelcomeForm(gradientColors),
          BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
            if (state is CitiesLoading) {
              return Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.2),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffF27121)),
                ),
              );
            } else {
              return SizedBox();
            }
          })
      ],
    );
  }
}
