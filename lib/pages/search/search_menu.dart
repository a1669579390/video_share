import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_share/pages/search/search_model.dart';

class SearchMenu extends StatelessWidget {
  const SearchMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showMapping = Get.find<SearchModelController>().showMapping;
    return _showMapping
        ? AnimatedSwitcher(
            transitionBuilder: (child, anim) {
              return FadeTransition(
                child: child,
                opacity: anim,
              );
            },
            key: key,
            duration: const Duration(milliseconds: 150),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.find<SearchModelController>().setType("b");
                      Get.find<SearchModelController>().setShowMapping();
                      // debugger();
                    },
                    child: Container(
                      width: 120,
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text("哔哩哔哩"),
                      decoration: const BoxDecoration(color: Colors.white),
                    )),
                GestureDetector(
                    onTap: () {
                      Get.find<SearchModelController>().setType("t");
                      Get.find<SearchModelController>().setShowMapping();
                    },
                    child: Container(
                      width: 120,
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text("腾讯视频"),
                      decoration: const BoxDecoration(color: Colors.white),
                    ))
              ],
            ))
        : AnimatedSwitcher(
            transitionBuilder: (child, anim) {
              return FadeTransition(
                child: child,
                opacity: anim,
              );
            },
            key: key,
            duration: const Duration(milliseconds: 150),
            child: Container());
  }
}
