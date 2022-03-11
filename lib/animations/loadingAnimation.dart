// ignore_for_file: must_call_super, prefer_const_constructors_in_immutables, file_names

import 'package:blinking_morse/screens/resultpage.dart';
import 'package:flutter/material.dart';

class RotatedArrowAnimation extends StatefulWidget {
  final String text;
  RotatedArrowAnimation({Key? key, required this.text}) : super(key: key);

  @override
  State<RotatedArrowAnimation> createState() => _RotatedArrowAnimationState();
}

class _RotatedArrowAnimationState extends State<RotatedArrowAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    String message = widget.text;
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward().whenComplete(() {
      //Going to the next page and passing the typed message
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MorseCodeResultPage(message: message)));
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: animation,
          child: SizedBox(
              child: Image.asset(
            'assets/images/arrow.png',
            height: 100,
          )),
        ),
      ),
    );
  }
}
