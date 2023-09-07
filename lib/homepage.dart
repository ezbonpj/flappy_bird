import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gameHasStarted = false; 
  static double barrierXone = 1;
  double  barrierXtwo = barrierXone+1.5;
  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
        barrierXone -= 0.05;
      barrierXtwo -= 0.05;
      }); 
      setState(() {
        if(barrierXone<-2){
           barrierXone +=3.5;
      } else
     { barrierXone -= 0.05;
     }
      }); 

      setState(() {
        if(barrierXtwo<-2){
           barrierXtwo +=3.5;
      } else
     { barrierXtwo -= 0.05;
     }
      });









      if (birdYaxis > 1 || birdYaxis<-1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      startGame();
                    }
                  },
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.2),
                    child: gameHasStarted
                        ? const Text(" ")
                        : const Text(
                            "T A P  T O P L A Y",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                  AnimatedContainer(
                    alignment:  Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),
    
    
                   AnimatedContainer(
                    alignment:  Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),
    
    
                   AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
    
    
    
                   AnimatedContainer(
                    alignment:  Alignment(barrierXtwo,-1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 250.0,
                    ),
                  )
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("9999",
                          style: TextStyle(color: Colors.white, fontSize: 50)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BEST SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("80",
                          style: TextStyle(color: Colors.white, fontSize: 50)),
                    ],
                  )
                ]),
          ))
        ]),
      ),
    );
  }
}
