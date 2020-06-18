import 'dart:convert';

import 'package:fancyrestaurant/views/DetailView.dart';
import 'package:fancyrestaurant/models/MealData.dart';
import 'package:fancyrestaurant/viewmodels/MealListViewModel.dart';
import 'package:fancyrestaurant/services/ReadService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MealListState();
  }
}
class MealListState extends State<MealList>{
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<MealListViewModel>(context,listen: false).getTenMeals(); //get init data to fill while initing screen
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){//user reached bottom of screen
        _getMoreData();
      }
    });
  }

  //loading ten more items from json
  _getMoreData(){
    setState(() {
      Provider.of<MealListViewModel>(context,listen: false).getMore();//reaching getMore function of view model
    });

  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<MealListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal menu",style:TextStyle(fontSize: 22,fontFamily: 'Raleway')),
        centerTitle: true,
        //backgroundColor: Color.fromRGBO(18, 18, 18, 0.90),

      ),
      body: ListView.builder(
              itemExtent: 60,
              controller: _scrollController,
              itemBuilder: (context,i){
                if(i == listViewModel.mealsShort.length){//show loading spinner if user reaches the end of screen
                  return CupertinoActivityIndicator();
                }
                return  Container(
                  color: Color.fromRGBO(18, 18, 18, 0.85),
                  child: ListTile(
                    title: Text(listViewModel.mealsShort[i].name,style:TextStyle(fontSize: 18,fontFamily: 'Raleway')),
                    leading:  Image(
                      image: NetworkImage(listViewModel.mealsShort[i].img),
                    ),
                    onTap:  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailView(listViewModel.mealsShort[i])),
                      );
                    },
                    trailing:  CircleAvatar(
                      backgroundColor: Colors.purple,
                        child:Text("\$"+listViewModel.mealsShort[i].price.toString(),style: TextStyle(fontSize: 16,fontFamily: "assets/Ubuntu-Regular.ttf"),)),
                    contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                  ),

                );
              },
              itemCount: listViewModel.mealsShort.length+1,
            )
    );
  }
}