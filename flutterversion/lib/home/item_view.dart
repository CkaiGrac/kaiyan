import 'package:flutter/material.dart';
import '../bean/Item.dart';
/*
 * @Created Date: 2019-02-01 13:22
 * @Author: Ckai
 * @Description: 
 */

Widget itemView(BuildContext context, List<Item> itemList) {
  return new Container(
    child: new ListView.builder(
      controller: new ScrollController(keepScrollOffset: false),
      physics: new NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int position) {
        if (itemList[position].type == "textHeader") {
          return new Center(
            child: new Container(
              margin: EdgeInsets.only(bottom: 18.0),
              child: new Text(
                itemList[position].data.text,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lobster'),
              ),
            ),
          );
        }

        String tagsText = "";
        itemList[position].data.tags.take(4).forEach((tag) {
          tagsText += tag.name + " / ";
        });

        return new GestureDetector(
          onTap: () {
            print(itemList[position].data.playUrl);
          },
          child: new Card(
            elevation: 0.3,
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new FadeInImage.assetNetwork(
                      placeholder: "images/home_page_header_cover.jpg",
                      image: itemList[position].data.cover.feed,
                      fit: BoxFit.fitWidth),
                ),
                new Container(
                  margin: EdgeInsets.only(
                      left: 10.0, bottom: 8.0, top: 10.0, right: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: new ClipOval(
                            child: new FadeInImage.assetNetwork(
                              placeholder: "images/pgc_default_avatar.png",
                              image: itemList[position].data.author.icon,
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        flex: 8,
                        //margin: EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            new Text(
                              itemList[position].data.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(top: 3.0),
                              child: new Text(
                                tagsText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFF9E9E9E),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        //margin: EdgeInsets.all(5.0),
                        child: new Text(
                          itemList[position].data.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
