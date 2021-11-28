class Api {
  final isProd = bool.fromEnvironment('dart.vm.product');

  String get appName => isProd ? 'App' : 'App (Debug)';

  String get baseUrl => isProd
      ? 'http://39.103.179.207:3000'
      : 'http://7ed9-115-60-16-244.ngrok.io';

  //首页精选数据
  static String tVideoHome = "/t_video_home";
  //选集列表
  static String tVideoDetails = "/t_video_details";
  //腾讯视频分类
  static String tVideochannelList = "/t_video_home/channel_list";
  //加载更多
  static String tVideoLoadMore = "/t_video_home/load_more";
}
