import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_share/pages/not_found/not_found_page.dart';
import 'package:video_share/pages/tencent_video/tencent_video.dart';
import 'package:video_share/pages/search/module.dart';
import 'bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  // Color backgroundColor = Color(0xff050B18);
  Color backgroundColor = Colors.white;

  List<String> titles = ['腾讯视频', '搜索', '排名', '直播'];

  final List<Widget> _pages = [
    const TencentVideo(),
    SearchPage(),
    const NotFoundPage(),
    const NotFoundPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          activeColor: const Color(0xffF4D144),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.search),
          title: Text(titles[1]),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.apps),
          title: Text(
            titles[2],
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.video_camera_front),
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
