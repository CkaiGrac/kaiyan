import 'package:flutter/material.dart';
import '../bean/Category.dart';
/*
 * @Created Date: 2019-02-07 13:23
 * @Author: Ckai
 * @Description: 
 */

Widget itemView(BuildContext context, Category category) {
  return new GestureDetector(
    onTap: () {
      print(category.id);
    },
    child: new Card(
      elevation: 0.4,
      child: new Stack(
        children: <Widget>[
          new Image.network(category.bgPicture, fit: BoxFit.fill),
          new Container(
            color: Color(0x55000000),
          ),
          new Center(
            child: new Text(
              '#' + category.name,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LanTing-Bold',
              ),
            ),
          )
        ],
      ),
    ),
  );
}
