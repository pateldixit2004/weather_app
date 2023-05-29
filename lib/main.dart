import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/screen/provider/WeatherProvider.dart';
import 'package:weather_app/screen/view/home_screen.dart';

void main() {
  runApp(Sizer(
    builder: (context, orientation, deviceType) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Home_Screen(),
        },
      ),
    ),
  ));
}
