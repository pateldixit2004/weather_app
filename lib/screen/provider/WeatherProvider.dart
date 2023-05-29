import 'package:flutter/material.dart';
import 'package:weather_app/screen/model/cityListModel.dart';
import 'package:weather_app/screen/model/weatherModal.dart';
import 'package:weather_app/utils/api_helper.dart';

class WeatherProvider extends ChangeNotifier
{
  Future<WeatherModal> weatherget(String? lata, String? lono)
  async {
    WeatherModal weatherModal = await Api_helper.apihelper.getApi(lat: lata,lon: lono);
    return weatherModal;
  }


  List<CityListModel> citi=[
    CityListModel(lat:"21.1702" ,long: "72.8311",name: "Surat"),
    CityListModel(lat:"34.2268" ,long: "77.5619",name: "Ladakh"),
    CityListModel(lat:"31.1048" ,long: "77.1734",name: "Shimla"),
  ];
  List citiList=[
    'surat','ladakh',"Shimla"
  ];

  String selectCiti='surat';
  int index=0;
  void chnageCity(String value)
  {
    selectCiti=value;
    index=citiList.indexOf(value);
    notifyListeners();
  }
  String image='assets/image/sun.png';
  void tempchange(double temp)
  {
    if(temp>=30)
      {
        image= 'assets/image/sunny.png';
      }
    else if(temp>=25)
      {
        image= 'assets/image/sun.png';

      }
    else if(temp>=20)
      {
        image='asstes/image/cloude.png';
      }
    else
      {
        image ='assets/image/img.png';
      }
  }
}