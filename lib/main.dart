import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(body: IPod()));
  }
}

class IPod extends StatefulWidget {
  IPod({Key key}) : super(key: key);

  @override
  _IPodState createState() => _IPodState();
}

class _IPodState extends State<IPod> {
  Offset prev = Offset(0, 0);

  var ctrl = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: ListView(
            controller: ctrl,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(width: 500, color: Colors.cyan),
              Container(width: 500, color: Colors.blue),
              Container(width: 500, color: Colors.red),
              Container(width: 500, color: Colors.pink),
              Container(width: 500, color: Colors.purple),
              Container(width: 500, color: Colors.orange),
            ],
          ),
        ),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onPanUpdate: _panHandler,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _panHandler(DragUpdateDetails d) {


    bool isRight = d.delta.dx >= 0.0;
    bool isUp = d.delta.dy <= 0.0;
    bool isLeft = !isRight;
    bool isDown = !isUp;

    bool onTop = d.localPosition.dy <= 150;
    bool onLeftSide = d.localPosition.dx <= 150;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;


    // Absoulte change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    // Directional change on wheel
    double vert = (onRightSide && isUp) || (onLeftSide && isDown) ? yChange : yChange * - 1;
    double horz = (onTop && isLeft) || (onBottom && isRight) ? xChange : xChange * - 1;

    // print('$horz, $vert');

      ctrl.jumpTo(
        (ctrl.offset + (horz + vert) * d.delta.distance),
        // curve: Curves.decelerate,
        // duration: Duration(milliseconds: 300),
      );

  }
}
