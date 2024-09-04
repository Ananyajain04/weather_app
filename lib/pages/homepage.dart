import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:myapp/cons.dart';

//creating a stateful widget as the state needs to be changed everytime its entered
class Weather_App extends StatefulWidget {
  const Weather_App({super.key});
  @override
  State<Weather_App> createState() => _WeatherState();
}

class _WeatherState extends State<Weather_App> {
  //weather factory is a widget provided by the weather package
  final WeatherFactory _wf = WeatherFactory(openweatherapi);
  //controller has been defined to change the city when the enter
  //key is pressed
  final TextEditingController _controller = TextEditingController();
  // a string to store the cityname
  String w = "Delhi";
  //Weather is a class to store the weather data fetched from api
  Weather? _weather;
  @override
  void initState() {
    super.initState();
    // before the widgte is ran we have a predefined input which gives
    // the variable a cityname before the user enters one themselves
    _wf.currentWeatherByCityName("Hyderabad").then((w) {
      setState(() {
        //setState changes the UI on the basis of the name
        _weather = w;
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          backgroundColor: const Color.fromARGB(255, 245, 221, 250),
        ),
        body: maincontent(),
        bottomNavigationBar: bottomnavbar(),
      ),
    );
  }

  Center maincontent() {
    return Center(
      child: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            //contains all the main fields of the app
            inputfield(),
            space(),
            button(),
            space(),
            location(),
            maxtemp(),
            mintemp()
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  Widget inputfield() {
    return TextField(
      textAlign: TextAlign.center,
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Enter City',
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
        child: Text('Enter'),
        onPressed: () {
          setState(() {
            w = _controller.text; // the text entered in input field
            //gets entered into the variable w
          });
          // the w is used to fetch data from the api
          // fetched data is stored into weather(Another variable)
          // weather then gives this data _weather which triggers UI change
          _wf.currentWeatherByCityName(w).then((weather) {
            setState(() {
              _weather = weather; // Update the weather information
            });
          });
        });
  }

  Widget space() {
    return SizedBox(height: 25);
  }

  Widget location() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget maxtemp() {
    return Text(_weather?.tempMax?.toString() ?? "not found");
  }

  Widget mintemp() {
    return Text(_weather?.tempMin?.toString() ?? "not found");
  }

  BottomNavigationBar bottomnavbar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'school',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'business',
        ),
      ],
    );
  }
}
