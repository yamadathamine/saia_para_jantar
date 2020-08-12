import 'dart:convert';

import 'package:flutter/material.dart';
import '../../models/item.dart';
import '../../models/restaurant.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }

}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return _buildHome();
  }

  Widget _buildHome(){
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }

  Widget _buildBody(){
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
      builder: (context, snapshot){
        List<dynamic> restaurants = json.decode(snapshot.data.toString());
        return ListView.builder(
            itemBuilder: (BuildContext context, int index){
              Restaurant rest = Restaurant.fromJson(restaurants[index]);
              return _buildRestaurant(rest.restaurante);
            },
            itemCount: restaurants == null ? 0 : restaurants.length,
        );
      },
    );
  }

  Widget _buildRestaurant(restaurantName){
    return Column(
      children: [
        Text(restaurantName),
        _buildListItem(restaurantName)
      ],
    );
  }

  Widget _buildListItem(restaurant){
    return Container
      (height:250,
        child: FutureBuilder(
            future: DefaultAssetBundle
                .of(context)
                .loadString('assets/items.json'),
            builder: (context, snapshot){
              List<dynamic> items = json.decode(snapshot.data.toString());
              items = items.where((item) => Item.fromJson(item).restaurante == restaurant).toList();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    Item item = Item.fromJson(items[index]);
                    return _buildItem(item.foto, item.nomeDoPrato);
                  },
                  itemCount: items == null ? 0 : items.length,
              );
            }
        ));
  }

  Widget _buildItem(foto, nomeDoPrato){
    return SizedBox(
      height: 250,
      width: 200,
      child: Card(
        color: Colors.deepOrange,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(foto),
            Text(nomeDoPrato)
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(title: Text('Hello'),);
  }
}