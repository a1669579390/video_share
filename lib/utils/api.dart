class Api {
  final isProd = bool.fromEnvironment('dart.vm.product');

  String get appName => isProd ? 'App' : 'App (Debug)';

  String get baseUrl =>
      isProd ? 'http://39.103.179.207:3000' : 'http://39.103.179.207:3000';

  //首页精选数据
  static String tVideoHome = "/t_video_home";
  //选集列表
  static String tVideoDetails = "/t_video_details";
}
