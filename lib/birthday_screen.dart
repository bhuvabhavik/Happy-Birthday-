import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

bool isVisible = false;
String buttontext = 'Click Me';
String wishtext =
    '******* *** *** **** ******** *** *** ****** ******* ****..*** *** ******* *** ******** ** **** **** *********** *****.';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({Key? key}) : super(key: key);

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color(0xff111328),
            body: Center(
              child: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Visibility(
                            visible: isVisible,
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xff111328),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://raw.githubusercontent.com/bhuvabhavik/Happy-Birthday-/master/s.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: ConfettiWidget(
                              shouldLoop: true,
                              confettiController: _controllerTopCenter,
                              blastDirection: pi / 2,
                              maxBlastForce: 5, // set a lower max blast force
                              minBlastForce: 2, // set a lower min blast force
                              emissionFrequency: 0.05,
                              numberOfParticles:
                                  5, // a lot of particles at once
                              gravity: 0.1,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ConfettiWidget(
                              confettiController: _controllerCenter,
                              blastDirectionality: BlastDirectionality
                                  .explosive, // don't specify a direction, blast randomly
                              shouldLoop:
                                  true, // start again as soon as the animation is finished
                              colors: const [
                                Colors.green,
                                Colors.blue,
                                Colors.pink,
                                Colors.orange,
                                Colors.purple
                              ], // manually specify the colors to be used
                              createParticlePath:
                                  drawStar, // define a custom shape/path.
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        shadowColor: Colors.black,
                        color: const Color(0xff1e1d33),
                        child: MaterialButton(
                          onPressed: () {
                            _controllerCenter.play();
                            _controllerTopCenter.play();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              wishtext,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 3),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.green,
                        color: const Color(0xffffee37),
                        child: MaterialButton(
                          child: _display(buttontext),
                          onPressed: () {
                            _controllerCenter.play();
                            _controllerTopCenter.play();
                            _controllerCenter.play();
                            setState(() {
                              isVisible = true;
                              wishtext =
                                  'Wishing you the most exciting and fun filled birthday ever..May you receive the greatest of joys and everlasting bliss.';
                              buttontext = '❤ HAPPY BIRTHDAY.. ❤';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

Text _display(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
  );
}
