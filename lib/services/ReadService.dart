import 'dart:convert';
import 'package:fancyrestaurant/models/MealData.dart';
import 'package:flutter/services.dart';


class ReadService{
  List <MealData> data;
  MealData meal;
  loadData() async{
    var jsonText  = await rootBundle.loadString('assets/MOCK_DATA.json');
    data = (json.decode(jsonText) as List).map((i) =>
    MealData.fromJson(i)).toList();//creating MealData with factory method
    return data;
  }

}

