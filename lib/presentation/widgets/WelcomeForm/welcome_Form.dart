import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';

class WelcomeForm extends StatelessWidget {
  final List<Color> gradientColors;

  WelcomeForm(this.gradientColors);



  void handleLocation(BuildContext context) {
    BlocProvider.of<CitiesBloc>(context).add(GetCityByLocation());
  }

  void handlePickCity(BuildContext context) {
    
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Center(
                child: Container(
            child: SvgPicture.asset('assets/SVG/day_partial_cloud.svg', width: 200, height: 200),
          ),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
              primary: Color(0xff631961),
              padding: EdgeInsets.all(0),

            ),
            child: Ink(
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(80)),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                child: Text('Find my location', style: TextStyle(fontSize: 22),),
              ),
            ),
            onPressed: () => handleLocation(context),
          ),
          TextButton(child: Text('Or pick a city manually', style: TextStyle(color: Colors.white, fontSize: 16),), onPressed: () => handlePickCity(context),)
        ],
      ),
    );
  }
}
