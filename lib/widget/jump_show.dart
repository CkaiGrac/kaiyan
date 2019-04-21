import 'dart:async';
import 'package:flutter/material.dart';

/*
 * @Created Date: 2019-01-30 11:58
 * @Author: Ckai
 * @Description: 逐字显示的部件
 */

class JumpShowTextView extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int milliseconds;
  final int delay;

  const JumpShowTextView(
      {this.text,
      this.style: const TextStyle(color: Colors.black),
      this.milliseconds: 1000,
      this.delay: 0});

  @override
  State<StatefulWidget> createState() {
    return _JumpShowTextView();
  }
}

class _JumpShowTextView extends State<JumpShowTextView>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<int> animation;
  String showText = "";
  String hideText = "";

  @override
  initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.milliseconds));

    animation = IntTween(begin: 0, end: widget.text.length).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    animation.addListener(() {
      print('${animation.value}');
      setState(() {
        showText = widget.text.substring(0, animation.value);
        hideText = widget.text.substring(animation.value, widget.text.length);
      });
    });

    Future.delayed(Duration(milliseconds: widget.delay), () {
      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      text: new TextSpan(children: <TextSpan>[
        new TextSpan(text: showText, style: widget.style),
        new TextSpan(
          text: hideText,
          style: widget.style.copyWith(color: Colors.transparent),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
