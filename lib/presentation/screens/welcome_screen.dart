import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/widgets/WelcomeForm/welcome_Form.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';


class WelcomeScreen extends StatelessWidget {

  final List<Color> gradientColors = [
            Color(0xff631961),
            Color(0xffE94057),
            Color(0xffF27121)
          ];



  void handleNavigation(BuildContext context) {
    NavigationRouter.router.navigateTo(context, '/main', transition: TransitionType.native);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Sky(
          gradientColors: gradientColors,
        ),
        WelcomeForm(gradientColors)
      ],
    ),
    );
  }
}