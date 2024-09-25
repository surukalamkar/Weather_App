import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/weather_modelclass.dart';
import 'package:weather_app/weatherscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomescreenState();
}

Map<String, dynamic> locationData = {};
Map<String, dynamic> currentData = {};
String location = 'Pune';

class _HomescreenState extends State<HomePage> {
  TextEditingController inputLocationController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=580857fd9d414dd5a4b132050241609&q=$location");
    http.Response response = await http.get(url);

    var responseData = json.decode(response.body);

    WeatherModel weatherModel = WeatherModel.fromJson(responseData);
    setState(() {
      locationData = weatherModel.location?.toJson() as Map<String, dynamic>;
      currentData = weatherModel.current?.toJson() as Map<String, dynamic>;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(52, 147, 195, 1),
              Color.fromRGBO(255, 255, 255, 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 30, right: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.8),
                          Color.fromRGBO(83, 81, 81, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        width: 1,
                        color:Color.fromARGB(255, 190, 219, 226), 
                      ),
                    ),
                    child: TextField(
                      controller: inputLocationController,
                      onSubmitted: (value) {
                        setState(() {
                          location = inputLocationController.text;
                          getWeatherData();
                          inputLocationController.clear();
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Location',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 1, 19, 26)),
                        icon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(1, 20, 31, 0.902),
                        ),
                      ),
                      keyboardAppearance: Brightness.dark,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              if (isLoading)
                const CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Weatherscreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 170,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(102, 93, 172, 228),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(141, 132, 132, 1),
                            spreadRadius: 3,
                            blurRadius: 4),
                      ],
                      border: Border.all(
                        width: 0.4,
                        color: const Color.fromARGB(255, 227, 229, 231),
                        
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${locationData['name'] ?? 'Weather Not Found'}",
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "${locationData['region']}",
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${locationData['country']}",
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 25, top: 50),
                          child: Column(
                            children: [
                              Text(
                                "${currentData['temp_c']} °C",
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              const SizedBox(height: 35),
                             
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 60,
              ),
              const Image(
                image: AssetImage("assets/cloud_img.png"),
                height: 220,
                width: 270,
              ),
              Text(
                "Weather",
                style: GoogleFonts.abrilFatface(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
