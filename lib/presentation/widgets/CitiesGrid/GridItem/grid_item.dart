import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';

class GridItem extends StatelessWidget {
  final City city;

  GridItem(this.city);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 40,
          sigmaY: 40,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                    child: Row(
                      children: [
                        Text(
                          city.currentWeather.temperature.toInt().toString() +
                              '°',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 3),
                        Image.asset(
                          mapWeatherConditionsToAsset(
                              city.currentWeather.conditions,
                              DateTime.now(),
                              city.currentWeather.sunrise,
                              city.currentWeather.sunset),
                          width: 30,
                          height: 30,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              SizedBox(height: 5),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}
