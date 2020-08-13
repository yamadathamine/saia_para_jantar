import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:saia_para_jantar/screen/detail/detail.dart';
import '../../models/item.dart';
import '../../models/restaurant.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }

}

class HomeState extends State<Home>{
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";

  @override
  Widget build(BuildContext context) {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
    return _buildHome();
  }

  Widget _buildHome(){
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }

  Widget _buildBody(){
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          _buildSearch(),
          _buildListRestaurants(),
        ],
      ),
    );
  }

  Widget _buildSearch(){
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildListRestaurants(){
    return Flexible(
      child: FutureBuilder(
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
      ),
    );
  }

  Widget _buildRestaurant(restaurantName){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: Text(
            restaurantName,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        _buildListItem(restaurantName),
         Divider(
          color: Colors.grey,
          height: 10,
          thickness: 0.2,
        )
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
              if (items != null){
                items = items.where( (item){
                  if (Item.fromJson(item).restaurante == restaurant &&
                      (Item.fromJson(item).nomeDoPrato.toLowerCase().contains(_query.toLowerCase()) ||
                      Item.fromJson(item).descricao.toLowerCase().contains(_query.toLowerCase()) ||
                      Item.fromJson(item).restaurante.toLowerCase().contains(_query.toLowerCase()))){
                  return true;
                } else {
                  return false;
                }}).toList();
              }
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
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Details()
        ));
      },
      child: SizedBox(
        height: 250,
        width: 200,
        child: Card(
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(foto),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      nomeDoPrato,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(title: Text('Saia para Jantar'),);
  }
}