import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/data/datasources/remote_data_source.dart';
import 'package:weather_app2/data/models/city.dart';
import 'package:weather_app2/data/repositories/cities_repository_implementation.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/domain/usecases/get_city_usecase.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/bloc/SettingsBloc/setting_bloc.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app2/presentation/screens/ScreenWrapper/screen-wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  NavigationRouter.setupRouter();
  Hive.registerAdapter(CityModelAdapter());
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(WeatherWithHourlyForecastAdapter());
  Hive.registerAdapter(WeatherConditionsAdapter());
  Hive.registerAdapter(LocationPointAdapter());
  await Hive.initFlutter();
  await Hive.openBox('cities');
  Hive.box('cities').clear();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CitiesBloc citiesBloc;
  SettingsBloc settingsBloc;

  @override
  void initState() {
    citiesBloc = CitiesBloc(
        getCity: GetCity(
            repository: CityRepositoryImpl(RemoteDataSource()),
            locationService: LocationService()));
    citiesBloc.add(AppStarted());
    settingsBloc = SettingsBloc();
    super.initState();
  }

  @override
  void dispose() {
    citiesBloc.close();
    settingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CitiesBloc>(
          create: (context) => citiesBloc,
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => settingsBloc,
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: MainScreen(),
          onGenerateRoute: NavigationRouter.router.generator,
          home: BlocListener<CitiesBloc, CitiesState>(
            listener: (context, state) {
              print('state');
              print(state);
              if (state is ShouldLoadCities) {
                BlocProvider.of<CitiesBloc>(context).add(UpdateCities());
              } else if (state is CitiesLoaded) {
                NavigationRouter.router.navigateTo(context, '/main',
                    transition: TransitionType.fadeIn, clearStack: true);
              } else if (state is NoCities) {
                NavigationRouter.router.navigateTo(context, '/welcome',
                    transition: TransitionType.fadeIn);
              } else if (state is CitiesError) {
                final SnackBar snackBar = SnackBar(
                  content: Text(state.message),
                  backgroundColor: Color(0xff631961),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    textColor: Color(0xffE94057),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is ChangeCity) {
                NavigationRouter.router.navigateTo(context, '/main',
                    transition: TransitionType.fadeIn, clearStack: true);
              }
            },
            child: ScreenWrapper(
              children: [],
            ),
          )),
    );
  }
}
