import 'package:flutter/material.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';



class CitySearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Sky(
        gradientColors: [
          Color(0xff631961),
          Color(0xffE94057),
          Color(0xffF27121)
        ],
      ),

    ]),);
  }
}