import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutterversion/global_config.dart';
import 'dart:core';
import 'dart:io';
import '../bean/DataHub.dart';
import '../bean/Item.dart';
import '../home/banner_view.dart';
import '../home/item_view.dart';
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
    if (dataHub != null && !isRequsetedItem) {
      loadMore();
      isRequsetedItem = true;
      //print(moreData[0].nextPageUrl);
    }

    return new MaterialApp(
      home: new Scaffold(
        body: dataHub == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new SingleChildScrollView(
                controller: _controller,
                child: new Column(
                  children: <Widget>[
                    bannerView(context, bannerList),
                    itemView(context, itemList),
                  ],
                ),
              ),
      ),
    );
  }

  void getBanner() async {
    try {
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";
      dio.options.connectTimeout = 8000;
      Response response;
      response = await dio.get(GlobalConfig.BASEAPI +
          GlobalConfig.BANNER +
          "&date=" +
          currentTimeMillis().toString());
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data;
        dataHub = DataHub.fromJson(data);
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
    } catch (e) {
      return print(e);
    }
  }

  void loadMore() async {
    try {
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";
      dio.options.connectTimeout = 8000;
      Response response;
      if (dataHub != null) {
        response = await dio.get(dataHub.nextPageUrl);
        if (response.statusCode == HttpStatus.ok) {
          var data = response.data;
          dataHub = DataHub.fromJson(data);

          itemList.addAll(dataHub.issueList[0].itemList);
          print(dataHub.nextPageUrl);
          setState(() {});
          //print(dataHub.issueList[0].itemList[0].data.text);
        }
      }
    } catch (e) {
      return print(e);
    }
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
