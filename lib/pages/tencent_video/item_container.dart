import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        return Container(
          child: InkWell(
              onTap: () => {
                    Get.toNamed("/Tvideo",
                        arguments: {"href": href, "cid": cid}),
                  },
              onLongPress: () => {},
              child: Stack(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: new BoxConstraints.expand(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                      ),
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
                              decoration: ShapeDecoration(
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
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  Expanded(
                                      child: Text(
                                    text,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 11),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ],
                              )),
                        ),
                      ))
                ],
              )),
        );
      }),
    ];

    return Stack(
      children: widgets,
    );
  }
}
