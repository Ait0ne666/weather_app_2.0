import 'package:equatable/equatable.dart';

class SettingsEvent extends Equatable {
  SettingsEvent();

  @override
  List<Object> get props => [];
}

class ResetState extends SettingsEvent {}

class SetDetailCards extends SettingsEvent {
  final List<String> newCards;

  SetDetailCards(this.newCards);

  @override
  List<Object> get props => [newCards];
}
