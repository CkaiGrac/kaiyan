import 'package:flutter/material.dart';
import 'dart:core';
import '../home/refresh_view.dart';
/*
 * @Created Date: 2019-01-26 17:06
 * @Author: Ckai
 * @Description: 
 */

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print("HomePage初始化");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshView();
  }
}
