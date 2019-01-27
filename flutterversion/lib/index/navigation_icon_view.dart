import 'package:flutter/material.dart';
/*
 * @Created Date: 2019-01-26 16:01
 * @Author: Ckai
 * @Description: 
 */

class NavigationIconView {
  
  final BottomNavigationBarItem item;
  final AnimationController controller;

  NavigationIconView({Widget icon, Widget title, TickerProvider vsync})
      : item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
        ),
        controller = new AnimationController(
            duration: kThemeAnimationDuration, vsync: vsync);
}
