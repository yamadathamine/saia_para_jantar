import 'package:flutter/material.dart';

class Details extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }

  Widget _buildAppBar(){
    return AppBar(title: Text('Saia para Jantar'),);
  }

}