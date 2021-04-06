// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherConditionsAdapter extends TypeAdapter<WeatherConditions> {
  @override
  final int typeId = 2;

  @override
  WeatherConditions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeatherConditions.CLOUDS;
      case 1:
        return WeatherConditions.RAIN;
      case 2:
        return WeatherConditions.SUNNY;
      case 3:
        return WeatherConditions.CLEAR;
      case 4:
        return WeatherConditions.SNOW;
      case 5:
        return WeatherConditions.THUNDER;
      case 6:
        return WeatherConditions.PARTIAL_CLOUDS;
      case 7:
        return WeatherConditions.OVERCAST;
      case 8:
        return WeatherConditions.MIST;
      default:
        return WeatherConditions.CLOUDS;
    }
  }

  @override
  void write(BinaryWriter writer, WeatherConditions obj) {
    switch (obj) {
      case WeatherConditions.CLOUDS:
        writer.writeByte(0);
        break;
      case WeatherConditions.RAIN:
        writer.writeByte(1);
        break;
      case WeatherConditions.SUNNY:
        writer.writeByte(2);
        break;
      case WeatherConditions.CLEAR:
        writer.writeByte(3);
        break;
      case WeatherConditions.SNOW:
        writer.writeByte(4);
        break;
      case WeatherConditions.THUNDER:
        writer.writeByte(5);
        break;
      case WeatherConditions.PARTIAL_CLOUDS:
        writer.writeByte(6);
        break;
      case WeatherConditions.OVERCAST:
        writer.writeByte(7);
        break;
      case WeatherConditions.MIST:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherConditionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherWithHourlyForecastAdapter
    extends TypeAdapter<WeatherWithHourlyForecast> {
  @override
  final int typeId = 4;

  @override
  WeatherWithHourlyForecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherWithHourlyForecast(
      temperature: fields[1] as double,
      conditions: fields[2] as WeatherConditions,
      windSpeed: fields[3] as double,
      hourlyForecast: (fields[0] as List)?.cast<Weather>(),
      sunset: fields[5] as DateTime,
      sunrise: fields[4] as DateTime,
      time: fields[6] as DateTime,
      clouds: fields[14] as int,
      dayTemp: fields[23] as double,
      dewPoint: fields[13] as double,
      eveTemp: fields[25] as double,
      humidity: fields[11] as int,
      moonIllumination: fields[19] as String,
      moonPhase: fields[18] as String,
      moonrise: fields[16] as String,
      moonset: fields[17] as String,
      mornTemp: fields[26] as double,
      nightTemp: fields[24] as double,
      pop: fields[12] as int,
      pressure: fields[10] as int,
      uvi: fields[15] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherWithHourlyForecast obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.hourlyForecast)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.conditions)
      ..writeByte(3)
      ..write(obj.windSpeed)
      ..writeByte(4)
      ..write(obj.sunrise)
      ..writeByte(5)
      ..write(obj.sunset)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(23)
      ..write(obj.dayTemp)
      ..writeByte(24)
      ..write(obj.nightTemp)
      ..writeByte(25)
      ..write(obj.eveTemp)
      ..writeByte(26)
      ..write(obj.mornTemp)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(12)
      ..write(obj.pop)
      ..writeByte(13)
      ..write(obj.dewPoint)
      ..writeByte(14)
      ..write(obj.clouds)
      ..writeByte(15)
      ..write(obj.uvi)
      ..writeByte(16)
      ..write(obj.moonrise)
      ..writeByte(17)
      ..write(obj.moonset)
      ..writeByte(18)
      ..write(obj.moonPhase)
      ..writeByte(19)
      ..write(obj.moonIllumination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherWithHourlyForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 1;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      temperature: fields[20] as double,
      conditions: fields[21] as WeatherConditions,
      windSpeed: fields[22] as double,
      dayTemp: fields[23] as double,
      nightTemp: fields[24] as double,
      time: fields[7] as DateTime,
      sunrise: fields[9] as DateTime,
      sunset: fields[8] as DateTime,
      eveTemp: fields[25] as double,
      humidity: fields[11] as int,
      mornTemp: fields[26] as double,
      pop: fields[12] as int,
      pressure: fields[10] as int,
      clouds: fields[14] as int,
      dewPoint: fields[13] as double,
      uvi: fields[15] as double,
      moonIllumination: fields[19] as String,
      moonPhase: fields[18] as String,
      moonrise: fields[16] as String,
      moonset: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(20)
      ..writeByte(20)
      ..write(obj.temperature)
      ..writeByte(21)
      ..write(obj.conditions)
      ..writeByte(22)
      ..write(obj.windSpeed)
      ..writeByte(23)
      ..write(obj.dayTemp)
      ..writeByte(24)
      ..write(obj.nightTemp)
      ..writeByte(25)
      ..write(obj.eveTemp)
      ..writeByte(26)
      ..write(obj.mornTemp)
      ..writeByte(7)
      ..write(obj.time)
      ..writeByte(8)
      ..write(obj.sunset)
      ..writeByte(9)
      ..write(obj.sunrise)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(12)
      ..write(obj.pop)
      ..writeByte(13)
      ..write(obj.dewPoint)
      ..writeByte(14)
      ..write(obj.clouds)
      ..writeByte(15)
      ..write(obj.uvi)
      ..writeByte(16)
      ..write(obj.moonrise)
      ..writeByte(17)
      ..write(obj.moonset)
      ..writeByte(18)
      ..write(obj.moonPhase)
      ..writeByte(19)
      ..write(obj.moonIllumination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
