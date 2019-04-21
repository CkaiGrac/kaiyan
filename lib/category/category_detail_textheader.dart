import 'package:flutter/material.dart';

/*
 * @Created Date: 2019-04-20 10:11
 * @Author: Ckai
 * @Description: 列表头的小部件
 */
Widget textHeader(String title) {
  return Container(
    margin: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
    child: new Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 22.0, fontFamily: 'LanTing-Bold'),
    ),
  );
}
