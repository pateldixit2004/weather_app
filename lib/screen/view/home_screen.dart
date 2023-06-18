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
                      DropdownButton(items: providerF!.citiList.map((e) => DropdownMenuItem(child: Text("$e"),value: e,)).toList(), onChanged: (value) {
                        providerF!.chnageCity(value as String);
                      },
                      value: providerT!.selectCiti,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('${providerT!.image}',height: 60.h,width: 50.w,)
                      ],
                    ),
                  ),
                  Text("${weatherModal.weather![0].description}"),
                  Row(
                    children: [
                      Text("Temp-${weatherModal.main!.temp}°C",style: TextStyle(color: Colors.orange),),
                      // Text("${weatherModal.weather![0].main} "),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [

                      Text("humidity-${weatherModal.main!.humidity}",style: TextStyle(color: Colors.black45),),
                      // Text("${weatherModal.weather![0].main} "),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("pressure-${weatherModal.main!.pressure}"),
                      SizedBox(height: 10,),
                      Text("${weatherModal.weather![0].id} "),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tile(data: '${weatherModal.wind!.speed}',ti: 'wind',img: 'assets/image/img.png'),
                        tile(data: '${weatherModal.wind!.gust}',ti: 'gust',img: 'assets/image/img.png'),
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
    return Column(
      children: [
        Container(height: 50,width:50,child: Image.asset("$img",height: 30,width: 30,)),

        Text("$data"),
        Text("$ti"),
      ],
    );

  }
}
