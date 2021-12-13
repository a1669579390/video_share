import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'search_model.dart';

class FloatingSearchAppBarExample extends StatelessWidget {
  const FloatingSearchAppBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchModelController());
    RxString _type = Get.find<SearchModelController>().type;
    Map mapping = Get.find<SearchModelController>().mapping;
    String query = Get.find<SearchModelController>().query;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GetBuilder<SearchModelController>(
        init: SearchModelController(),
        builder: (controller) {
          return FloatingSearchBar(
            hint: '平台聚合搜索',
            // backgroundColor: Color.fromRGBO(0, 0, 0, 1),
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 400),
            transitionCurve: Curves.fastOutSlowIn,
            physics: const BouncingScrollPhysics(),
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            width: isPortrait ? 600 : 500,
            debounceDelay: const Duration(milliseconds: 400),
            progress: Get.find<SearchModelController>().isLoading,
            onQueryChanged: Get.find<SearchModelController>().onQueryChanged,
            onSubmitted: Get.find<SearchModelController>().onSubmitted,
            transition: CircularFloatingSearchBarTransition(),
            //搜索框左边图标
            leadingActions: [
              FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                      icon: Get.find<SearchModelController>().showMapping
                          ? const Icon(Icons.arrow_downward_rounded)
                          : const Icon(Icons.menu),
                      onPressed: () {
                        Get.find<SearchModelController>().setShowMapping();
                      })),
              Text("${mapping[_type]}", style: const TextStyle(fontSize: 11))
            ],
            //搜索框右边图标
            actions: [
              query.isEmpty
                  ? FloatingSearchBarAction(
                      showIfOpened: true,
                      child: CircularButton(
                          icon: const Icon(Icons.search), onPressed: () {}),
                    )
                  : FloatingSearchBarAction.searchToClear(),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.amber,
                  elevation: 4.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: Colors.accents.map((color) {
                      return Container(height: 22, color: color);
                    }).toList(),
                  ),
                ),
              );
            },
          );
        });
  }
}
