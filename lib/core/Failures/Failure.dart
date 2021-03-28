import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;


  Failure(this.message);


  List<Object> get props => [message];

}


class NetworkFailure extends Failure {

  final String message;


  NetworkFailure(this.message): super(message);


}

class LocationFailure extends Failure {

  final String message;


  LocationFailure(this.message): super(message);


}
