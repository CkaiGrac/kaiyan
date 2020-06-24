## Flutter入门级demo
### 低仿开眼app
#### [项目地址](https://github.com/CkaiGrac/kaiyan)
#### 这个项目用于记录本人学习Flutter的一些过程，项目中使用的数据均来自网络，仅供学习参考。主要界面仿自@[XSation/Eyepetizer](https://github.com/XSation/Eyepetizer)

##### 注意：由于本人初学flutter以及编程功底不扎实所以在实现方式和代码规范等方面不尽人意

##### 整个代码的结构：
```dart
- lib
    + bean              //请求数据对应的实体类放这里
    + category          //分类页面相关的东西放这里
    + home              //首页相关的东西放这里
    + hot               //热门相关的东西放这里
    + index             //这里加载三个页面
    + net               //网络请求相关的放这里
    + widget            //其他自定义控件放这里
    global_config.dart  //一些配置参数可以放这里
    main.dart           //程序的主入口
```
##### 更新：
  - [2019-4-24: 更新android端启动页](/lib/home/README.md)
##### 快速导航：
- [首页](/lib/home/home_page.dart)
- [分类](/lib/category/category_page.dart)
- [热门](/lib/hot/hot_page.dart)
- [简单自定义下拉刷新](/lib/home/refresh_view.dart)
- [分类详情页](/lib/category/category_detail_page.dart)
- [视频播放页](/lib/widget/detail_page.dart)
- [文字逐字出现动画](/lib/widget/jump_show.dart)
- [json序列化反序列化](/lib/bean/README.md)


<div align="center">
<img src="/screenshot/homePage.png"  height="400" width="200">
<img src="/screenshot/categoryPage.png"  height="400" width="200">
<img src="/screenshot/hotPage.png"  height="400" width="200">
</div>

<div align="center">
<img src="/screenshot/detailPage.png"  height="400" width="200">
<img src="/screenshot/reply.png"  height="400" width="200">
<img src="/screenshot/player.png"  height="400" width="230">
</div>

<div align="center">
<img src="/screenshot/refresh.png"  height="400" width="200">
<img src="/screenshot/detail2.png"  height="400" width="200">
<img src="/screenshot/categoryDetail.png"  height="400" width="200">
</div>

##### 现在已知的一些问题：
- BottomNavigationBar 高度太高
- ios模拟器上无法正常播放视频
- 分类详情页上为了实现appbar滚动渐变从而导致遮住了返回按钮
- 数据接口偶尔会抽风不知道如何处理
- 分类详情页滑动很卡顿？
