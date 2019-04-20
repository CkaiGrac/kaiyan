import 'dart:async';

import 'package:flutter/material.dart';
import '../widget/detail_page.dart';
import '../global_config.dart';
import '../net/network_manager.dart';
import 'package:flutterversion/global_config.dart';
import '../bean/Issue.dart';

/*
 * @Created Date: 2019-04-14 16:47
 * @Author: Ckai
 * @Description: 
 */

class SliverItemView extends StatefulWidget {
  final int id;
  SliverItemView({this.id});
  @override
  State<StatefulWidget> createState() {
    return _SliverItemViewState();
  }
}

class _SliverItemViewState extends State<SliverItemView> {
  HttpManager dioManager = HttpManager.instance;
  Issue issue;

  @override
  void initState() {
    super.initState();
    getItemData();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, position) {
          if (issue.itemList[position].type == "textHeader") {
            return new Center(
              child: new Container(
                margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                child: new Text(
                  issue.itemList[position].data.text,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          String tagsText = "";
          issue.itemList[position]?.data?.tags?.take(3)?.forEach((tag) {
            tagsText += tag.name + " / ";
          });

          if (issue.itemList[position].type == "textHeader" &&
              issue.itemList[position].data.dataType == "VideoBeanForClient") {
            return new GestureDetector(
              onTap: () {
                print(issue.itemList[position]?.data?.playUrl);
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
                child: new Column(
                  children: <Widget>[
                    new Container(
                      child: new FadeInImage.assetNetwork(
                          placeholder: "images/home_page_header_cover.jpg",
                          image: issue.itemList[position]?.data?.cover?.feed,
                          fit: BoxFit.fitWidth),
                    ),
                    new Container(
                      margin: EdgeInsets.only(
                          left: 10.0, bottom: 8.0, top: 10.0, right: 10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Expanded(
                            flex: 1,
                            child: new Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: new ClipOval(
                                child: new FadeInImage.assetNetwork(
                                  placeholder: "images/pgc_default_avatar.png",
                                  image: issue
                                      .itemList[position]?.data?.author?.icon,
                                ),
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 8,
                            //margin: EdgeInsets.all(5.0),
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  issue.itemList[position]?.data?.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(top: 3.0),
                                  child: new Text(
                                    tagsText +
                                        "${durationFormat(issue.itemList[position].data.duration)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          new Expanded(
                            flex: 1,
                            //margin: EdgeInsets.all(5.0),
                            child: new Text(
                              issue.itemList[position]?.data?.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> getItemData() async {
    issue = await dioManager.doGetCategoryDetailData(GlobalConfig.BASEAPI +
        GlobalConfig.CATEGORIES_LIST +
        "id=" +
        widget.id.toString());
    var toRemove = [];
    issue.itemList.forEach((item) {
      if (item.type == "videoCollectionOfHorizontalScrollCard") {
        toRemove.add(item);
      }
    });
    //删除toRemove中的元素
    issue.itemList.removeWhere((e) => toRemove.contains(e));
    setState(() {});
  }
}
