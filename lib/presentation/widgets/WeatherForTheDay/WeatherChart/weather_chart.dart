import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';

class WeatherChart extends StatefulWidget {
  final Map<DateTime, Weather> hourlyForecast;

  WeatherChart(this.hourlyForecast);

  @override
  _WeatherChartState createState() => _WeatherChartState();
}

class WeatherMinMax {
  final double min;
  final double max;

  WeatherMinMax({this.max, this.min});
}

class _WeatherChartState extends State<WeatherChart> {
  WeatherMinMax get getMinMax {
    int min = 256;
    int max = -256;

    widget.hourlyForecast.forEach((key, value) {
      if (value.temperature < min) {
        min = value.temperature;
      }
      if (value.temperature > max) {
        max = value.temperature;
      }
    });

    return WeatherMinMax(min: min.toDouble(), max: max.toDouble());
  }

  List<LineChartBarData> getChartData() {
    List<FlSpot> spots = [];

    widget.hourlyForecast.forEach((key, value) {
      spots.add(FlSpot(key.hour.toDouble(), value.temperature.toDouble()));
    });

    return [
      LineChartBarData(
        spots: spots,
        isCurved: false,
        barWidth: 2,
        colors: [
          Colors.white38,
        ],
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 3, color: Colors.white, strokeColor: Colors.white),
        ),
        belowBarData: BarAreaData(
            show: true,
            colors: [Colors.transparent],
            spotsLine: BarAreaSpotsLine(
              show: true,
              flLineStyle: FlLine(
                  color: Colors.white.withOpacity(0.8),
                  strokeWidth: 1,
                  dashArray: [5, 5]),
              checkToShowSpotLine: (spot) => true,
            )),
      ),
    ];
  }

  List<int> getShowingIndexes() {
    List<int> result = [];

    for (var i = 0; i < widget.hourlyForecast.entries.length; i++) {
      result.add(i);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var chart = getChartData();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 50),
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: RadialGradient(colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.1)
                ], stops: [
                  0.1,
                  0.8
                ]),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  height: 180,
                  width: 800,
                  child: LineChart(
                    LineChartData(
                        showingTooltipIndicators: getShowingIndexes()
                            .map((index) => ShowingTooltipIndicators(index, [
                                  LineBarSpot(
                                      chart[0], 0, chart[0].spots[index])
                                ]))
                            .toList(),
                        lineBarsData: chart,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                              getTitles: (hour) =>
                                  hour.toInt().toString() + ':00',
                              getTextStyles: (hour) =>
                                  TextStyle(color: Colors.white, fontSize: 11),
                              showTitles: true),
                        ),
                        minY: getMinMax.min - 5,
                        maxY: getMinMax.max + 5,
                        lineTouchData: LineTouchData(
                          enabled: false,
                          getTouchedSpotIndicator: (LineChartBarData barData,
                              List<int> spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                FlLine(color: Colors.black, strokeWidth: 2),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                    radius: 8,
                                    color: Colors.blue,
                                    strokeWidth: 8,
                                    strokeColor: Colors.black,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            tooltipMargin: 0,
                            tooltipPadding: EdgeInsets.only(bottom: 7),
                            // tooltipRoundedRadius: 8,
                            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                              return lineBarsSpot.map((lineBarSpot) {
                                return LineTooltipItem(
                                  lineBarSpot.y.toInt().toString() + '°',
                                  TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
