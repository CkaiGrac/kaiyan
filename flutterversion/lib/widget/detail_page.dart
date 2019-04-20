import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../bean/Item.dart';
import '../widget/author_info_card.dart';
import '../widget/movie_info_card.dart';
import '../widget/video_card.dart';

/*
 * @Created Date: 2019-04-07 15:34
 * @Author: Ckai
 * @Description: 
 */

class DetailPage extends StatefulWidget {
  @required
  final Item item;

  DetailPage({
    this.item,
  });

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController _playerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    print(widget.item.data.playUrl);
    _playerController = VideoPlayerController.network(widget.item.data.playUrl);
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
      home: Scaffold(
        body: new Stack(
          children: <Widget>[
            new Image.network(
              widget.item.data?.cover?.blurred,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
            ),
            new Container(
              color: Color(0x33000000),
            ),
            new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  child: Center(
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
                new Expanded(
                  child: new SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: new Column(
                      children: <Widget>[
                        new MovieInfoCard(
                          item: widget.item,
                        ),
                        new AuthorInfoCard(
                          item: widget.item,
                        ),
                        new VideoCardView(
                          item: widget.item,
                        )
                      ],
                    ),
                  ),
                ),

                ///TODO EndView
              ],
            ),
          ],
        ),
      ),
    );
  }
}
