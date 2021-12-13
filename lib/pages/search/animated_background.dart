import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:video_share/pages/search/search_bar.dart';
import 'package:video_share/pages/search/search_content.dart';
import 'package:video_share/pages/search/search_menu.dart';

enum _ColorTween { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_ColorTween>()
      ..add(
        _ColorTween.color1,
        const Color.fromRGBO(211, 111, 22, .9)
            .tweenTo(Colors.lightBlue.shade900),
        3.seconds,
      )
      ..add(
        _ColorTween.color2,
        const Color.fromRGBO(11, 111, 12, .8)
            .tweenTo(Colors.lightBlue.shade600),
        3.seconds,
      );

    return MirrorAnimation<MultiTweenValues<_ColorTween>>(
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xffF4D144), Colors.greenAccent,
                // value.get<Color>(_ColorTween.color1),
                // value.get<Color>(_ColorTween.color2)
              ])),

          child: Stack(
            children: [
              const Positioned(
                child: FloatingSearchAppBar(),
              ),
              Positioned(
                  top: MediaQuery.of(context).padding.top + 56,
                  left: 10,
                  child: const SearchMenu()),
              Positioned(
                  top: MediaQuery.of(context).padding.top + 70,
                  child: SearchContent())
            ],
          ),
          // 这里传入widget
        );
      },
    );
  }
}
