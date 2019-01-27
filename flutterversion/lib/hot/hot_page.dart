import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-01-26 17:08
 * @Author: Ckai
 * @Description: 
 */

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HotPageState();
  }
}

class _HotPageState extends State<HotPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('热门'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}
