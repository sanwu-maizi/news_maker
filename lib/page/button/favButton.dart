import 'package:flutter/material.dart';
import 'package:news_maker/page/function_page/favourite_page.dart';

import '../content_page/content_page.dart';

// 返回页面顶部的悬浮按钮
class FavButton extends StatefulWidget {
  final ScrollController controller;
  final bool be_liked;
  final Function function;

  const FavButton({Key? key, required this.controller,required this.be_liked,required this.function})
      : super(key: key);

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool _showButton = true;
  late bool _be_liked;
  late Function _function;

  @override
  void initState() {
    super.initState();
    _be_liked=widget.be_liked;
    _function=widget.function;
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      //_showButton = widget.controller.position.pixels >= 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showButton ? 0.8 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Stack(
        children: [
          Positioned(
            bottom: 70,
            right: 16,
            child: FloatingActionButton(
              elevation: 6,
              highlightElevation: 12,
              mini: true,
              tooltip: '收藏',
              onPressed: () {
                _function;
                // if (this._be_liked) {
                //   final int existingIndex =
                //   ContentPage.favourite.indexOf(snapshot);
                //   ContentPage.favourite.removeAt(existingIndex);
                //   ContentPage.favourite.add(_list![index]);
                // } else {
                //   setState(() {
                //     ListPage.history.add(_list![index]);
                //   });
                // }
              },
              child: Icon(Icons.star),

            ),
          )
        ],
      ),
    );
  }
}
