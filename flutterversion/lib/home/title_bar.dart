import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-02-05 16:15
 * @Author: Ckai
 * @Description: 
 */

class TitlebarWidget extends StatelessWidget {
  bool isVisible;
  String title;

  TitlebarWidget(this.isVisible, this.title);

  @override
  Widget build(BuildContext context) {
    return new Offstage(
      offstage: isVisible,
      child: new Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: new Center(
          child: new Text(title),
        ),
      ),
    );
  }
}
