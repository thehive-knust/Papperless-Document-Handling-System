import 'package:flutter/material.dart';

class TransitionAnimation extends StatefulWidget {
  final Widget? child;
  final int? delay;

  const TransitionAnimation({Key? key, this.child, this.delay}) : super(key: key);
  @override
  TransitionAnimationState createState() => TransitionAnimationState();
}

class TransitionAnimationState extends State<TransitionAnimation>
    with SingleTickerProviderStateMixin {
  bool fade = true;
  AnimationController? _controller;
  Animation<double>? fadeIn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    fadeIn = Tween<double>(begin: .7, end: 1).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 120 + widget.delay! * 55), () {
      animate();
    });
  }

  @override
  void dispose() {

    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      child: widget.child,
      builder: (context, child) => AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: fade ? 0 : 1,
          child: Transform.scale(
            scale: fadeIn?.value,
            child: child,
          )),
    );
  }

  animate() {
    _controller?.forward();
    fade = false;
  }
}
