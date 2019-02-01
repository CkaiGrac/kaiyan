import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutterversion/global_config.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import '../bean/DataHub.dart';
import '../widget/jump_show.dart';
import '../widget/list_page.dart';
import '../bean/Item.dart';
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

    if (dataHub != null && !isRequsetedItem) {
      loadMore();
      isRequsetedItem = true;
      //print(moreData[0].nextPageUrl);
    }

    return new MaterialApp(
      home: new Scaffold(
        body: bannerList == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new ListPage(
                bannerList: bannerList,
                //itemList: itemList,
                //itemCreator: itemView,
                bannerCreator: (BuildContext context, int position) {
                  if (position == 0) {
                    return bannerView(context, position);
                  }
                },
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
      return print(" getBanner() --------> " + e);
    }
  }

  void loadMore() async {
    try {
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";
      dio.options.connectTimeout = 8000;
      Response response;
      if (bannerList != null) {
        response = await dio.get(dataHub.nextPageUrl);
        if (response.statusCode == HttpStatus.ok) {
          var data = response.data;
          dataHub = DataHub.fromJson(data);
          itemList.addAll(dataHub.issueList[0].itemList);
          print(dataHub.nextPageUrl);
          print(itemList);
          setState(() {});
          //print(dataHub.issueList[0].itemList[0].data.text);
        }
      }
    } catch (e) {
      return print(" loadMore() --------> " + e);
    }
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  Widget bannerView(BuildContext context, int position) {
    return new Container(
      height: 3.5 / 10 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Swiper(
        itemCount: 5,
        //autoplayDelay: 8000,
        //autoplay: true,
        pagination: new SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new FadeInImage.assetNetwork(
                placeholder: "images/home_page_header_cover.jpg",
                image: bannerList[index].data.cover.feed,
                fit: BoxFit.fill,
              ),

              new Container(
                color: Color(0x55000000),
              ),
              //new Image.asset("images/home_page_header_icon.png",width: 20,height: 20,),
              new Positioned(
                right: 10.0,
                left: 10.0,
                bottom: 69.0,
                child: new Image(
                  image: new AssetImage("images/home_page_header_icon.png"),
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
                    text: bannerList[index].data.title,
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
                    text: bannerList[index].data.slogan,
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
          //TODO 界面跳转
          print(bannerList[index].data.playUrl);
        },
      ),
    );
  }

  Widget itemView(BuildContext context, int position) {
    var textHeader = [];
    itemList.forEach((item) {
      if (item.type == "textHeader") {
        textHeader.add(item);
      }
    });
    //删除toRemove中的元素
    itemList.removeWhere((e) => textHeader.contains(e));
    print(itemList);

    String tagsText = "";
    itemList[position].data.tags.take(4).forEach((tag) {
      tagsText += tag.name + " / ";
    });

    return new Container(
      color: Color(0xFFEEEEEE),
      width: MediaQuery.of(context).size.width,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new FadeInImage.assetNetwork(
                placeholder: "images/home_page_header_cover.jpg",
                image: itemList[position].data.cover.feed,
                fit: BoxFit.fitWidth),
          ),
          new Container(
            margin: EdgeInsets.only(
                left: 15.0, bottom: 10.0, top: 10.0, right: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new ClipOval(
                    child: new FadeInImage.assetNetwork(
                      placeholder: "images/pgc_default_avatar.png",
                      fit: BoxFit.fitWidth,
                      image: itemList[position].data.author.icon,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                new Expanded(
                  flex: 8,
                  //margin: EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        itemList[position].data.title,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      new Text(
                        tagsText,
                        style: new TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  //margin: EdgeInsets.all(5.0),
                  child: new Text(
                    itemList[position].data.category,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(bottom: 8.0),
                height: 1.0,
                width: MediaQuery.of(context).size.width / 6 * 5,
                color: Colors.grey,
                alignment: Alignment.centerRight,
              )
            ],
          )
        ],
      ),
    );
  }
}
