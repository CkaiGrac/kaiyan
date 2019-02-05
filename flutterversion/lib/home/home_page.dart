import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutterversion/global_config.dart';
import 'dart:core';
import '../bean/DataHub.dart';
import '../bean/Item.dart';
import '../home/banner_view.dart';
import '../home/item_view.dart';
import '../net/network_manager.dart';
import '../home/title_bar.dart';
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
  DataHub dataHub;
  List<Item> itemList = <Item>[];
  List<Item> bannerList = <Item>[];
  Dio dio = new Dio();
  bool isRequsetedItem = false;
  HttpManager dioManager = HttpManager.instance;
  bool isVisible = false;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    print("HomePage初始化");
    getBanner();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("-------》到达底部");
        loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;
    if (dataHub != null && !isRequsetedItem) {
      loadMore();
      isRequsetedItem = true;
    }

    return new MaterialApp(
      home: new Scaffold(
        body: dataHub == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new RefreshIndicator(
                onRefresh: _onRefresh,
                child: new Stack(
                  children: <Widget>[
                    new SingleChildScrollView(
                      controller: _controller,
                      physics: new ClampingScrollPhysics(),
                      child: new Column(
                        children: <Widget>[
                          bannerView(context, bannerList),
                          itemView(context, itemList),
                        ],
                      ),
                    ),
                    //new TitlebarWidget(isVisible, "asdaswqeqweqweas"),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    bannerList.clear();
    itemList.clear();
    getBanner();
    isRequsetedItem = false;
  }

  Future<void> getBanner() async {
    dataHub = await dioManager.doGetData(GlobalConfig.BASEAPI +
        GlobalConfig.BANNER +
        "&date=" +
        currentTimeMillis().toString());

    bannerList.addAll(dataHub.issueList[0].itemList);

    var toRemove = [];
    bannerList.forEach((item) {
      if (item.type == "banner2") {
        toRemove.add(item);
      }
    });
    //删除toRemove中的元素
    bannerList.removeWhere((e) => toRemove.contains(e));
    setState(() {});
  }

  Future<void> loadMore() async {
    dataHub = await dioManager.doGetData(dataHub.nextPageUrl);
    itemList.addAll(dataHub.issueList[0].itemList);

    print(dataHub.nextPageUrl);
    setState(() {});
    //print(dataHub.issueList[0].itemList[0].data.text);
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
