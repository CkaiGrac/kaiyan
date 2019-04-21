import 'package:flutter/material.dart';
import '../bean/Category.dart';
import '../category/category_detail_header.dart';
import '../category/category_detail_item.dart';
import '../widget/appbar.dart';
import '../widget/floating_button.dart';

/*
 * @Created Date: 2019-04-14 15:05
 * @Author: Ckai
 * @Description: 分类详情页
 */

class CategoryDetailPage extends StatefulWidget {
  final Category category;
  CategoryDetailPage({this.category});

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailPage();
  }
}

class _CategoryDetailPage extends State<CategoryDetailPage> {
  double appBarAlpha = 0;
  void _onScroll(double offset) {
    double alpha = offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          children: <Widget>[
            new NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: new ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        categoryDetailHeader(context, widget.category),
                        CategoryDetailItem(
                          id: widget.category?.id,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            mAppBar(appBarAlpha, title: widget.category?.name),
            Positioned(
              left: 125,
              right: 125,
              bottom: 28,
              child: floatingButton(),
            ),
          ],
        ),
      ),
    );
  }
}
