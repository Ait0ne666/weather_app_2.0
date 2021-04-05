import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/WeatherChart/chart_data/chart_data.dart';

class WeatherChart extends StatefulWidget {
  final List<Weather> hourlyForecast;
  final DateTime sunset;
  final DateTime sunrise;

  WeatherChart(this.hourlyForecast, this.sunrise, this.sunset);

  @override
  _WeatherChartState createState() => _WeatherChartState();
}

class WeatherMinMax {
  final double min;
  final double max;

  WeatherMinMax({this.max, this.min});
}

List<String> assets = [
  "assets/128/night_half_moon_clear.png",
  "assets/128/day_clear.png",
  "assets/128/cloudy.png",
  "assets/128/night_half_moon_partial_cloud.png",
  "assets/128/day_partial_cloud.png",
  "assets/128/mist.png",
  "assets/128/night_half_moon_rain.png",
  "assets/128/day_rain.png",
  "assets/128/overcast.png",
  "assets/128/night_half_moon_snow.png",
  "assets/128/day_snow.png",
  "assets/128/night_half_moon_rain_thunder.png",
  "assets/128/day_rain_thunder.png",
];

class _WeatherChartState extends State<WeatherChart> {
  WeatherMinMax get getMinMax {
    double min = 256;
    double max = -256;

    widget.hourlyForecast.forEach((value) {
      if (value.temperature < min) {
        min = value.temperature;
      }
      if (value.temperature > max) {
        max = value.temperature;
      }
    });

    return WeatherMinMax(min: min.toDouble(), max: max.toDouble());
  }

  Future<ui.Image> loadImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 20,
      targetWidth: 20,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  Future<Map<String, ui.Image>> loadImages() async {
    Map<String, ui.Image> images = {};

    for (int i = 0; i < assets.length; i++) {
      ui.Image image = await loadImage(assets[i]);
      images[assets[i]] = image;
    }

    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),
            child: Container(
              // height: 180,

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 25),
                    child: Text(
                      'Hourly forecast',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(height: 1, color: Colors.white.withOpacity(0.3)),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      height: 180,
                      width: 2500,
                      child: FutureBuilder(
                          future: loadImages(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ChartData(
                                hourlyForecast: widget.hourlyForecast,
                                images: snapshot.data,
                                max: getMinMax.max,
                                min: getMinMax.min,
                                sunrise: widget.sunrise,
                                sunset: widget.sunset,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
