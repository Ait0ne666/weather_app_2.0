import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/utils/mapMoonPhaseToIcon.dart';

class Moon extends StatelessWidget {
  final Weather weather;
  final Key key;

  Moon(this.weather, this.key) : super(key: key);

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
                  'Moon Phase',
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
                            'assets/wi-moonrise.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Moonrise',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.moonrise,
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
                            'assets/wi-moonset.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Moonset',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.moonset,
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
                            'assets/wi-night-clear.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          )),
                          Text(
                            'Illumination',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            weather.moonIllumination,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SvgPicture.asset(
                        mapMoonPhaseToIcon(weather.moonPhase),
                        color: Colors.white,
                        width: 35,
                        height: 35,
                      )),
                      Text(
                        weather.moonPhase,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
