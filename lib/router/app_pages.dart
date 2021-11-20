// import 'package:flutter_getx_template/pages/Index/Index_view.dart';
// import 'package:flutter_getx_template/pages/home/home.binding.dart';
// import 'package:flutter_getx_template/pages/home/home_view.dart';
// import 'package:flutter_getx_template/pages/login/login_binding.dart';
// import 'package:flutter_getx_template/pages/login/login_view.dart';
// import 'package:flutter_getx_template/pages/notfound/notfound_view.dart';
// import 'package:flutter_getx_template/pages/proxy/proxy_view.dart';
import 'package:get/get.dart';
import 'package:video_share/pages/not_found/not_found_page.dart';
import 'package:video_share/player/chrome_safari_browser_example.screen.dart';
import 'package:video_share/player/headless_in_app_webview.screen.dart';
import 'package:video_share/player/in_app_browser_example.screen.dart';
import 'package:video_share/player/player.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Index;

  static final routes = [
    GetPage(
      name: AppRoutes.Index,
      page: () => NotFoundPage(),
    ),
    GetPage(
      name: AppRoutes.Tvideo,
      page: () => InAppWebViewScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.Home,
    //   page: () => HomePage(),
    //   binding: HomeBinding(),
    // ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotFoundPage(),
  );

  // static final proxyRoute = GetPage(
  //   name: AppRoutes.Proxy,
  //   page: () => ProxyPage(),
  // );
}
