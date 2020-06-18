import 'package:fancyrestaurant/viewmodels/MealViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailView extends StatefulWidget {
  final MealViewModel data;
  DetailView(this.data);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailView> {

  @override
  Widget build(BuildContext context) {
    List actualName = List<String>();
    if(widget.data.name.contains('-')){
      actualName = widget.data.name.split('-');
    }else{
      actualName.add(' ');
      actualName.add(widget.data.name);
    }

    return Scaffold(
      body:Stack(
        children: <Widget>[
          _customAppBar(),
          Container(
            padding: EdgeInsets.only(top: 100),
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Stack(
                children: <Widget>[
                  Container(
                    decoration:BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg.png'),
                        fit: BoxFit.cover
                      )
                    ),
                    child:Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "image${widget.data.img}",
                        child: Image(
                          image: NetworkImage(widget.data.img),
                        ),
                      ),
                    ),
                  )

                ],
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.6,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            builder: (context,scrollController){
              return SingleChildScrollView(
                controller: scrollController,

                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(18, 18, 18, 0.6),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16,),
                      Center(
                        child: Text(actualName[1],style: TextStyle(fontFamily: 'Railway',fontSize: 34),),
                      ),
                      SizedBox(height: 16,),
                      Center(
                        child: Text(actualName[0],style: TextStyle(fontFamily: 'Railway',fontSize: 24),),
                      ),
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildInfo("Company", "${widget.data.company}"),
                          SizedBox(width: 30),
                          _buildInfo(
                              "Category", "${widget.data.category}"),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Center(
                        child: Text(
                          "ID",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text("${widget.data.id}",style: TextStyle(color: Colors.purple),),
                      ),
                      SizedBox(height: 16,),
                      Center(
                        child:Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(left: 10,right: 10,bottom: 50),
                        child: Text("${widget.data.desc}",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Railway'),),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      )
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
        SizedBox(height: 10,),
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
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 30),
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