import 'dart:async';

import 'package:flutter/material.dart';
import '../bean/DataHub.dart';
import '../bean/Item.dart';
import '../home/item_view.dart';
import '../net/network_manager.dart';
import '../global_config.dart';
import '../widget/jump_show.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../widget/detail_page.dart';
import '../widget/appbar.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
/*
 * @Created Date: 2019-03-22 15:19
 * @Author: Ckai
 * @Description: 低程度自定义刷新。。
 */

///就是监听手势滑动，滑动的同时根据滑动的距离改变[swiper]的高度，
///松手后判断滑动距离:满足刷新距离就执行[_onRefresh]，不满足就执行动画缩回。
///代码整体太耦合不好拆开来。。
class RefreshView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RefreshViewState();
  }
}

class _RefreshViewState extends State<RefreshView>
    with TickerProviderStateMixin {
  double appBarAlpha = 0;

  var canRefresh = true;
  var isFirstArrive = false;
  var mDownY = 0.0;
  var mDownX = 0.0;
  var deltaY = 0.0;
  var deltaX = 0.0;
  var moveDistance = 0.0;
  final double pullDistance = 150.0;
  var pullPercentage = 0.0;
  AnimationController animationScrollController;
  AnimationController animationRotationController;
  AnimationController animationScaleController;

  ScrollController _controller = new ScrollController();

  DataHub dataHub;
  List<Item> itemList = <Item>[];
  List<Item> bannerList = <Item>[];
  bool isRequsetedItem = false;
  HttpManager dioManager = HttpManager.instance;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300));
    FlutterSplashScreen.hide();

    print("HomePage初始化");
    getBanner();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("-------》到达底部");
        loadMore();
      }
    });

    animationScrollController = new AnimationController(
      duration: Duration(milliseconds: 100),
      upperBound: pullDistance,
      lowerBound: 0.0,
      vsync: this,
    );
    animationScrollController.addListener(() {
      setState(() {});
    });

    animationScaleController = new AnimationController(
      duration: Duration(milliseconds: 100),
      upperBound: 1.0,
      lowerBound: 0.0,
      vsync: this,
    );
    animationScaleController.addListener(() {
      setState(() {});
    });
    animationScaleController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        print("动画销毁");
      }
    });

    animationRotationController = new AnimationController(
      duration: Duration(milliseconds: 500),
      upperBound: 1.0,
      lowerBound: 0.0,
      vsync: this,
    );
    animationRotationController.addListener(() {
      setState(() {});
    });
  }

  void _onScroll(double offset) {
    double alpha = offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    if (offset == 0) {
      canRefresh = true;
      isFirstArrive = true;
    } else {
      canRefresh = false;
      isFirstArrive = false;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dataHub != null && !isRequsetedItem) {
      loadMore();
      isRequsetedItem = true;
    }

    return dataHub == null
        ? new Center(
            child: CircularProgressIndicator(),
          )
        : new Listener(
            onPointerDown: (e) {
              mDownX = e.position.dx;
              mDownY = e.position.dy;
            },
            onPointerMove: (e) {
              deltaX = e.position.dx - mDownX;
              deltaY = e.position.dy - mDownY;
              if (!isFirstArrive) {
                if (canRefresh) {
                  //print("走了canRefresh判断");
                  if (deltaY > deltaX && deltaY > 38.0) {
                    moveDistance = deltaY;
                    //print("moveDistance  " + moveDistance.toString());

                    //print("deltaY > deltaX && deltaY > 38.0");
                    animationScrollController.value = moveDistance;

                    pullPercentage = moveDistance / pullDistance;
                    animationScaleController.value = pullPercentage;
                    if (moveDistance > pullDistance) {
                      moveDistance = pullDistance;
                      animationScrollController.value = moveDistance;

                      animationScaleController.value = 1.0;
                    }
                  }
                }
              }
            },
            onPointerUp: (e) {
              //print("结束 ${e}");
              //print("刚刚滑动的距离为" + moveDistance.toString());
              if (moveDistance < pullDistance) {
                animationRotationController.reset();
                animationScrollController.reverse();
                animationScaleController.reverse();
                moveDistance = 0.0;
              }
              if (canRefresh &&
                  moveDistance == pullDistance &&
                  !isFirstArrive) {
                moveDistance = 0.0;
                animationRotationController.repeat();
                _onRefresh();
              }
              setState(() {
                isFirstArrive = false;
              });
            },
            child: new Stack(
              children: <Widget>[
                new NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: new SingleChildScrollView(
                    controller: _controller,
                    physics: new ClampingScrollPhysics(),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          //margin: EdgeInsets.only(top: statusBarHeight),
                          width: MediaQuery.of(context).size.width,
                          height:
                              3.6 / 10 * MediaQuery.of(context).size.height +
                                  animationScrollController.value,
                          child: new Swiper(
                            itemCount: bannerList.length,
                            autoplayDelay: 8000,
                            //autoplay: true,
                            pagination: new SwiperPagination(
                              builder: new DotSwiperPaginationBuilder(
                                size: 8.0,
                                color: Colors.grey,
                                activeColor: Colors.white,
                                activeSize: 8.0,
                              ),
                            ),
                            onTap: (index) {
                              print(bannerList[index].data.id);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new DetailPage(
                                        item: bannerList[index],
                                      ),
                                ),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.network(
                                      bannerList[index].data.cover.feed,
                                      fit: BoxFit.cover),
                                  new Container(
                                    color: Color(0x55000000),
                                    height: 3.6 /
                                            10 *
                                            MediaQuery.of(context).size.height +
                                        animationScrollController.value,
                                  ),
                                  new Positioned(
                                    right: 1.0,
                                    left: 1.0,
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
                                        text: bannerList[index].data.title,
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontFamily: 'LanTing-Bold'),
                                      ),
                                    ),
                                  ),
                                  new Positioned(
                                    bottom: 27.5,
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
                                  new Offstage(
                                    offstage:
                                        animationScrollController.value == 0
                                            ? true
                                            : false,
                                    child: Container(
                                      height: 250.0 +
                                          animationScrollController.value,
                                      color: Color(0x55000000),
                                    ),
                                  ),
                                  new Positioned(
                                    top: 1.0,
                                    bottom: 1.0,
                                    left: 1.0,
                                    right: 1.0,
                                    child: new Center(
                                      child: new RotationTransition(
                                        turns: CurvedAnimation(
                                            parent: animationRotationController,
                                            curve: Curves.linear),
                                        child: new Image.asset(
                                          "images/eye_loading_progress.png",
                                          height:
                                              animationScaleController.value *
                                                  52.0,
                                          width:
                                              animationScaleController.value *
                                                  52.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        itemView(context, itemList),
                      ],
                    ),
                  ),
                ),
                mAppBar(appBarAlpha, title: "开眼睛选"),
              ],
            ),
          );
  }

  @override
  void dispose() {
    animationRotationController.dispose();
    animationScaleController.dispose();
    animationScrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    dataHub = null;
    bannerList.clear();
    itemList.clear();
    getBanner();
    isRequsetedItem = false;
    animationRotationController.reset();
    animationScrollController.reverse();
    animationScaleController.reverse();
    //print("isFirstArrive  " + isFirstArrive.toString());
  }

  Future<void> getBanner() async {
    dataHub = await dioManager.doGetData(GlobalConfig.BASEAPI +
        GlobalConfig.BANNER +
        "&date=" +
        currentTimeMillis().toString());

    bannerList.addAll(dataHub?.issueList[0]?.itemList);

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

  Future<void> loadMore() async {
    dataHub = await dioManager.doGetData(dataHub.nextPageUrl);
    itemList.addAll(dataHub?.issueList[0]?.itemList);

    print(dataHub.nextPageUrl);
    setState(() {});
    //print(dataHub.issueList[0].itemList[0].data.text);
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
