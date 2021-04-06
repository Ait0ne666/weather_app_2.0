import 'package:equatable/equatable.dart';

enum BackgroundTypes { SUNRISE, DYNAMIC }

class SettingsState {
  final BackgroundTypes background;
  final List<String> weatherDetailCards;

  SettingsState({this.background, this.weatherDetailCards});

  // @override
  // List<Object> get props => [];
}

class InitialState extends SettingsState {
  InitialState()
      : super(
            background: BackgroundTypes.SUNRISE,
            weatherDetailCards: ["temperature", "details", 'moon']);
}

class NewSettingsState extends SettingsState {
  final BackgroundTypes background;
  final List<String> weatherDetailCards;

  NewSettingsState({this.background, this.weatherDetailCards})
      : super(background: background, weatherDetailCards: weatherDetailCards);

  // @override
  // List<Object> get props => [];
}
