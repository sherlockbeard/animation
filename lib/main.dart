import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

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

class RadicalMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RadicalMenu();
  }
}

class _RadicalMenu extends State<RadicalMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RadicalAnimation(controller: controller);
  }
}

class RadicalAnimation extends StatelessWidget {
  final AnimationController controller;
  RadicalAnimation({Key key, this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.9,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;
  build(context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Transform.rotate(
          // Add rotation
          angle: ((math.pi / 180.0)*rotation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildButton(0,
                  color: Colors.red, icon: FontAwesomeIcons.thumbtack),
              _buildButton(45,
                  color: Colors.green, icon: FontAwesomeIcons.sprayCan),
              _buildButton(90,
                  color: Colors.orange, icon: FontAwesomeIcons.fire),
              _buildButton(135,
                  color: Colors.blue, icon: FontAwesomeIcons.kiwiBird),
              _buildButton(180,
                  color: Colors.black, icon: FontAwesomeIcons.cat),
              _buildButton(225,
                  color: Colors.indigo, icon: FontAwesomeIcons.paw),
              _buildButton(270,
                  color: Colors.pink, icon: FontAwesomeIcons.bong),
              _buildButton(315,
                  color: Colors.yellow, icon: FontAwesomeIcons.bolt),
              Transform.scale(
                scale: scale.value - 1.5,
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.timesCircle),
                  onPressed: _close,
                  backgroundColor: Colors.red,
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.solidDotCircle),
                  onPressed: _open,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    num degToRad(num deg) => deg * (math.pi / 180.0);
    final double rad = degToRad(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            child: Icon(icon),
            backgroundColor: color,
            onPressed: _close,
            elevation: 0));
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
