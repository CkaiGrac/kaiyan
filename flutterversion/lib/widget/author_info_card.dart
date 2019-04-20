import 'package:flutter/material.dart';
import '../bean/Item.dart';
/*
 * @Created Date: 2019-04-08 13:48
 * @Author: Ckai
 * @Description: 
 */

class AuthorInfoCard extends StatefulWidget {
  final Item item;
  AuthorInfoCard({this.item});
  @override
  State<StatefulWidget> createState() {
    return _AuthorInfoCardState();
  }
}

class _AuthorInfoCardState extends State<AuthorInfoCard> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 1.0,
            color: Color.fromARGB(88, 255, 255, 255),
          ),
          new Container(
            height: 76,
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: new ClipOval(
                    child: new Image.network(
                      widget.item.data?.author?.icon,
                      height: 40.0,
                      width: 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new Expanded(
                  flex: 7,
                  child: new Container(
                    width: 270.0,
                    margin:
                        EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          widget.item.data?.author?.name,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        new Text(
                          widget.item.data?.author?.description,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    height: 30.0,
                    width: 60.0,
                    margin: EdgeInsets.only(
                        top: 15.0, right: 10.0, left: 10.0, bottom: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: new Border.all(color: Colors.white)),
                    child: new Center(
                      child: new Text(
                        "+关注",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            height: 1.0,
            color: Color.fromARGB(88, 255, 255, 255),
          ),
        ],
      ),
    );
  }
}
