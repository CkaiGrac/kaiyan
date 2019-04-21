import 'dart:async';

import 'package:flutter/material.dart';
import '../bean/Item.dart';
import '../net/network_manager.dart';
import '../bean/Issue.dart';
import '../global_config.dart';
import '../widget/detail_page.dart';
/*
 * @Created Date: 2019-02-20 11:10
 * @Author: Ckai
 * @Description: 周排、月拍、总排行的通用布局
 */

class RankingView extends StatefulWidget {
  final String url;
  RankingView(this.url);

  @override
  State<StatefulWidget> createState() {
    return _RankingViewState();
  }
}

class _RankingViewState extends State<RankingView>
    with AutomaticKeepAliveClientMixin {
  List<Item> itemList = <Item>[];
  Issue issue;
  HttpManager dioManager = HttpManager.instance;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("RankingView初始化");
    getRanking(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return issue == null
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int position) {
              return new GestureDetector(
                onTap: () {
                  //print(itemList[position].data.playUrl);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new DetailPage(
                            item: issue.itemList[position],
                          ),
                    ),
                  );
                },
                child: new Card(
                  elevation: 0.4,
                  child: new Stack(
                    children: <Widget>[
                      new Image.network(
                        itemList[position].data?.cover?.feed,
                        fit: BoxFit.cover,
                        height: 270.0,
                      ),
                      new Container(
                        color: Color(0x55000000),
                        height: 270.0,
                      ),
                      new Positioned(
                        top: 1.0,
                        bottom: 1.0,
                        left: 1.0,
                        right: 1.0,
                        child: Center(
                          child: new Text(
                            itemList[position].data?.title,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'LanTing-Bold',
                            ),
                          ),
                        ),
                      ),
                      new Positioned(
                        left: 1.0,
                        right: 1.0,
                        bottom: 100.0,
                        child: new Center(
                          child: new Text(
                            '#' +
                                itemList[position].data?.category +
                                " / " +
                                "${durationFormat(itemList[position].data.duration)}",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontFamily: 'LanTing',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
  }

  Future<void> getRanking(String url) async {
    issue = await dioManager.doGetRanking(url);
    itemList.addAll(issue?.itemList);
    setState(() {});
  }
}
