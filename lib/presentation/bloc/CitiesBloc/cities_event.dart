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