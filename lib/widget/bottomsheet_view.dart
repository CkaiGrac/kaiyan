import 'package:flutter/material.dart';
import '../widget/reply_view.dart';
import '../widget/reply_with_parent.dart';
import '../bean/Issue.dart';

/*
 * @Created Date: 2019-04-17 09:13
 * @Author: Ckai
 * @Description: 向上弹出抽屉
 */
Widget bottomSheetView(BuildContext context, Issue replyData) {
  return new Column(
    children: <Widget>[
      new Container(
        height: 0.2,
        color: Colors.white70,
        width: MediaQuery.of(context).size.width,
      ),
      new Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Image.asset(
              "images/pgc_default_avatar.png",
              height: 35.0,
              width: 35.0,
            ),
            new GestureDetector(
              onTap: () {
                print("跳转登陆页面");
              },
              child: new Container(
                alignment: Alignment.centerLeft,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black38,
                  border: Border.all(color: Colors.white30),
                ),
                child: new Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: new Text(
                    "点击发表你的评论",
                    style: new TextStyle(color: Colors.white70),
                  ),
                ),
                width: MediaQuery.of(context).size.width - 48.0 - 48.0 - 30.0,
                height: 35.0,
              ),
            ),
            new GestureDetector(
              onTap: () {
                ///点击 X 关闭上弹抽屉
                Navigator.of(context).pop();
              },
              child: new Image.asset(
                "images/action_close_white.png",
                height: 35.0,
                width: 35.0,
              ),
            ),
          ],
        ),
      ),
      new Container(
        height: 0.2,
        color: Colors.white70,
        width: MediaQuery.of(context).size.width,
      ),
      new Expanded(
        child: new ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: replyData.itemList.length,
          itemBuilder: (context, position) {
            if (replyData.itemList[position]?.type == "leftAlignTextHeader") {
              return new Container(
                margin: EdgeInsets.only(
                  left: 15.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: new GestureDetector(
                  onTap: () {
                    print("更多热门评论");
                    Scaffold.of(context).showBottomSheet((context) {
                      return new Container(
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.width / 1.28,
                        color: Colors.blueAccent,
                      );
                    });
                  },
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        replyData?.itemList[position]?.data?.text,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Image.asset(
                        "images/ic_action_more_arrow.png",
                        width: 40.0,
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              );
            }
            return new Container(
              margin: EdgeInsets.only(bottom: 15.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Container(
                      alignment: Alignment.topCenter,
                      child: new ClipOval(
                        child: new Image.network(
                          replyData.itemList[position]?.data?.user?.avatar,
                          height: 48.0,
                          width: 48.0,
                        ),
                      ),
                    ),
                  ),
                  ///根据有无[parentReply]返回不同布局
                  replyData.itemList[position].data?.parentReply == null
                      ? replyView(context, replyData, position)
                      : replyWithParent(context, replyData, position),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
