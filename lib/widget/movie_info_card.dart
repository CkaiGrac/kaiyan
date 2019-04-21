import 'dart:async';

import 'package:flutter/material.dart';
import '../bean/Item.dart';
import '../global_config.dart';
import '../bean/Issue.dart';
import '../net/network_manager.dart';
import '../widget/bottomsheet_view.dart';

/*
 * @Created Date: 2019-04-08 13:33
 * @Author: Ckai
 * @Description: 视频信息卡片
 */
class MovieInfoCard extends StatefulWidget {
  final Item item;
  MovieInfoCard({this.item});
  @override
  State<StatefulWidget> createState() {
    return _MovieInfoCardState();
  }
}

class _MovieInfoCardState extends State<MovieInfoCard> {
  String tag = "";
  Issue replyData;
  HttpManager dioManager = HttpManager.instance;

  @override
  void initState() {
    super.initState();
    _getReplyData(widget.item.data.id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.data?.library == "DAILY")
      tag = " / 开眼精选";
    else
      tag = "";
    return new Container(
      margin: EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            widget.item.data?.title,
            style: new TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(
              "#" +
                  widget.item.data?.category +
                  " / " +
                  "${durationFormat(widget.item.data.duration)}" +
                  tag,
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
          new Container(
            child: new Text(
              widget.item.data?.description,
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 15.0, right: 25.0),
                child: new Row(
                  children: <Widget>[
                    new Image.asset(
                      "images/ic_action_favorites_without_padding.png",
                      height: 28.0,
                      width: 28.0,
                    ),
                    new Text(
                      "${widget.item.data?.consumption?.collectionCount}",
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 15.0, right: 25.0),
                child: new Row(
                  children: <Widget>[
                    new Image.asset(
                      "images/ic_action_share_without_padding.png",
                      height: 28.0,
                      width: 28.0,
                    ),
                    new Text(
                      "${widget.item.data?.consumption?.shareCount}",
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              new GestureDetector(
                onTap: () {
                  Scaffold.of(context).showBottomSheet((context) {
                    return new Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.width / 1.28,
                      child: new Stack(
                        children: <Widget>[
                          new Image.network(
                            widget.item.data?.cover?.blurred,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          ),
                          new Container(
                            color: Color(0x33000000),
                          ),
                          bottomSheetView(context, replyData),
                        ],
                      ),
                    );
                  });
                },
                child: new Container(
                  margin: EdgeInsets.only(top: 15.0, right: 25.0),
                  child: new Row(
                    children: <Widget>[
                      new Image.asset(
                        "images/ic_action_reply_without_padding.png",
                        height: 28.0,
                        width: 28.0,
                      ),
                      new Text(
                        "${widget.item.data?.consumption?.replyCount}",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 15.0, right: 15.0),
                child: new Row(
                  children: <Widget>[
                    new Image.asset(
                      "images/ic_action_offline_without_padding.png",
                      height: 28.0,
                      width: 28.0,
                    ),
                    new Text(
                      "缓存",
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _getReplyData(num id) async {
    replyData = await dioManager.doGetReplyData(
        GlobalConfig.BASEAPI + GlobalConfig.REPLY + "videoId=$id");
    setState(() {});
  }
}
