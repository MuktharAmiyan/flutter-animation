import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  const FlipCard({super.key});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  final double size = 200;
  final Color grey = Colors.grey.shade900;
  int second = 0;
  int nextSecond = 0;

  @override
  void initState() {
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(_flipController);

    Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      _flipController
        ..reset()
        ..forward();
      setState(() {
        second = DateTime.now().second;
        nextSecond = second + 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: grey,
                    height: size,
                    width: size,
                    child: Text(
                      nextSecond.toString(),
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 100,
                              ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, .002)
                            ..rotateX(_flipAnimation.value),
                          child: ClipPath(
                            clipper:
                                HalfContainerCliper(side: ContainerSide.bottom),
                            child: Container(
                              alignment: Alignment.center,
                              color: grey,
                              height: size,
                              width: size,
                              child: Text(
                                second.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 100,
                                    ),
                              ),
                            ),
                          ),
                        );
                      }),
                  ClipPath(
                    clipper: HalfContainerCliper(side: ContainerSide.bottom),
                    child: Container(
                      alignment: Alignment.center,
                      color: grey,
                      height: size,
                      width: size,
                      child: Text(
                        second.toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100,
                                ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, .002)
                            ..rotateX(_flipAnimation.value),
                          child: ClipPath(
                            clipper:
                                HalfContainerCliper(side: ContainerSide.top),
                            child: Container(
                              alignment: Alignment.center,
                              color: grey,
                              height: size,
                              width: size,
                              child: Text(
                                second.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 100,
                                    ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Divider(
                thickness: 5,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ContainerSide {
  top,
  bottom,
}

extension ToPath on ContainerSide {
  Path toPath(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    switch (this) {
      case ContainerSide.top:
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        break;
      case ContainerSide.bottom:
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
    }
    path.close();

    return path;
  }
}

class HalfContainerCliper extends CustomClipper<Path> {
  final ContainerSide side;
  HalfContainerCliper({required this.side});
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
