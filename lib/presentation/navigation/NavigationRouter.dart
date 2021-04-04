import 'package:fluro/fluro.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/screens/cities_screen.dart';
import 'package:weather_app2/presentation/screens/city_search_screen.dart';
import 'package:weather_app2/presentation/screens/day_detail_screen.dart';
import 'package:weather_app2/presentation/screens/main_screen.dart';
import 'package:weather_app2/presentation/screens/welcome_screen.dart';

class NavigationRouter {
  static FluroRouter router = FluroRouter();

  static Handler _weatherForTheDayHandler =
      Handler(handlerFunc: (context, parameters) => MainScreen());

  static Handler _welcomeHandler =
      Handler(handlerFunc: (context, parameters) => WelcomeScreen());

  static Handler _citiesHandler =
      Handler(handlerFunc: (context, parameters) => CitiesScreen());

  static Handler _searchHandler =
      Handler(handlerFunc: (context, parameters) => CitySearchScreen());


  static Handler _dayWeatherHandler = Handler(handlerFunc: (context, parameters) {
    final args = context.settings.arguments as Weather;
    return DayDetail(args);
  });

  static void setupRouter() {
    router.define('/main', handler: _weatherForTheDayHandler);
    router.define('/welcome', handler: _welcomeHandler);
    router.define('/cities', handler: _citiesHandler);
    router.define('/citySearch', handler: _searchHandler);
    router.define('/dayWeather', handler: _dayWeatherHandler);
  }
}
