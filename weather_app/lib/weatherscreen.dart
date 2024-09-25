import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/home_screen.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  Color getColor() {
    if (currentData['condition']['text'] == 'Clear') {
      return const Color.fromRGBO(255, 255, 255, 1);
    } else if (currentData['condition']['text'] == 'Partly Cloudy') {
      return const Color.fromRGBO(0, 0, 0, 1);
    } else if (currentData['condition']['text'] == 'Mist') {
      return const Color.fromRGBO(128, 128, 128, 1);
    }
    return const Color.fromARGB(255, 84, 142, 169);
  }

  Color getTextColor() {
    Color backgroundColor = getColor();
    if (backgroundColor == const Color.fromRGBO(0, 0, 0, 1)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(102, 93, 172, 228),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(208, 217, 224, 1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          width: 0.5,
                          color: const Color.fromARGB(255, 157, 205, 230),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "${locationData['name'] ?? 'Weather Not Found'}",
                style: GoogleFonts.abrilFatface(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${locationData['region']}",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(10 / 360),
                      child: Image.network(
                        "https:${currentData['condition']['icon']}",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentData['condition']['text'],
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: getTextColor(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${currentData['temp_c']} °C",
                      style: GoogleFonts.inter(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: getTextColor(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lat: ${locationData['lat']}°",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: getTextColor(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Lon: ${locationData['lon']}°",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: getTextColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
