import 'dart:async';

import 'package:flutter/material.dart';
import '../net/network_manager.dart';
import 'package:flutterversion/global_config.dart';
import '../bean/category_list.dart';
import '../category/item_view.dart';
/*
 * @Created Date: 2019-01-26 17:07
 * @Author: Ckai
 * @Description: 分类页
 */

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  HttpManager dioManager = HttpManager.instance;
  CategoryList categoryList;

  @override
  void initState() {
    super.initState();

    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: new Text(
            '分类',
            style: new TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'LanTing-Bold',
            ),
          ),
        ),
        body: categoryList == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new SingleChildScrollView(
                physics: new ClampingScrollPhysics(),
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      GridView.count(
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: categoryList.categorys.map(
                          (category) {
                            ///返回一个小部件
                            return itemView(context, category);
                          },
                        ).toList(),
                      ),
                      ///底部footer
                      new Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: new Text(
                          "-The End-",
                          style: new TextStyle(
                              fontSize: 18.0, fontFamily: 'Lobster'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  ///网络请求的方法
  Future<void> getCategory() async {
    categoryList = await dioManager
        .doGetCategory(GlobalConfig.BASEAPI + GlobalConfig.CATEGORIES);
    //print(categoryList.categorys[0].description);
    setState(() {});
  }
}
