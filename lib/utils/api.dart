class Api {
  final isProd = bool.fromEnvironment('dart.vm.product');

  String get appName => isProd ? 'App' : 'App (Debug)';

  String get baseUrl =>
      isProd ? 'http://39.103.179.207:3000' : 'http://127.0.0.1:3000';

  //首页精选数据
  static String tVideoHome = "/t_video_home";
  //选集列表
  static String tVideoDetails = "/t_video_details";
  //腾讯视频分类
  static String tVideochannelList = "/t_video_home/channel_list";
  //加载更多
  static String tVideoLoadMore = "/t_video_home/load_more";
  //聚合搜索
  static String aggregateSearch = "/aggregate_search";
}
