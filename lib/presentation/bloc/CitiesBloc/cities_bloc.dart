import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app2/core/NetworkInfo.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/domain/usecases/get_city_usecase.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';

class CitiesBloc extends HydratedBloc<CitiesEvent, CitiesState> {
  final GetCity getCity;
  Map<String, City> _cities = {};
  String _currentCity;
  final NetworkInfo networkInfo;

  CitiesBloc({this.getCity, this.networkInfo}) : super(CitiesUninitialized());

  @override
  Stream<CitiesState> mapEventToState(CitiesEvent event) async* {
    if (event is GetCityByLocation) {
      yield CitiesLoading();
      try {
        City city;
        String message;

        var result = await getCity.getCityFromCurrentLocation();

        result.fold((l) => message = l.message, (r) => city = r);

        if (city != null) {
          _currentCity = city.name;
          _cities[city.name] = city;

          yield CitiesLoaded(currentCity: _currentCity, cities: _cities);
        } else if (message != null) {
          yield CitiesError(message);
        }
      } catch (error) {
        print(error);
        yield CitiesError(error.toString());
      }
    } else if (event is AppStarted) {
      if (_currentCity != null) {
        yield ShouldLoadCities(cities: _cities, currentCity: _currentCity);
      } else {
        yield NoCities();
      }
    } else if (event is UpdateCities) {
      if (_currentCity != null && _cities[_currentCity] != null) {
        try {
          Map<String, City> newCities = {};
          String errorMessage;

          yield CitiesUpdating(cities: _cities, currentCity: _currentCity);


          await Future.forEach(_cities.entries, (MapEntry<String, City> element) async {
            City city;
            String message;

            var result = await getCity
                .getCityByLocation(element.value.coordinates);

            result.fold((l) => message = l.message, (r) => city = r);

            if (city != null) {
                            
              newCities[city.name] = city;
            } else if (message != null) {
              errorMessage = message;
            }
          });

          if (errorMessage == null) {
            _cities = newCities;
            yield CitiesLoaded(currentCity: _currentCity, cities: _cities);
          } else  {
            yield CitiesError(errorMessage);
            if (_currentCity != null && _cities[_currentCity] != null) {
              yield CitiesLoaded(cities: _cities, currentCity: _currentCity);
            }
          }
        } catch (error) {
          print(error);
          yield CitiesError(error.toString());
        }
      }
    } else if (event is ChangeCity) {
      if (_cities[event.city] != null) {
        _currentCity = event.city;
        yield CitiesLoaded(currentCity: event.city, cities: _cities);
      } else {
        yield CitiesError('No such city loaded');
      }
    } else if (event is AddCity) {
        City city;
        String message;
        yield CitiesLoading();    

        try {
          var result = await getCity.getCityByLocation(event.location);


          result.fold((l) => message = l.message, (r) => city = r);

          
          if (city != null) {
            _currentCity = city.name;
            _cities[city.name] = city;

            yield CitiesLoaded(currentCity: _currentCity, cities: _cities);
          } else if (message != null) {
            yield CitiesError(message);
          }
        } catch (error) {
          yield CitiesError(error.toString());
        }




    }
  }

  @override
  Map<String, dynamic> toJson(CitiesState state) {
    return {
      'currentCity': state.currentCity,
      'cities': state.cities.map((key, value) => MapEntry(key, value.toJson()))
    };
  }

  @override
  CitiesState fromJson(Map<String, dynamic> json) {
    if (json['currentCity'] != null) {
      _currentCity = json['currentCity'];
      Map<String, City> tempCities = {};
      json['cities']
          .forEach((key, value) => {tempCities[key] = City().fromJson(value)});
      _cities = tempCities;
      return ShouldLoadCities(cities: _cities, currentCity: _currentCity);
    } else {
      return NoCities();
    }
  }
}
