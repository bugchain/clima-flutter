import 'package:clima/model/location_model.dart';
import 'package:clima/model/weather_model.dart';
import 'package:clima/services/location_service.dart';
import 'package:clima/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getCurrentLocation() async {
    Location location = await LocationService().getCurrentLocation();
    Weather weather = await WeatherService().getWeather(location);

    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => LocationScreen(
          weather: weather,
        ),
      ),
      (route) => false, //if you want to disable back feature set to false
    );

   /* Navigator.popAndPushNamed(
      context,
      MaterialPageRoute(
        maintainState: false,
        builder: (context) {
          return LocationScreen(weather: weather);
        },
      ),
    );*/
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  final spinKit = SpinKitRing(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.white70,
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: spinKit,
      ),
    );
  }
}
