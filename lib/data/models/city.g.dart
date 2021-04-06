// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityModelAdapter extends TypeAdapter<CityModel> {
  @override
  final int typeId = 0;

  @override
  CityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityModel(
      coordinates: fields[1] as LocationPoint,
      name: fields[0] as String,
      currentWeather: fields[2] as WeatherWithHourlyForecast,
      dailyWeather: (fields[3] as List)?.cast<Weather>(),
    );
  }

  @override
  void write(BinaryWriter writer, CityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.coordinates)
      ..writeByte(2)
      ..write(obj.currentWeather)
      ..writeByte(3)
      ..write(obj.dailyWeather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
