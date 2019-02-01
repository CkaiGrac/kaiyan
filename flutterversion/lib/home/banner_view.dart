import 'package:flutter/material.dart';
import '../bean/Item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../widget/jump_show.dart';

/*
 * @Created Date: 2019-02-01 13:13
 * @Author: Ckai
 * @Description: 
 */

Widget bannerView(BuildContext context, List<Item> bannerList) {
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double bottomHeight = MediaQuery.of(context).padding.bottom;

  return new Padding(
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
            onTap: (index) {
              print(bannerList[index].data.playUrl);
            },
            itemBuilder: (BuildContext context, int index) {
              return new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Image.network(bannerList[index].data.cover.feed,
                      fit: BoxFit.fill),
                  new Container(
                    color: Color(0x55000000),
                  ),
                  //new Image.asset("images/home_page_header_icon.png",width: 20,height: 20,),
                  new Positioned(
                    right: 1.0,
                    left: 1.0,
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
            
          ),
        ),
      ],
    ),
  );
}
