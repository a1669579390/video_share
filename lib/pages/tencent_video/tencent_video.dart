import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:video_share/pages/tencent_video/item_container.dart';
import 'package:video_share/request/api_response.dart';
import 'package:video_share/request/http_utils.dart';
import 'package:video_share/schema/t_video.dart';
import 'package:video_share/utils/api.dart';
import 'package:video_share/utils/toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Get.find<UpdateListController>()._loading(
        channel: Get.find<UpdateListController>().selectedItem,
        isLoading: false);
  }

  Future<void> _onLoad() async {
    await Get.find<UpdateListController>()._toLoadMore();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateListController>(
        init: UpdateListController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.amber.shade300,
              body: SafeArea(
                  child: EasyRefresh(
                      header: DeliveryHeader(), //头部刷新
                      footer: BezierBounceFooter(
                          backgroundColor: Colors.amber.shade200), //底部刷新
                      onRefresh: () async {
                        //下拉请求新数据
                        await _onRefresh();
                      },
                      onLoad: () async {
                        //下拉增加新数据
                        await _onLoad();
                      },
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        padding: EdgeInsets.all(10),
                        itemCount:
                            Get.find<UpdateListController>()._data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Obx(() => FirstItem(
                                  data: _channelListData.value,
                                ));
                          } else {
                            return ItemContainer(
                              index: index,
                              text: Get.find<UpdateListController>()
                                  ._data[index]!
                                  .text,
                              title: Get.find<UpdateListController>()
                                  ._data[index]!
                                  .title,
                              img: Get.find<UpdateListController>()
                                  ._data[index]!
                                  .img,
                              href: Get.find<UpdateListController>()
                                  ._data[index]!
                                  .href,
                              cid: Get.find<UpdateListController>()
                                  ._data[index]!
                                  .cid,
                            );
                          }
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(2, index == 0 ? 0.8 : 3),
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 9.0,
                      ))));
        });
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
    ApiResponse<TVideoChannelList> tVideoChannelDataResponse =
        await getChannelData();
    if (!mounted) {
      return;
    }
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
                      Get.find<UpdateListController>()._loading(channel: value),
                      setState(() => selectedItem = value!)
                    })));
  }
}

//数据共享
class UpdateListController extends GetxController {
  final _baseUrl = Api().baseUrl;
  final _home = Api.tVideoHome;
  final _loadMore = Api.tVideoLoadMore;
  dynamic selectedItem = "";
  // bool isLoading = true;
  final _channelList = Api.tVideochannelList;
  List<TVideoDataItemListData?> _data = [];
  Map _offset = {};

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

  Future<ApiResponse<TVideoDataItemList>> getLoadMoreData() async {
    if (!_offset.containsKey("${selectedItem}")) {
      _offset["${selectedItem}"] = 1;
    } else {
      _offset["${selectedItem}"]++;
    }

    dynamic res = await HttpUtils.get('${_baseUrl}${_loadMore}', params: {
      "channel": selectedItem,
      "offset": _offset["${selectedItem}"]
    });
    TVideoDataItemList data = TVideoDataItemList.fromJson(res);
    return ApiResponse.completed(data);
  }

  Future<void> _toLoadMore() async {
    ApiResponse<TVideoDataItemList> tVideoDataResponse =
        await getLoadMoreData();

    if (tVideoDataResponse.status == Status.COMPLETED) {
      var _appendData = tVideoDataResponse.data!.data!;
      // _data.add([]..._appendData,);
      _appendData.forEach((obj) => {_data.add(obj)});
      update();
    } else if (tVideoDataResponse.status == Status.ERROR) {
      String errMsg = tVideoDataResponse.exception!.getMessage();
      publicToast(errMsg);
    }
  }

  Future<void> _loading({channel, isLoading = true}) async {
    if (isLoading) {
      EasyLoading.show(status: 'loading...');
    }

    ApiResponse<TVideoDataItemList> tVideoDataResponse =
        await getData(channel: channel);
    selectedItem = channel;

    if (isLoading) {
      EasyLoading.dismiss();
    }

    if (tVideoDataResponse.status == Status.COMPLETED) {
      _data = tVideoDataResponse.data!.data!;
      _offset = {};
      update();
    } else if (tVideoDataResponse.status == Status.ERROR) {
      String errMsg = tVideoDataResponse.exception!.getMessage();
      publicToast(errMsg);
    }
  }
}
