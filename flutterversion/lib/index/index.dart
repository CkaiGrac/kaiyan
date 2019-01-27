import 'package:flutter/material.dart';
import '../index/navigation_icon_view.dart';
import '../home/home_page.dart';
import '../category/category_page.dart';
import '../hot/hot_page.dart';
import '../global_config.dart';

/*
 * @Created Date: 2019-01-26 15:56
 * @Author: Ckai
 * @Description: 
 */
class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['开眼精选', '分类', '热门'];
  List<StatefulWidget> _pageList;

  Image getTabIcon(int currentIndex) {
    if (currentIndex == _tabIndex) {
      return tabImages[currentIndex][1];
    }
    return tabImages[currentIndex][0];
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 12.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 12.0, color: const Color(0xff515151)));
    }
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 48.0, height: 48.0);
  }

  void initData() {
    tabImages = [
      [
        getTabImage('images/ic_tab_strip_icon_feed.png'),
        getTabImage('images/ic_tab_strip_icon_feed_selected.png')
      ],
      [
        getTabImage('images/ic_tab_strip_icon_category.png'),
        getTabImage('images/ic_tab_strip_icon_category_selected.png')
      ],
      [
        getTabImage('images/ic_tab_strip_icon_follow.png'),
        getTabImage('images/ic_tab_strip_icon_follow_selected.png')
      ],
    ];

    _pageList = [new HomePage(), new CategoryPage(), new HotPage()];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _tabIndex,
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: getTabIcon(0),
          title: getTabTitle(0),
        ),
        new BottomNavigationBarItem(
          icon: getTabIcon(1),
          title: getTabTitle(1),
        ),
        new BottomNavigationBarItem(
          icon: getTabIcon(2),
          title: getTabTitle(2),
        ),
      ],
      onTap: (int index) {
        setState(() {
          _tabIndex = index;
        });
      },
    );

    return new MaterialApp(
      home: new Scaffold(
        body: _pageList[_tabIndex],
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
