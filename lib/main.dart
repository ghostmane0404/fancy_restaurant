import 'package:fancyrestaurant/views/MealList.dart';
import 'package:fancyrestaurant/viewmodels/MealListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() =>runApp(RestApp());

class RestApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurant",
      theme: ThemeData.dark().copyWith(applyElevationOverlayColor: true),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(//needs change notifier for viewmodel
            create: (_)=>MealListViewModel(),
          )
        ],
        child: MealList(), //actual screen that comes first in app
      )
    );
  }
}

