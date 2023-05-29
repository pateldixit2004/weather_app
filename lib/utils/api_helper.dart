import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/screen/model/weatherModal.dart';

class Api_helper
{
  static Api_helper apihelper=Api_helper();

  Future<WeatherModal> getApi({required String? lat,required String? lon})
  async {
    String link= 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=6e2a97e08f38f6d24bc52bc3f1a5c97a';
    var responce= await http.get(Uri.parse(link));

    var json =jsonDecode(responce.body);
    WeatherModal weatherModal =WeatherModal.fromJson(json);
    return weatherModal;
  }
}