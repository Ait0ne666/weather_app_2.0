import 'package:fluro/fluro.dart';
import 'package:weather_app2/presentation/screens/cities_screen.dart';
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

  static void setupRouter() {
    router.define('/main', handler: _weatherForTheDayHandler);
    router.define('/welcome', handler: _welcomeHandler);
    router.define('/cities', handler: _citiesHandler);
  }
}
