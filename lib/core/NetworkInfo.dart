import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {


  Future<bool> isConnected() {
    return DataConnectionChecker().hasConnection;
  }

}