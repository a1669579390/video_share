import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:video_share/request/api_response.dart';
import 'package:video_share/request/http_utils.dart';
import 'package:video_share/schema/t_video.dart';
import 'package:video_share/utils/api.dart';
import 'package:video_share/utils/toast.dart';

class TencentVideo extends StatefulWidget {
  const TencentVideo({Key? key}) : super(key: key);

  @override
  _TencentVideoState createState() => _TencentVideoState();
}

class _TencentVideoState extends State<TencentVideo> {
  final _baseUrl = Api().baseUrl;
  final _home = Api.tVideoHome;
  final _channelList = Api.tVideochannelList;
  List<TVideoDataItemListData?> _data = [];
  RxList _channelListData = [].obs;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SimpleController>(
        init: SimpleController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.amber.shade300,
              body: SafeArea(
                  child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                padding: EdgeInsets.all(10),
                itemCount: Get.find<SimpleController>()._data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Obx(() => FirstItem(
                          data: _channelListData.value,
                        ));
                  } else {
                    return ItemContainer(
                      index: index,
                      text: Get.find<SimpleController>()._data[index]!.text,
                      title: Get.find<SimpleController>()._data[index]!.title,
                      img: Get.find<SimpleController>()._data[index]!.img,
                      href: Get.find<SimpleController>()._data[index]!.href,
                      cid: Get.find<SimpleController>()._data[index]!.cid,
                    );
                  }
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index == 0 ? 0.8 : 3),
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 9.0,
              )));
        });
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(img),
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
        );
      }),
    ];

    return Stack(
      children: widgets,
    );
  }
}

class FirstItem extends StatefulWidget {
  final data;
  const FirstItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _FirstItemState createState() => _FirstItemState();
}

class _FirstItemState extends State<FirstItem> {
  final _baseUrl = Api().baseUrl;
  final _home = Api.tVideoHome;
  final _channelList = Api.tVideochannelList;
  RxList _channelListData = [].obs;
  List<DropdownMenuItem<Object>>? _tabs = [];
  Object? selectedItem = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading();
  }

  Future<void> _loading() async {
    // EasyLoading.show(status: 'loading...');
    ApiResponse<TVideoChannelList> tVideoChannelDataResponse =
        await getChannelData();
    if (!mounted) {
      return;
    }
    // EasyLoading.dismiss();
    if (tVideoChannelDataResponse.status == Status.COMPLETED) {
      _channelListData.value = tVideoChannelDataResponse.data!.data;
      List<DropdownMenuItem<Object>>? res = [];
      _channelListData.value.forEach((e) => {
            res.add(
              DropdownMenuItem(
                  child: Row(children: <Widget>[
                    Text('${e.key}', style: TextStyle(color: Colors.black)),
                  ]),
                  value: '${e.href}'),
            )
          });
      setState(() {
        _tabs = res;
      });
    } else if (tVideoChannelDataResponse.status == Status.ERROR) {
      String errMsg = tVideoChannelDataResponse.exception!.getMessage();
      publicToast(errMsg);
    }
  }

  Future<ApiResponse<TVideoChannelList>> getChannelData() async {
    dynamic res = await HttpUtils.get('${_baseUrl}${_channelList}');
    TVideoChannelList data = TVideoChannelList.fromJson(res);
    return ApiResponse.completed(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 215, 1),
          border: Border.all(
              // 设置单侧边框的样式
              color: Colors.amber.shade600,
              width: 3,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: DropdownButton(
                alignment: AlignmentDirectional.centerStart,
                // icon: Icon(Icons.arrow_drop_down,
                dropdownColor: Colors.amber.shade200,
                value: selectedItem,
                icon: Container(),
                iconSize: 20,
                iconEnabledColor: Colors.green.withOpacity(0.7),
                style: TextStyle(
                  fontSize: 17,
                ),
                hint: Center(
                    child: Text('请选择分类',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ))),
                isExpanded: false,
                underline: Container(),
                items: _tabs,
                onChanged: (value) => {
                      Get.find<SimpleController>()._loading(channel: value),
                      setState(() => selectedItem = value!)
                    })));
  }
}

class SimpleController extends GetxController {
  final _baseUrl = Api().baseUrl;
  final _home = Api.tVideoHome;
  final _channelList = Api.tVideochannelList;
  List<TVideoDataItemListData?> _data = [];

  @override
  void onInit() {
    super.onInit();
    _loading();
  }

  Future<ApiResponse<TVideoDataItemList>> getData({channel}) async {
    dynamic res = await HttpUtils.get('${_baseUrl}${_home}',
        params: {"channel": channel});
    TVideoDataItemList data = TVideoDataItemList.fromJson(res);
    return ApiResponse.completed(data);
  }

  Future<void> _loading({channel}) async {
    EasyLoading.show(status: 'loading...');
    ApiResponse<TVideoDataItemList> tVideoDataResponse =
        await getData(channel: channel);

    EasyLoading.dismiss();
    if (tVideoDataResponse.status == Status.COMPLETED) {
      _data = tVideoDataResponse.data!.data!;
      update();
    } else if (tVideoDataResponse.status == Status.ERROR) {
      String errMsg = tVideoDataResponse.exception!.getMessage();
      publicToast(errMsg);
    }
  }
}
