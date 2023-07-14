import 'package:flutter/material.dart';

class OpenAnimation extends StatefulWidget {
  final child;
  const OpenAnimation({Key? key, this.child}) : super(key: key);

  @override
  _OpenAnimationState createState() => _OpenAnimationState();
}

class _OpenAnimationState extends State<OpenAnimation>
    with SingleTickerProviderStateMixin {
  static bool fade = true;
  static AnimationController? _controller;
  Animation? scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    scale = Tween<double>(begin: .95, end: 1).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 50), () async {
      _controller!.forward();
      fade = false;
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
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
          scale: scale!.value,
          child: child,
        ),
      ),
    );
  }
}
