import 'package:fancyrestaurant/models/MealData.dart';
import 'package:fancyrestaurant/services/ReadService.dart';
import 'package:fancyrestaurant/viewmodels/MealViewModel.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus{
  completed,
  loading,
  empty
}
class MealListViewModel with ChangeNotifier {

  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<MealViewModel> meals = List<MealViewModel>();
  List<MealViewModel> mealsShort = List<MealViewModel>();
  int _currentMax = 10;

  void getTenMeals() async{

    List <MealData>  newMeals = await ReadService().loadData();
    loadingStatus = LoadingStatus.loading;
    notifyListeners();
    this.meals = newMeals.map((meal) => MealViewModel(mealData: meal)).toList();
    for(int i = 0;i<10;i++){
      this.mealsShort.add(this.meals[i]);
    }
    if(this.meals.isEmpty){
      this.loadingStatus = LoadingStatus.empty;
    }
    else{
      this.loadingStatus  = LoadingStatus.completed;
    }
  }
  void getMore() {
    for(int i = _currentMax;i<_currentMax+10;i++){
      this.mealsShort.add(this.meals[i]);
    }
    if(_currentMax<=meals.length) {
      _currentMax = _currentMax + 10;
      print("triggered< current max is:" + _currentMax.toString());
    }
  }

  getDetail(int position){
    return meals[position];
  }
}