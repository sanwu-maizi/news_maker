import 'package:flutter/material.dart';

// 返回页面顶部的悬浮按钮
class ScrollToTopButton extends StatefulWidget {
  final ScrollController controller;
  final bool checkToShow;

  const ScrollToTopButton({Key? key, required this.controller,required this.checkToShow})
      : super(key: key);

  @override
  _ScrollToTopButtonState createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  late bool _showButton;

  @override
  void initState() {
    super.initState();
    _showButton = widget.checkToShow;
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showButton = widget.controller.position.pixels >= 100;
      //_addnewpage = widget.controller.position.pixels >=
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
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              elevation: 6,
              highlightElevation: 12,
              mini: true,
              tooltip: '回到顶层',
              onPressed: () {
                widget.controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Icon(Icons.arrow_upward),
            ),
          )
        ],
      ),
    );
  }
}
