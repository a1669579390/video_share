import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Positioned(
          child: ElevatedButton(
            child: new Text('点我'),
            onPressed: () {},
          ),
          right: 15,
          bottom: 15,
        ),
        Icon(Icons.arrow_drop_down, size: 40, color: Colors.red),
      ],
      alignment: Alignment.center,
    ));
  }
}
