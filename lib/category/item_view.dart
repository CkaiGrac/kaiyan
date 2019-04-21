import 'package:flutter/material.dart';
import '../bean/Category.dart';
import '../category/category_detail_page.dart';
/*
 * @Created Date: 2019-02-07 13:23
 * @Author: Ckai
 * @Description: 分类页的小部件
 */

Widget itemView(BuildContext context, Category category) {
  return new GestureDetector(
    onTap: () {
      print(category.id);
      ///点击后跳转到相应的分类详情页
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new CategoryDetailPage(
                category: category,
              ),
        ),
      );
    },
    child: new Card(
      elevation: 0.4,
      child: new Stack(
        children: <Widget>[
          new Image.network(category?.bgPicture, fit: BoxFit.cover),
          ///覆盖一层半透明的黑色
          new Container(
            color: Color(0x55000000),
          ),
          new Center(
            child: new Text(
              '#' + category.name,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LanTing',
              ),
            ),
          )
        ],
      ),
    ),
  );
}
