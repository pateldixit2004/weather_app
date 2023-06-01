import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/screen/model/weatherModal.dart';
import 'package:weather_app/screen/provider/WeatherProvider.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  WeatherProvider? providerF;
  WeatherProvider? providerT;
  @override
  Widget build(BuildContext context) {
    providerF=Provider.of<WeatherProvider>(context,listen: false);
    providerT=Provider.of<WeatherProvider>(context,listen: true);
    return SafeArea(child: Scaffold(
      body:FutureBuilder(builder: (context, snapshot) {
        if(snapshot.hasData)
          {
            WeatherModal? weatherModal =snapshot.data;
            providerF!.tempchange(weatherModal!.main!.temp!);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_rounded,color: Colors.white54,size: 20.sp,),
                      DropdownButton(items: providerF!.citiList!.map((e) => DropdownMenuItem(child: Text("$e"),value: e,)).toList(), onChanged: (value) {
                        providerF!.chnageCity(value as String);
                      },
                      value: providerT!.selectCiti,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                      children: [
                        Image.asset('${providerT!.image}')
                      ],
                    ),
                  ),
                  Text("${weatherModal!.weather![0].description}"),
                  Row(
                    children: [
                      Text("${weatherModal!.main!.temp}C"),
                      Text("${weatherModal!.weather![0].main}C"),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        tile(data: '${weatherModal!.wind!.speed}',ti: 'wind',img: 'assets/image/img.png'),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        else if(snapshot.hasError)
          {
            return Text("${snapshot.hasError}");
          }
        return Center(child: CircularProgressIndicator());
      },future: providerF!.weatherget(providerT!.citi[providerT!.index].lat,providerT!.citi[providerT!.index].long),
    ),));
  }
  Widget tile({String? data, String? ti,String? img})
  {
    return Container(
      height: 25.h,
      width: 20.w,
      child: Column(
        children: [
          Image.asset("$img"),
          Spacer(),
          Text("$data"),
          Text("$ti"),
        ],
      ),
    );

  }
}
