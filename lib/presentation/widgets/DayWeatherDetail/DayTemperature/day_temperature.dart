import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DayTemperature extends StatelessWidget {
  final double dayTemp;
  final double nightTemp;
  final double mornTemp;
  final double eveTemp;
  final Key key;

  DayTemperature(
      {this.dayTemp, this.eveTemp, this.mornTemp, this.nightTemp, this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
              'Temperature',
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
                        'assets/wi-day-sunny.svg',
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      )),
                      Text(
                        'Day',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 16),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        dayTemp.toString() + '°',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                          child: SvgPicture.asset(
                        'assets/wi-sunrise.svg',
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      )),
                      Text(
                        'Morning',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(mornTemp.toString() + '°',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
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
                        'Night',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(nightTemp.toString() + '°',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                          child: SvgPicture.asset(
                        'assets/wi-sunset.svg',
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      )),
                      Text(
                        'Evening',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(eveTemp.toString() + '°',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
