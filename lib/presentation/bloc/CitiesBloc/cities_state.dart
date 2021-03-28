import 'package:equatable/equatable.dart';
import 'package:weather_app2/domain/entities/City/city.dart';

abstract class CitiesState extends Equatable {
  final String currentCity;
  final Map<String, City> cities;

  const CitiesState({this.currentCity, this.cities});

  @override
  List<Object> get props => [];
}

class CitiesUninitialized extends CitiesState {
  CitiesUninitialized() : super(cities: {}, currentCity: null);
}

class NoCities extends CitiesState {
  NoCities() : super(cities: {}, currentCity: null);
}

class CitiesLoading extends CitiesState {
  CitiesLoading() : super(cities: {}, currentCity: null);
}

class CitiesError extends CitiesState {
  final String message;

  CitiesError(this.message) : super(cities: {}, currentCity: null);

  @override
  List<Object> get props => [message];
}

class CitiesLoaded extends CitiesState {
  final String currentCity;
  final Map<String, City> cities;

  CitiesLoaded({this.currentCity, this.cities})
      : super(cities: {}, currentCity: null);

  @override
  List<Object> get props => [currentCity, cities];
}

class ShouldLoadCities extends CitiesState {
  final String currentCity;
  final Map<String, City> cities;

  ShouldLoadCities({this.currentCity, this.cities})
      : super(cities: {}, currentCity: null);

  @override
  List<Object> get props => [currentCity, cities];
}

class CitiesUpdating extends CitiesState {
  final String currentCity;
  final Map<String, City> cities;

  
  CitiesUpdating({this.cities, this.currentCity}): super(cities: cities, currentCity: currentCity);
  
  @override
  List<Object> get props => [currentCity, cities];
}
