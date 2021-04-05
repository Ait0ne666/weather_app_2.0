import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';

class Details extends StatelessWidget {
  final Weather weather;
  final Key key;

  Details(this.weather, this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 40,
            sigmaY: 40,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.1),
            ),
            padding: EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10),
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-humidity.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Humidity',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.humidity.toString() + '%',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-barometer.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Pressure',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.pressure.toString() + ' mmHg',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-cloud.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Cloudiness',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.clouds.toString() + '%',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-day-sunny.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Uvi',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.uvi.toString(),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-umbrella.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Precipitation',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.pop.toString() + '%',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            'assets/wi-raindrops.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Dew point',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.dewPoint.toString() + '°',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
