import 'package:flutter/material.dart';
import '../bean/Item.dart';
import 'package:common_utils/common_utils.dart';
import '../widget/detail_page.dart';
/*
 * @Created Date: 2019-04-20 09:57
 * @Author: Ckai
 * @Description: 这个是分类详情页的item布局
 */

Widget detailItem(
    BuildContext context, List<Item> itemCollection, int position) {
  String formattedTime = TimelineUtil.format(
      itemCollection[position]?.data?.date,
      dayFormat: DayFormat.Common);
  return new Column(
    children: <Widget>[
      new Container(
        margin: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                margin: EdgeInsets.only(right: 8.0),
                alignment: Alignment.topCenter,
                child: new ClipOval(
                  child: new Image.network(
                    itemCollection[position]?.data?.author?.icon,
                    height: 43.0,
                    width: 43.0,
                  ),
                ),
              ),
            ),
            new Expanded(
              flex: 5,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      itemCollection[position]?.data?.author?.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Text("发布：",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0,
                            )),
                        new Text(
                          itemCollection[position]?.data?.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      new Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0,bottom: 3.0),
        child: new Text(
          itemCollection[position]?.data?.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      new Container(
        alignment: Alignment.centerLeft,
        child: new Wrap(
          spacing: 8.0,
          children: itemCollection[position]?.data?.tags?.map((tag) {
            return new ActionChip(
              onPressed: () {
                print("chip点击事件");
              },
              label: new Text(
                tag.name,
                style: TextStyle(color: Colors.blueAccent,fontSize: 12.0),
              ),
              backgroundColor: Color.fromARGB(25, 135, 206, 250),
            );
          })?.toList(),
        ),
      ),
      new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new DetailPage(
                    item: itemCollection[position],
                  ),
            ),
          );
        },
        child: new AspectRatio(
          aspectRatio: 16 / 9,
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: new Image.network(
                    itemCollection[position]?.data?.cover?.feed,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0x22000000),
                ),
              ),
              new Center(
                child: new Image.asset(
                  "images/ic_player_play.png",
                  height: 90.0,
                  width: 90.0,
                ),
              ),
            ],
          ),
        ),
      ),
      new Container(
        margin:
            EdgeInsets.only(left: 15.0, bottom: 5.0, top: 10.0, right: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                      "images/ic_action_favorites_grey_without_padding.png",
                      height: 23.0,
                      width: 23.0),
                  new Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: new Text(
                      itemCollection[position]
                          ?.data
                          ?.consumption
                          ?.collectionCount
                          .toString(),
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                      "images/ic_action_reply_grey_without_padding.png",
                      height: 23.0,
                      width: 23.0),
                  new Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: new Text(
                      itemCollection[position]
                          ?.data
                          ?.consumption
                          ?.replyCount
                          .toString(),
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ],
              ),
            ),
            new Text(formattedTime),
            new Image.asset(
              "images/ic_action_share_grey.png",
              width: 48.0,
              height: 48.0,
            ),
          ],
        ),
      ),
      new Container(
        height: 0.2,
        color: Colors.black45,
        margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      ),
    ],
  );
}
