import 'package:dartz/dartz.dart';
import 'package:weather_app2/core/Failures/Failure.dart';
import 'package:weather_app2/core/Location.dart';
import 'package:weather_app2/data/datasources/remote_data_source.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/domain/repositories/cities_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final RemoteDataSource remoteDataSource;

  CityRepositoryImpl(this.remoteDataSource);


  Future<Either<Failure,City>> getCityFromCurrentLocation(LocationPoint coordinates) {
    return  remoteDataSource.getCityFromCurrentLocation(coordinates);
  }

  Future<List<City>> getCitySuggestions(String query)  {
    return  remoteDataSource.getCitySuggestions(query);
  } 


}