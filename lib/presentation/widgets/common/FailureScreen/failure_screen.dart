import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';

class FailureScreen extends StatelessWidget {
  void tryUpdatingLocation(BuildContext context) {
    BlocProvider.of<CitiesBloc>(context).add(UpdateCities());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Something went wrong',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              primary: Color(0xff631961),
              padding: EdgeInsets.all(0),
            ),
            child: Ink(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(80)),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 60,
                child: Text(
                  'Try again',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            onPressed: () => tryUpdatingLocation(context),
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
