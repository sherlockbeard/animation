import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      body: SizedBox.expand(child: RadicalMenu()),
    ));
  }
}

class RadicalMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RadicalMenu();
  }

}

class _RadicalMenu extends State<RadicalMenu> with SingleTickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =AnimationController(duration: Duration(milliseconds: 900),vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RadicalAnimation(controller: controller);
  }

}
