import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-01-27 10:50
 * @Author: Ckai
 * @Description: 
 */

class GlobalConfig {
  static ThemeData themeData = new ThemeData.light();
  //基本API，用于拼接
  static final String BASEAPI = "http://baobab.kaiyanapp.com/api/";

  ///还要加上[&date=]参数
  ///首页banner 和 item 数据
  static final String BANNER = "v2/feed?num=1";
  //分类
  static final String CATEGORIES = "v4/categories/";

  ///还要加上[id=]参数
  ///某一分类的详细视频
  static final String CATEGORIES_LisT = "v4/categories/detail/index?";

  //热门分类，只有周排行，月排行，总排行的 api地址
  static final String HOT_CATEGORY = "http://baobab.kaiyanapp.com/api/v4/rankList";

  ///还要加上[id=]参数
  ///获取与点开视频的相关视频api
  static final String RELATEDDATA = "v4/video/related?";

  ///还需要[videoId=]参数
  ///获取回复
  static final String REPLY = "v2/replies/video?";
}
