import 'package:hive/hive.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/data/models/city.dart';

class LocalDataSource {
  var box = Hive.box('cities');

  void saveCityModel(CityModel model) {
    print(model.coordinates.latitude);
    print(model.coordinates.longitude);
    print(model.currentWeather.hourlyForecast);

    box.put(
        model.coordinates.latitude.toString() +
            model.coordinates.longitude.toString(),
        model);
  }

  CityModel getCityModel(LocationPoint location) {
    print(location.latitude);
    print(location.longitude);
    CityModel model =
        box.get(location.latitude.toString() + location.longitude.toString());
    print('sadsad');
    print(model);
    return null;
  }
}
