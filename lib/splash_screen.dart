import 'dart:async';

import 'package:covid_19_application/word_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WorldStatesScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
              child: const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/virus.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * .08),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
