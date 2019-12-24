import 'dart:async';

import 'package:flutter/material.dart';

//bool isErrorPresent = false;
Future<void> showErrorDialog({
  @required BuildContext context,
  @required Widget child,
  EdgeInsets paddingWidget = const EdgeInsets.all(12.0),
  double offsetFromTop = 0.2,
  double maxWidth,
  double maxHeight,
  int timeStay = 1000,
  int timeAnimate = 800,
  double cardCornerRadius = 8.0,
  Color bgColor,
}) async {
  if (AlertAnimation.isErrorPresent == false) {
    AlertAnimation.isErrorPresent = true;
    final OverlayState overlayState = Overlay.of(context);
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => AlertAnimation(
        ctx: context,
        child: child,
        offsetFromTop: offsetFromTop,
        maxHeight: maxHeight ?? 0.75 * MediaQuery.of(context).size.height,
        maxWidth: maxWidth ?? 0.75 * MediaQuery.of(context).size.width,
        padding: paddingWidget,
        timeStay: timeStay,
        timeAnimate: timeAnimate,
        cardCornerRadius: cardCornerRadius,
        bgColor: bgColor ?? Colors.white,
      ),
    );
    overlayState.insert(overlayEntry);
    await Future<dynamic>.delayed(
        Duration(milliseconds: timeStay + timeAnimate + 500));
    overlayEntry.remove();
  }
}

class AlertAnimation extends StatefulWidget {
  const AlertAnimation({
    this.child,
    this.offsetFromTop,
    this.bgColor,
    this.ctx,
    this.maxHeight,
    this.maxWidth,
    this.timeAnimate,
    this.timeStay,
    this.padding,
    this.cardCornerRadius,
  });

  final double maxHeight, maxWidth;
  final int timeStay, timeAnimate;
  final Widget child;
  final double offsetFromTop;
  final Color bgColor;
  final double cardCornerRadius;
  final BuildContext ctx;
  final EdgeInsets padding;

  static bool isErrorPresent = false;

  @override
  AlertAnimationState createState() => AlertAnimationState();
}

class AlertAnimationState extends State<AlertAnimation>
    with TickerProviderStateMixin {
  AlertAnimationState() {
    if (_controller != null) {
      _controller.forward();
    }
  }

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.timeAnimate));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addStatusListener(handler);
    _controller.forward();
  }

  @override
  Widget build(context) {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reset();
      _controller.forward();
    }
    final double height = MediaQuery.of(widget.ctx).size.height;
    final double width = MediaQuery.of(widget.ctx).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) => Transform(
        transform: Matrix4.translationValues(0, _animation.value * height, 0.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: height / 2 * widget.offsetFromTop,
              left: (width - (widget.maxWidth)) / 2,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: widget.maxHeight,
                    maxWidth: widget.maxWidth,
                    minWidth: widget.maxWidth),
                child: Card(
                  color: Color(0xFFFFC100),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(widget.cardCornerRadius)),
                  child: Container(
                    padding: widget.padding,
                    child: SingleChildScrollView(
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    AlertAnimation.isErrorPresent = false;
    _controller.dispose();
    super.dispose();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      Timer(
        Duration(milliseconds: widget.timeStay),
        () {
          _animation.removeStatusListener(handler);
          _controller.reset();
          _animation = Tween(begin: 0.0, end: -1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
          )..addStatusListener((status) {});
          _controller.forward();
        },
      );
    }
  }
}
