import 'package:flutter/material.dart';
import 'index/index.dart';

void main() => runApp(Kaiyan());

class Kaiyan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "仿开眼",
      home: new Index(),
    );
  }
}
