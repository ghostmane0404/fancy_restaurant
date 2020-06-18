import 'package:fancyrestaurant/viewmodels/MealViewModel.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final MealViewModel data;
  DetailView(this.data);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailView> {

  @override
  Widget build(BuildContext context) {
    List actualName;
    if(widget.data.name.contains('-')){
      actualName = widget.data.name.split('-');
    }else{
      actualName.add('dish');
      actualName.add(widget.data.name);
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 25),
          _customAppBar(),
          Container(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/bg.png"),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: "image${widget.data.img}",
                    child: Image(
                      image: NetworkImage(widget.data.img),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child:Text(
                      "${actualName[1]}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child:Text(
                      "${actualName[0]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        "\$${widget.data.price.toInt()}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(width: 30),
                      _buildCounter(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildInfo("Company", "${widget.data.company}"),
                      _buildInfo(
                          "Category", "${widget.data.category}"),
                    ],
                  ),
                  SizedBox(height: 16),
                  /*Text(
                    "ID",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("${widget.data.id}",style: TextStyle(color: Colors.purple),),
                  Expanded(child: SizedBox()),
                  SizedBox(height: 8),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("${widget.data.desc}",style: TextStyle(color: Colors.white),),*/

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "$val",
          style: TextStyle(
            fontSize: 16,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _customAppBar() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 0.4),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(18, 18, 18, 0.4),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Icon(
              Icons.shopping_cart,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(18, 18, 18, 0.6),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.purple,
            ),
            onPressed: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "1",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.purple,
            ),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}