import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_share/pages/not_found/not_found_page.dart';
import 'package:video_share/pages/tencent_video/tencent_video.dart';
import 'package:video_share/widget/anim_bg_demo_page.dart';
import '../widget/custom_animated_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  // Color backgroundColor = Color(0xff050B18);
  Color backgroundColor = Colors.white;

  List<String> titles = ['腾讯视频', '搜索', '排名', '直播'];

  List<Widget> _pages = [
    TencentVideo(),
    AnimBgDemoPage(),
    NotFoundPage(),
    NotFoundPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   // systemOverlayStyle: SystemUiOverlayStyle.light,
        //   automaticallyImplyLeading: false,
        //   title: Text(
        //     titles[_currentIndex],
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 16,
        //     ),
        //   ),
        //   backgroundColor: backgroundColor,
        // ),
        backgroundColor: backgroundColor,
        body: getBody(_currentIndex),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 56,
      backgroundColor: backgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeInOut,
      onItemSelected: (index) => {
        // Get.toNamed("/page"),
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => HomePage())),
        setState(() => {
              _currentIndex = index,
            })
      },
      items: <MyBottomNavigationBarItem>[
        MyBottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/txsp.svg',
            color: const Color(0xffF4D144),
            width: 20.0,
          ),
          title: Text(titles[0]),
          activeColor: Color(0xffF4D144),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text(titles[1]),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: Icon(Icons.apps),
          title: Text(
            titles[2],
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: Icon(Icons.video_camera_front),
          title: Text(titles[3]),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody(_currentIndex) {
    // double width = 414;
    // double height = MediaQuery.of(context).size.width * (812 / 375);
    return _pages[_currentIndex];
  }
}
