import 'package:flutter/material.dart';
import '../bean/Category.dart';

/*
 * @Created Date: 2019-04-19 15:21
 * @Author: Ckai
 * @Description: 
 */
Widget categoryDetailHeader(BuildContext context, Category category) {
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  return new Container(
    height: 200.0,
    child: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Image.network(
          category?.headerImage,
          fit: BoxFit.cover,
        ),
        new Container(
          color: Color(0x55000000),
        ),
        new Container(
          margin: EdgeInsets.only(top: statusBarHeight),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: new Image.asset("images/ic_action_back_white.png"),
                ),
              ),
              new Expanded(
                flex: 6,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: new Text(
                        category?.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontFamily: 'LanTing-Bold',
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Text(
                        category?.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    new Container(
                      height: 30.0,
                      width: 60.0,
                      margin: EdgeInsets.only(top: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: new Border.all(color: Colors.white)),
                      child: new Center(
                        child: new Text(
                          "+关注",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Image.asset("images/ic_action_share.png"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
