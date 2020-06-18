import 'package:fancyrestaurant/models/MealData.dart';

class MealViewModel{
  MealData mealData;
  MealViewModel({MealData mealData}): this.mealData = mealData;
  String get name {
    return mealData.name;
  }
  int get price {
    return mealData.price;
  }
  String get desc {
    return mealData.desc;
  }
  String get company {
    return mealData.company;
  }
  String get category {
    return mealData.category;
  }
  String get id {
    return mealData.id;
  }
  String get img {
    return mealData.img;
  }
  
}