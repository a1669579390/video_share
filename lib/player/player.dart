import 'dart:collection';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:video_share/request/api_response.dart';
import 'package:video_share/request/http_utils.dart';
import 'package:video_share/schema/t_video_anthology.dart';
import 'package:video_share/utils/api.dart';

class InAppWebViewScreen extends StatefulWidget {
  @override
  _InAppWebViewScreenState createState() => new _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen>
    with TickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  RxInt tabsLength = 0.obs;
  final _baseUrl = Api().baseUrl;
  final _VideoDetails = Api.tVideoDetails;
  final urlController = TextEditingController();
  List<SplitList?> _data = [];
  List<Widget> _tabs = [];
  List<Widget> _tabViews = [];

  late TabController _tabcontroller;

  get _href {
    return Get.arguments['href'];
  }

  get _cid {
    return Get.arguments['cid'];
  }

  getTabs() {
    List<Widget> tabs = [];
    List<Widget> tabViews = [];
    _data.forEach((element) {
      tabs.add(Tab(text: '${element?.begin}--${element?.end}'));
      List<Widget> views = [];
      for (var d in element!.data!) {
        views.add(TextButton(
          child: Text('${d?.title}'),
          onPressed: () {},
        ));
      }
      tabViews.add(ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity, //宽度尽可能大
            minHeight: 150.0, //最小高度为50像素
            maxHeight: double.infinity,
          ),
          child: Wrap(
              spacing: 12.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.start, //沿主轴方向居中
              children: views)));

      // tabViews.add(Wrap(
      //   spacing: 8.0, // 主轴(水平)方向间距
      //   runSpacing: 4.0, // 纵轴（垂直）方向间距
      //   alignment: WrapAlignment.start, //沿主轴方向居中
      //   children: [
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     ),
      //     TextButton(
      //       child: Text('11'),
      //       onPressed: () {},
      //     )
      //   ],
      // ));
    });
    setState(() {
      _tabs = tabs;
      _tabViews = tabViews;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading();
    // getTabs();
    print("3");
    _tabcontroller = TabController(length: 0, vsync: this);
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                // print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          // print("onCreateContextMenu");
          // print(hitTestResult.extra);
          // print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
          // color: Colors.blue,
          ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    color: Colors.amber,
                  )
                : Container(),
            Container(
              height: 300,
              child: InAppWebView(
                key: webViewKey,
                // contextMenu: contextMenu,
                initialUrlRequest:
                    URLRequest(url: Uri.parse('https://okjx.cc/?url=$_href')),
                // initialFile: "assets/index.html",
                initialUserScripts: UnmodifiableListView<UserScript>([]),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      //跳转浏览器打开app
                      // Launch the App
                      // await launch(
                      //   url,
                      // );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onEnterFullscreen: (controller) {
                  AutoOrientation.landscapeAutoMode(forceSensor: true);
                  print("进入");
                },
                onExitFullscreen: (controller) {
                  AutoOrientation.portraitUpMode();
                  print("退出");
                },
              ),
            ),
            Container(
              //要给个高度 内容Container也要给个高度 来适应屏幕高度
              height: 30,
              color: Colors.purple,
              child: TabBar(
                  isScrollable: true, controller: _tabcontroller, tabs: _tabs),
            ),
            Container(
              //这个是显示内容的视图
              //给个高度高度一定要给 不然报错
              height: 0,
              child:
                  TabBarView(controller: _tabcontroller, children: _tabViews),
            )
          ],
        ),
      ),
    );
  }

  Future<ApiResponse<TVideoAnthologyList>> getData() async {
    EasyLoading.show(status: 'loading...');
    dynamic res = await HttpUtils.post('${_baseUrl}${_VideoDetails}',
        data: {"cid": '$_cid'});
    TVideoAnthologyList data = TVideoAnthologyList.fromJson(res);
    EasyLoading.dismiss();

    return ApiResponse.completed(data);
  }

  Future<void> _loading() async {
    ApiResponse<TVideoAnthologyList> tVideoDataResponse = await getData();
    if (tVideoDataResponse.status == Status.COMPLETED) {
      setState(() {
        _data = tVideoDataResponse.data!.data!;
        _tabcontroller = TabController(length: _data.length, vsync: this);
      });
      getTabs();
    }
  }
}