
import 'package:flutter/material.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController controller;

  const ScrollToTopButton({Key? key, required this.controller})
      : super(key: key);

  @override
  _ScrollToTopButtonState createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _showButton = false;
  double _buttonBottom = 20.0;
  double _buttonRight = 20.0;

  @override
  void initState() {
    super.initState();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      bottom: _buttonBottom, // 设置垂直方向的位置
      right: _buttonRight,
      child: Draggable(
        feedback: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.arrow_upward), // 设置合适的 feedback
        ),
        onDragEnd: (details) {
          setState(() {
            _buttonBottom = MediaQuery.of(context).size.height -
                details.offset.dy - // 计算新的垂直方向位置
                kToolbarHeight -
                12.0;
            _buttonRight = details.offset.dx;
          });
        },
        child: FloatingActionButton(
          onPressed: () {
            widget.controller.animateTo(0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          child: Icon(Icons.arrow_upward),
        ),
        childWhenDragging: FloatingActionButton( // 设置合适的 childWhenDragging
          onPressed: null,
          child: Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
