import 'package:flutter/material.dart';
import 'weather_detail.page.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String city = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(city),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Weather App :",
                  style: TextStyle(fontSize: 30, color: Colors.blue)),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                width: 150.0,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Enter city name'),
                  onChanged: (text) {
                    setState(() {
                      city = text;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherDetail(city),
                    ),
                  );
                },
                child: Text('Get Weather...'),
              ),
            ],
          ),
        ));
  }
}
