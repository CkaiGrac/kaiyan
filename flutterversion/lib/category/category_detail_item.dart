import 'dart:async';

import 'package:flutter/material.dart';
import '../bean/Issue.dart';
import '../global_config.dart';
import '../net/network_manager.dart';
import '../bean/Item.dart';
import '../category/category_detail_textheader.dart';
import '../category/category_widget_item.dart';

/*
 * @Created Date: 2019-04-19 15:54
 * @Author: Ckai
 * @Description: 
 */
class CategoryDetailItem extends StatefulWidget {
  final int id;
  CategoryDetailItem({this.id});
  @override
  State<StatefulWidget> createState() {
    return _CategortDetailItemState();
  }
}

class _CategortDetailItemState extends State<CategoryDetailItem> {
  Issue issue;
  List<Item> itemCollection;
  HttpManager dioManager = HttpManager.instance;

  @override
  void initState() {
    super.initState();
    getCategoryDetailItem(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (issue != null) {
      itemCollection = issue.itemList[0].data?.itemList;
    }

    return issue?.itemList?.length == null
        ? new CircularProgressIndicator()
        : new ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: issue.itemList?.length,
            itemBuilder: (context, position) {
              if (issue.itemList[position]?.type ==
                  "videoCollectionOfHorizontalScrollCard") {
                if (issue.itemList[position]?.data?.dataType ==
                    "ItemCollection") {
                  return textHeader(
                      issue.itemList[position]?.data?.header?.title);
                }
              }

              if (position <= itemCollection.length) {
                return detailItem(context, itemCollection, position - 1);
              }

              if (issue.itemList[position - 5]?.type == "textHeader") {
                return textHeader(issue.itemList[position - 5]?.data?.text);
              }

              if (issue.itemList[position]?.type == "video") {
                if (issue.itemList[position]?.data?.dataType ==
                    "VideoBeanForClient") {
                  return detailItem(context, issue.itemList, position);
                }
              }
            },
          );
  }

  Future<void> getCategoryDetailItem(String id) async {
    issue = await dioManager.doGetCategoryDetailData(
        GlobalConfig.BASEAPI + GlobalConfig.CATEGORIES_LIST + "id=" + id);
    setState(() {});
  }
}
