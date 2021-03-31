import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';
import 'dart:ui' as ui;

class ChartData extends StatefulWidget {
  final List<Weather> hourlyForecast;
  final DateTime sunset;
  final DateTime sunrise;
  final double min;
  final double max;
  final Map<String, ui.Image> images;

  ChartData({
    this.hourlyForecast,
    this.min,
    this.max,
    this.sunrise,
    this.sunset,
    this.images,
  });

  @override
  _ChartDataState createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData> {
  List<LineChartBarData> getChartData(bool inView) {
    List<FlSpot> spots = [];

    widget.hourlyForecast.asMap().forEach((key, value) {
      spots.add(FlSpot(key.toDouble(),
          inView ? widget.min - 5 : value.temperature.toDouble()));
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

    for (var i = 0; i < widget.hourlyForecast.length; i++) {
      result.add(i);
    }
    return result;
  }

  List<VerticalLine> getImagesForHours(Map<String, ui.Image> images) {
    List<VerticalLine> lines = [];

    widget.hourlyForecast.asMap().forEach((key, value) {
      lines.add(VerticalLine(
          x: key.toDouble(),
          color: Colors.transparent,
          image: images[mapWeatherConditionsToAsset(
              value.conditions, value.time, widget.sunrise, widget.sunset)]));
    });

    return lines;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('HH:mm');

    var chart = getChartData(false);

    return LineChart(
      LineChartData(
        extraLinesData:
            ExtraLinesData(verticalLines: getImagesForHours(widget.images)),
        showingTooltipIndicators: getShowingIndexes()
            .map((index) => ShowingTooltipIndicators(
                index, [LineBarSpot(chart[0], 0, chart[0].spots[index])]))
            .toList(),
        lineBarsData: chart,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
              margin: 10,
              getTitles: (index) {
                DateTime time = widget.hourlyForecast[index.toInt()].time;
                return format.format(time);
              },
              getTextStyles: (hour) =>
                  TextStyle(color: Colors.white, fontSize: 11),
              showTitles: true),
        ),
        minY: widget.min - 5,
        maxY: widget.max + 5,
        lineTouchData: LineTouchData(
          enabled: false,
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(color: Colors.black, strokeWidth: 2),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
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
        ),
      ),
      swapAnimationDuration: Duration(milliseconds: 800),
      swapAnimationCurve: Curves.easeIn,
    );
  }
}
