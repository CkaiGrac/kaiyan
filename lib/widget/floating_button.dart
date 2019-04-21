import 'package:flutter/material.dart';

/*
 * @Created Date: 2019-04-20 11:29
 * @Author: Ckai
 * @Description: 分类详情页的悬浮按钮小部件
 */
Widget floatingButton() {
  return new Container(
    height: 40.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
            color: const Color(0xFF808080),
            offset: Offset(0, 1.5),
            spreadRadius: 0.8),
      ],
      color: Colors.black87,
      border: Border.all(
        color: Colors.white,
        width: 5.0,
      ),
    ),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          //margin: EdgeInsets.only(bottom: 2.0),
          child: new Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 3.0),
          child: new Text(
            "立即发布",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'LanTing-Bold',
              fontSize: 13.0,
            ),
          ),
        ),
      ],
    ),
  );
}
