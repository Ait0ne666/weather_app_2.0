import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_app2/presentation/bloc/SettingsBloc/settings_event.dart';
import 'package:weather_app2/presentation/bloc/SettingsBloc/settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  BackgroundTypes background = BackgroundTypes.SUNRISE;
  List<String> weatherDetailCards = ["temperature", "details", 'moon'];

  SettingsBloc() : super(InitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is ResetState) {
      background = BackgroundTypes.SUNRISE;
      weatherDetailCards = ["temperature", "details", 'moon'];
      yield InitialState();
    } else if (event is SetDetailCards) {
      weatherDetailCards = event.newCards;
      print(event.newCards);
      yield NewSettingsState(
          background: background, weatherDetailCards: event.newCards);
    }
  }

  Map<String, dynamic> toJson(SettingsState state) {
    return {"bg": '1', "cards": weatherDetailCards};
  }

  SettingsState fromJson(Map<String, dynamic> json) {
    var bg = json["bg"];
    var cards = json["cards"];
    print('bg');
    print(bg);
    if (bg != null && cards != null) {
      background = BackgroundTypes.SUNRISE;
      weatherDetailCards = weatherDetailCards;
      return NewSettingsState(
          background: BackgroundTypes.SUNRISE, weatherDetailCards: cards);
    } else {
      background = BackgroundTypes.SUNRISE;
      weatherDetailCards = ["temperature", "details", 'moon'];
      return InitialState();
    }
  }
}
