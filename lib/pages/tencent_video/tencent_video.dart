import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:video_share/request/api_response.dart';
import 'package:video_share/request/http_utils.dart';
import 'package:video_share/schema/t_video.dart';
import 'package:video_share/utils/api.dart';

class TencentVideo extends StatefulWidget {
  const TencentVideo({Key? key}) : super(key: key);

  @override
  _TencentVideoState createState() => _TencentVideoState();
}

class _TencentVideoState extends State<TencentVideo> {
  final _baseUrl = Api().baseUrl;
  final _home = Api.tVideoHome;
  List<TVideoDataItemListData?> _data = [];
  @override
  void initState() {
    super.initState();

    _loading();
  }

  @override
  dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade300,
        body: SafeArea(
            child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          padding: EdgeInsets.all(10),
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) => ItemContainer(
            index: index,
            text: _data[index]!.text,
            title: _data[index]!.title,
            img: _data[index]!.img,
            href: _data[index]!.href,
            cid: _data[index]!.cid,
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index == 0 ? 1 : 3),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 9.0,
        )));
  }

  Future<ApiResponse<TVideoDataItemList>> getData() async {
    EasyLoading.show(status: 'loading...');
    dynamic res = await HttpUtils.get('${_baseUrl}${_home}');
    TVideoDataItemList data = TVideoDataItemList.fromJson(res);
    EasyLoading.dismiss();
    return ApiResponse.completed(data);
  }

  Future<void> _loading() async {
    ApiResponse<TVideoDataItemList> tVideoDataResponse = await getData();

    if (tVideoDataResponse.status == Status.COMPLETED) {
      setState(() {
        _data = tVideoDataResponse.data!.data!;
      });
    }
  }
}

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
    final List<Widget> widgets = <Widget>[
      Container(
        child: InkWell(
            onTap: () => {
                  Get.toNamed("/Tvideo", arguments: {"href": href, "cid": cid}),
                },
            onLongPress: () => {},
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(img),
                ),
                Positioned(
                    bottom: 0,
                    width: 180,
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
                                Text(title,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13)),
                                Text(text,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 11)),
                              ],
                            )),
                      ),
                    ))
              ],
            )),
      ),
    ];

    if (index == 0) {
      return FirstItem(
        index: index,
      );
    } else {
      return Stack(
        children: widgets,
      );
    }
  }
}

class FirstItem extends StatelessWidget {
  const FirstItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.amberAccent,
        child: Text('$index'),
      ),
    );
  }
}
