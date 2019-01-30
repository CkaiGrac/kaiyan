import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutterversion/global_config.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import '../bean/Issue.dart';
import '../bean/DataHub.dart';
import '../widget/jump_show.dart';
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
  List<DataHub> moreData = <DataHub>[];
  Dio dio = new Dio();

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

    if (dataHub != null) {
      loadMore();
      //print(moreData[0].nextPageUrl);
    }

    return new MaterialApp(
      home: new Scaffold(
        body: dataHub == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: new Column(
                  children: <Widget>[
                    new ConstrainedBox(
                      constraints: new BoxConstraints.loose(
                        new Size(MediaQuery.of(context).size.width,
                            3.5 / 10 * MediaQuery.of(context).size.height),
                      ),
                      child: new Swiper(
                        itemCount: 5,
                        autoplayDelay: 8000,
                        //autoplay: true,
                        pagination: new SwiperPagination(),
                        itemBuilder: (BuildContext context, int index) {
                          return new Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              new Image.network(
                                  dataHub.issueList[0].itemList[index].data
                                      .cover.feed,
                                  fit: BoxFit.fill),
                              new Container(
                                color: Color(0x55000000),
                              ),
                              //new Image.asset("images/home_page_header_icon.png",width: 20,height: 20,),
                              new Positioned(
                                right: 10.0,
                                left: 10.0,
                                bottom: 69.0,
                                child: new Image(
                                  image: new AssetImage(
                                      "images/home_page_header_icon.png"),
                                  height: 35.0,
                                ),
                              ),
                              new Positioned(
                                bottom: 47.0,
                                left: 1.0,
                                right: 1.0,
                                child: new Center(
                                  child: new JumpShowTextView(
                                    milliseconds: 800,
                                    text: dataHub.issueList[0].itemList[index]
                                        .data.title,
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontFamily: 'LanTing-Bold'),
                                  ),
                                ),
                              ),
                              new Positioned(
                                bottom: 30.0,
                                left: 1.0,
                                right: 1.0,
                                child: new Center(
                                  child: new JumpShowTextView(
                                    milliseconds: 800,
                                    text: dataHub.issueList[0].itemList[index]
                                        .data.slogan,
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                        fontFamily: 'LanTing'),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        onTap: (index) {
                          print(dataHub
                              .issueList[0].itemList[index].data.playUrl);
                        },
                        onIndexChanged: (index) {
                          print(index);
                        },
                      ),
                    ),
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
          moreData.add(DataHub.fromJson(data));
          print(moreData[0].nextPageUrl);
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
