import 'package:equatable/equatable.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';

class City extends Equatable{

  final String name;
  final LocationPoint coordinates;
  final WeatherWithHourlyForecast currentWeather;
  final List<Weather> dailyWeather;


  City({this.coordinates, this.name, this.currentWeather, this.dailyWeather});


  List<Object> get props => [name, coordinates];


  City fromJson(Map<String, dynamic> json) {
    print(json);
    return City(
      name: json['name'] as String,
      coordinates: LocationPoint().fromJson(json['coordinates']) ,
    );
  }

    Map<String, dynamic> toJson() => <String, dynamic>{
      'coordinates': coordinates.toJson(),
      'name': name,
    };


}