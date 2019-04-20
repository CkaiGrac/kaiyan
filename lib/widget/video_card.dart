import 'dart:async';

import 'package:flutter/material.dart';
import '../bean/Issue.dart';
import '../net/network_manager.dart';
import '../global_config.dart';
import '../bean/Item.dart';
import '../widget/detail_page.dart';
/*
 * @Created Date: 2019-04-09 15:09
 * @Author: Ckai
 * @Description: 
 */

class VideoCardView extends StatefulWidget {
  final Item item;
  VideoCardView({this.item});
  @override
  State<StatefulWidget> createState() {
    return _VideoCardViewState();
  }
}

class _VideoCardViewState extends State<VideoCardView> {
  Issue issue;
  HttpManager dioManager = HttpManager.instance;
  final GlobalKey<ScaffoldState> _bottomSheetScaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _getRelatedData(widget.item.data.id);
  }

  void openBottomSheet() {
    _bottomSheetScaffoldKey.currentState.showBottomSheet((context) {
      return BottomAppBar(
        child: Container(
          height: 200.0,
          color: Colors.white,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return issue == null
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : new MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: issue.itemList.length,
              itemBuilder: (BuildContext context, int position) {
                if (issue.itemList[position].type == "textCard") {
                  return new Container(
                    margin: EdgeInsets.only(
                      left: 15.0,
                      top: 10.0,
                    ),
                    child: new Text(
                      issue.itemList[position].data.text + " ",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  );
                }
                return new GestureDetector(
                  onTap: () {
                    //print(issue.itemList[position].data?.playUrl);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new DetailPage(
                              item: issue.itemList[position],
                            ),
                      ),
                    );
                  },
                  child: new Container(
                    margin: EdgeInsets.all(15.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Image.network(
                            issue.itemList[position].data?.cover?.detail,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new Expanded(
                            flex: 1,
                            child: new Container(
                              margin: EdgeInsets.only(left: 15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    issue.itemList[position].data?.title,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  new Container(
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: new Text(
                                      "#" +
                                          issue.itemList[position].data
                                              ?.category +
                                          " / " +
                                          "${durationFormat(issue.itemList[position].data.duration)}",
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Future<void> _getRelatedData(num id) async {
    issue = await dioManager.doGetRelated(
        GlobalConfig.BASEAPI + GlobalConfig.RELATEDDATA + "id=${id}");
    setState(() {});
  }
}
