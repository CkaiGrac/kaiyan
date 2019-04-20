import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-04-20 10:36
 * @Author: Ckai
 * @Description: 
 */

Widget mAppBar(double appBarAlpha, {String title}) {
  return new Column(
    children: <Widget>[
      new Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        height: 80.0,
        color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
        child: new Center(
          child: new Text(
            title,
            style: new TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB((appBarAlpha * 255).toInt(), 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'),
          ),
        ),
      ),
      new Container(
        height: appBarAlpha > 0.2 ? 0.5 : 0,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 0.5),
          ],
        ),
      ),
    ],
  );
}
