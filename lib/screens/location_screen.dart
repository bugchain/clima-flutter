import 'package:clima/model/weather_model.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather_service.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.weather});

  final Weather weather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weather = Weather(condition: 0, temperature: 0.0, name: '', weatherDescription: '');
  var cityName = '';

  @override
  void initState() {
    super.initState();
    print('initState');
    weather = widget.weather;
  }

  void navigateToCityScreen() async {
    var typeName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CityScreen();
      }),
    );
    if (typeName != null) {
      print('City name : $typeName');
      var w = await WeatherService().getWeatherWithCityName(typeName);
      updateUI(w);
    }
  }

  updateUI(Weather weather) {
    setState(() {
      this.cityName = weather.name;
      this.weather = weather;
      print('Update UI : ${weather.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/location_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white70, BlendMode.dstATop),
        )),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.navigation),
                    label: Text(''),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  TextButton.icon(
                    onPressed: (){
                      setState(() {
                        navigateToCityScreen();
                      });
                    },
                    icon: Icon(Icons.location_city),
                    label: Text(''),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  '${weather.temperature}. ${weather.getWeatherIcon(weather.condition)}',
                  style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    '${weather.getMessage(weather.temperature.toInt())} in $cityName',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
