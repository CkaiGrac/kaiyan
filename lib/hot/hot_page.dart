import 'package:flutter/material.dart';
import '../bean/DataHub.dart';
import '../net/network_manager.dart';
import '../hot/ranking_view.dart';
import '../global_config.dart';
import '../bean/Item.dart';
/*
 * @Created Date: 2019-01-26 17:08
 * @Author: Ckai
 * @Description: 热门页
 */

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HotPageState();
  }
}

class _HotPageState extends State<HotPage> {
  DataHub dataHub;
  HttpManager dioManager = HttpManager.instance;
  List<Item> weeklyItemList = <Item>[];
  List<Item> monthlyItemList = <Item>[];
  List<Item> totalItemList = <Item>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: new Text(
              '热门',
              style: new TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'LanTing-Bold',
              ),
            ),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(text: '周排行'),
                new Tab(text: '月排行'),
                new Tab(text: '总排行'),
              ],
              isScrollable: true,
              indicatorColor: Colors.black,
              labelColor: Color(0xff000000),
              unselectedLabelColor: Color(0xffB4B4B4),
              indicatorWeight: 1,
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              new RankingView(
                GlobalConfig.WEEKLY_RANKING,
              ),
              new RankingView(
                GlobalConfig.MONTHLY_RANKING,
              ),
              new RankingView(
                GlobalConfig.TOTAL_RANKING,
              ),
            ],
          )),
    );
  }
}
