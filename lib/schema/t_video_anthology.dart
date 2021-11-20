// interface Details {
//   play_title: string;
//   vid: string;
//   cid: string;
//   image_url: string;
//   play_url: string;
//   title: string;
// }
import 'dart:developer';

class TVideoAnthologyListData {
  late String playTitle;
  late String vid;
  late String cid;
  late String text;
  late String imageUrl;
  late String playUrl;
  late String title;

  TVideoAnthologyListData({
    required this.playTitle,
    required this.vid,
    required this.cid,
    required this.text,
    required this.imageUrl,
    required this.playUrl,
    required this.title,
  });

  TVideoAnthologyListData.fromJson(Map<String, dynamic> json) {
    playTitle = json["play_title"].toString();
    vid = json["vid"].toString();
    cid = json["cid"].toString();
    text = json["text"].toString();
    imageUrl = json["image_url"].toString();
    playUrl = json["play_url"].toString();
    title = json["title"].toString();
  }
}

class SplitList {
  late String begin;
  late String end;
  List<TVideoAnthologyListData?>? data;

  SplitList({required this.begin, required this.end, required this.data});

  SplitList.fromJson(Map<String, dynamic> json) {
    begin = json["begin"].toString();
    end = json["end"].toString();
    final v = json["data"];
    final arr = <TVideoAnthologyListData>[];
    v.forEach((e) {
      arr.add(TVideoAnthologyListData.fromJson(e));
    });
    data = arr;
  }
}

class TVideoAnthologyList {
  int? code;
  String? msg;
  List<SplitList?>? data;
  // List<>

  TVideoAnthologyList({this.code, this.msg, this.data});
  TVideoAnthologyList.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    final v = json["data"];
    final arr = <SplitList>[];
    v.forEach((e) {
      arr.add(SplitList.fromJson(e));
    });
    data = arr;
  }
}
