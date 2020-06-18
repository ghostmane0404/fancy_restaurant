class MealData{
  String name;
  int price;
  String desc;
  String company;
  String category;
  String id;
  String img;
  MealData({this.name,this.price,this.desc,this.company,this.category,this.id,this.img});

  
  //create new MealData with factory metod
  factory MealData.fromJson(Map <String,dynamic> json)
  {
    return MealData(
    name: json['name'],
      price: json['price'],
      desc: json['desc'],
      company: json['company'],
      category: json['category'],
      id: json['id'],
      img: json['img']
    );
  }

}