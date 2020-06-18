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
  var listViewModel;

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

  /*filterDataWidget(context){
    final myModel = Provider.of<MealListViewModel>(context, listen: false);
    List categories = myModel.getCategories();
    print(categories);
    String dropdownValue = categories[0];
    showModalBottomSheet(context: context, builder: (context)=>Container(
      color: Color.fromRGBO(18,18, 18, 0.3),
      height: 300,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: Row(
                children: <Widget>[
                  Text('Фильтрация по категории: ',style: TextStyle(fontFamily: 'Railway',fontSize: 20),),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontFamily: 'Railway'),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[...categories]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                  ),

                ],
              ),
            ),
            SizedBox(height: 100,),
            Center(
                child: OutlineButton(
                  onPressed: (){
                    filterByCat(dropdownValue);

                  },
                  highlightedBorderColor: Colors.purple,
                  color: Color(0xFF00FF),
                  child: Text('Filter',style: TextStyle(fontFamily: 'Railway',fontSize: 20,color: Colors.purple),),
                ),
            )
          ],
        ),
      )
    ));
  }*/

 /* Future<Null> filterByCat(String filterValue)  {
    setState(() {
      listViewModel =  Provider.of<MealListViewModel>(context,listen: false).getFilteredData(filterValue);
    });
    Navigator.of(context).pop();
    return null;
  }*/
  @override
  Widget build(BuildContext context) {
    listViewModel = Provider.of<MealListViewModel>(context);
    return Scaffold(

      appBar: AppBar(
       /* actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: (){filterDataWidget(context); },
          )
        ],*/
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