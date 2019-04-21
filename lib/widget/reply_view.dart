import 'package:flutter/material.dart';
import '../bean/Issue.dart';
import 'package:common_utils/common_utils.dart';
/*
 * @Created Date: 2019-04-16 18:02
 * @Author: Ckai
 * @Description: 回复布局，不带parentReply
 */

Widget replyView(BuildContext context, Issue replyData, int position) {
  String formattedTime = TimelineUtil.format(
      replyData.itemList[position]?.data?.createTime,
      dayFormat: DayFormat.Common);
  return new Expanded(
    flex: 5,
    child: new Container(
      margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 5,
                child: new Container(
                  child: new Text(
                    replyData.itemList[position]?.data?.user?.nickname,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Row(
                  children: <Widget>[
                    new Text(
                      replyData?.itemList[position]?.data?.likeCount.toString(),
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    new Image.asset(
                      "images/ic_action_like.png",
                      width: 28.0,
                      height: 28.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Container(
            child: new Text(
              replyData?.itemList[position]?.data?.message,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  print("打开回复页面");
                },
                child: Text(
                  "回复      " + formattedTime,
                  style: new TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0
                  ),
                ),
              ),
              new Image.asset(
                "images/ic_action_reply_more.png",
                width: 30.0,
                height: 30.0,
              ),
            ],
          ),
          new Container(
            height: 0.2,
            color: Colors.white70,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    ),
  );
}
