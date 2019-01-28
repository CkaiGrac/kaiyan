import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutterversion/global_config.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import '../bean/Issue.dart';
import '../bean/DataHub.dart';
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

  @override
  void initState() {
    super.initState();
    print("HomePage初始化");
    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;
    return new MaterialApp(
      home: new Scaffold(
        body: dataHub == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: new ConstrainedBox(
                  constraints: new BoxConstraints.loose(
                    new Size(MediaQuery.of(context).size.width,
                        1 / 3 * MediaQuery.of(context).size.height),
                  ),
                  child: new Swiper(
                    itemCount: 5,
                    autoplay: true,
                    pagination: new SwiperPagination(),
                    itemBuilder: (BuildContext context, int index) {
                      return new Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          new Image.network(
                              dataHub
                                  .issueList[0].itemList[index].data.cover.feed,
                              fit: BoxFit.fill),
                          new Container(
                            color: Color(0x55000000),
                          ),
                        ],
                      );
                    },
                    onTap: (index) {
                      print(dataHub.issueList[0].itemList[index].data.playUrl);
                    },
                  ),
                ),
              ),
      ),
    );
  }

  void getBanner() async {
    try {
      Dio dio = new Dio();
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
        var toRemove = [];

        ///过滤元素，要删除[type=“banner2” ]的元素
        dataHub.issueList[0].itemList.forEach((item) {
          if (item.type == "banner2") {
            toRemove.add(item);
          }
        });
        //删除toRemove中的元素
        dataHub.issueList[0].itemList.removeWhere((e) => toRemove.contains(e));
        setState(() {});
      }
    } catch (e) {
      return print(e);
    }
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
