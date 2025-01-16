import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Constant.dart';


class ApiCaller{
  static dynamic callApiWeatherByCityName(String cityName) async {
    try{
      String _url="${weatherApi}?q=$cityName&appid=$OPENWEATHER_API_KEY";
      var response = await http.get(Uri.parse(_url));
      return response;
    }catch(e){
      debugPrint(e.toString());
      return {};
    }

  }
  static String callApiFlagsByCode(String codeCountry) {
    String _url="${flagsApi}${codeCountry}/flat/64.png";
    return _url;
  }
}