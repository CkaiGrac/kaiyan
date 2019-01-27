import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-01-26 17:07
 * @Author: Ckai
 * @Description: 
 */

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('分类'),
          actions: <Widget>[new Container()],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}
