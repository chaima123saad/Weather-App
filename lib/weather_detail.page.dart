import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherDetail extends StatefulWidget {
  final String city;

  WeatherDetail(this.city);

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  var weatherData;

  void getData(String city) {
    String apiKey = "e6324cd99bd6387f7b0c69bc4ac65a61";
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=${city}&APPID=$apiKey";
    http.get(Uri.parse(url)).then((resp) {
      print(resp.body);
      setState(() {
        weatherData = json.decode(resp.body);
      });
    }).catchError((err) {});
  }

  @override
  void initState() {
    super.initState();
    getData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather of city : ${widget.city}'),
      ),
      body: weatherData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: weatherData['list'].length,
              itemBuilder: (context, index) {
                var date = DateTime.fromMicrosecondsSinceEpoch(
                    weatherData['list'][index]['dt'] * 1000000);
                var formattedDate = DateFormat('E dd/MM/yyyy').format(date);

                // Convert temperature from Kelvin to Celsius
                var temperature =
                    (weatherData['list'][index]['main']['temp'] - 273.15)
                        .toStringAsFixed(2);

                return ListTile(
                  leading: CircleAvatar(
                    // You might need to update this line based on your weatherData structure
                    // You should use the appropriate weatherData key for the weather icon
                    backgroundImage: AssetImage(
                        'images/${weatherData['list'][index]['weather'][0]['main']}.png'),
                  ),
                  title: Text(formattedDate),
                  trailing: Text('$temperature °C'),
                );
              },
            ),
    );
  }
}
