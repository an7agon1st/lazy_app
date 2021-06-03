import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LazyAppBar extends AppBar {
  LazyAppBar()
      : super(
          backgroundColor: Colors.white,
          title: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "LazyApp",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bobbers',
                        color: Colors.black),
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 10.0, fontFamily: 'Agne', color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      stopPauseOnTap: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                            'A reason to not get off your ass'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
