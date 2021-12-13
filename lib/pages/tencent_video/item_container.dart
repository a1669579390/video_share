import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    Key? key,
    required this.href,
    required this.index,
    required this.img,
    required this.title,
    required this.text,
    required this.cid,
  }) : super(key: key);

  final int index;
  final String img;
  final String title;
  final String text;
  final String href;
  final String cid;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return InkWell(
            onTap: () => {
                  Get.toNamed("/Tvideo", arguments: {"href": href, "cid": cid}),
                },
            onLongPress: () => {},
            child: Stack(
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) => const SpinKitWave(
                      color: Colors.white,
                      size: 25,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    width: constraints.maxWidth,
                    height: 40,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                            decoration: const ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                  title,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                )),
                                Expanded(
                                    child: Text(
                                  text,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            )),
                      ),
                    ))
              ],
            ));
      }),
    ];

    return Stack(
      children: widgets,
    );
  }
}
