import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../category/category_page.dart';
import '../hot/hot_page.dart';

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

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  var tabImages;
  var appBarTitles = ['开眼精选', '分类', '热门'];
  List<StatefulWidget> _pageList;

  Image getTabIcon(int currentIndex) {
    if (currentIndex == _currentIndex) {
      return tabImages[currentIndex][1];
    }
    return tabImages[currentIndex][0];
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _currentIndex) {
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

  @override
  void initState() {
    super.initState();
    initData();
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
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
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
          _currentIndex = index;
        });
      },
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          child: IndexedStack(
            children: <Widget>[
              new HomePage(),
              new CategoryPage(),
              new HotPage()
            ],
            index: _currentIndex,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
