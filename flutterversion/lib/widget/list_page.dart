import 'package:flutter/material.dart';

typedef BannerWidgetBuild = Widget Function(BuildContext context, int position);

typedef ItemWidgetBuild = Widget Function(BuildContext context, int position);

const TYPE_BANNER = 1;
const TYPE_STANDARD = 2;

class ListPage extends StatefulWidget {
  List bannerList;
  List itemList;
  BannerWidgetBuild bannerCreator;
  ItemWidgetBuild itemCreator;

  ListPage({
    Key key,
    this.bannerList,
    this.itemList,
    this.bannerCreator,
    this.itemCreator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    if (_getListCount() == 0) {
      return new Center(
        child: new Text("暂无数据"),
      );
    }

    return new ListView.builder(
      itemBuilder: (BuildContext context, int postion) {
        return buildWidget(context, postion);
      },
      itemCount: _getListCount(),
    );
  }

  Widget buildWidget(BuildContext context, int index) {
    int viewType = getItemViewType(index);
    if (viewType == TYPE_BANNER) {
      return _bannerWidget(context, index);
    }
    return _itemWidget(context, index-1);
  }

  int _getListCount() {
    if (widget.bannerList != null) {
      if (widget.itemList != null) {
        int itemCount = widget.itemList.length;
        return 1 + itemCount;
      } else {
        return 1;
      }
    }
    return 0;
  }

  int getItemViewType(int position) {
    if (position == 0) {
      return TYPE_BANNER;
    }
    return TYPE_STANDARD;
  }

  int getBannerCount() {
    int bannerCount = widget.bannerList != null ? widget.bannerList.length : 0;
    return bannerCount;
  }

  Widget _bannerWidget(BuildContext context, int index) {
    if (widget.bannerCreator != null) {
      return widget.bannerCreator(context, index);
    } else {
      return new GestureDetector(
        child: new Text("Header Row $index"),
        onTap: () {
          print('header click $index --------------------');
        },
      );
    }
  }

  Widget _itemWidget(BuildContext context, int index) {
    if (widget.itemCreator != null) {
      return widget.itemCreator(context, index);
    } else {
      return new GestureDetector(
        child: new Text("Row $index"),
        onTap: () {
          print('click $index --------------------');
        },
      );
    }
  }
}
