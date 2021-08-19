import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlinkingWidget extends StatefulWidget {
  final Widget child;
  BlinkingWidget({this.child});
  @override
  _BlinkingWidgetState createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}