import 'package:equatable/equatable.dart';
import 'package:weather_app2/core/Location.dart';


abstract class CitiesEvent extends Equatable {
  CitiesEvent();


  @override
  List<Object> get props => [];
}



class AppStarted extends CitiesEvent {}



class GetCityByLocation extends CitiesEvent {
}

class UpdateCities extends CitiesEvent {

}



class ChangeCity extends CitiesEvent {
  final String city;

  ChangeCity(this.city);
  
  @override
  List<Object> get props => [city];
}


class AddCity extends CitiesEvent {
  final LocationPoint location;

  AddCity(this.location);

  @override
  List<Object> get props => [location];

}


