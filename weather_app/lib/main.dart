import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controler = TextEditingController();
  String city = "Vavuniya";
  String weather = "";
  String temp = "";
  bool loading =false;

  Future<void> fetchWeather(String cityName) async {
    setState(() => loading =true);

    const apiKey ="bc33e653f2c57c584f88cf01918c1e13";
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weather = data["weather"][0]["description"];
          temp = data["main"]["temp"].toString();
          city = data["name"];
        });
      } else {
        setState(() {
          weather = "City not found!";
          temp ="";
        });
      }
    } catch (e) {
      setState(() {
        weather = "Error fetching data";
        temp ="";
      });
    }

    setState(() => loading =false);
  }

  @override
  void initState() {
    super.initState();
    fetchWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controler,
              decoration: InputDecoration(
                hintText: "Enter city name",
                suffixIcon: IconButton(
                  onPressed: () {
                    fetchWeather(_controler.text);
                  }, 
                  icon: const Icon(Icons.search)
                  ),
              ),
            ),
            const SizedBox(height: 30),
            loading
            ? const CircularProgressIndicator()
            : Column(
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  temp.isNotEmpty ? "$temp °C" : "",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  weather,
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            )
          ],
        ),
        ),
    );
  }
}