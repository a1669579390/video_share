import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child:
          Text('正在紧急开发', style: TextStyle(color: Colors.amber, fontSize: 20)),
    ));
  }
}
