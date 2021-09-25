import 'package:clima/model/location_model.dart';
import 'package:clima/model/weather_model.dart';
import 'package:dio/dio.dart';

const _apiKey = 'ee02dda5705f90fdff6629a993b48490';
const _baseUWeatherUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherService {
  Future<Weather> getWeather(Location location) async {
    try {
      final url =
          '$_baseUWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$_apiKey&units=metric';
      final response = await Dio().get(url);
      print(url);
      var json = response.data;
      print(json);
      return Weather(
        condition: json['weather'][0]['id'] as int,
        temperature: json['main']['temp'] as double,
        name: json['name'],
        weatherDescription: json['weather'][0]['description'],
      );
    } catch (exception) {
      print('WeatherService get weather error : $exception');
    }
    return Weather(condition: 0, temperature: 0.0, name: '', weatherDescription: '');
  }

  Future<Weather> getWeatherWithCityName(String cityName) async {
    try {
      final url =
          '$_baseUWeatherUrl?q=$cityName&appid=$_apiKey&units=metric';
      final response = await Dio().get(url);
      print(url);
      var json = response.data;
      print(json);
      return Weather(
        condition: json['weather'][0]['id'] as int,
        temperature: json['main']['temp'] as double,
        name: json['name'],
        weatherDescription: json['weather'][0]['description'],
      );
    } catch (exception) {
      print('WeatherService get weather error : $exception');
    }
    return Weather(condition: 0, temperature: 0.0, name: '', weatherDescription: '');
  }

}
