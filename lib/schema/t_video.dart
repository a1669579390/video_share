// {
//     "code": 200,
//     "msg": "success",
//     "data": [
//         {
//             "href": "https://v.qq.com/x/cover/m441e3rjq9kwpsc.html",
//             "title": "斗罗大陆",
//             "img": "//puui.qpic.cn/vcover_vt_pic/0/m441e3rjq9kwpsc1635739384893/220",
//             "text": "更新至181集"
//         }
//     ]
// }

//   {
//             "href": "https://v.qq.com/x/cover/m441e3rjq9kwpsc.html",
//              "title": "斗罗大陆",
//             "img": "//puui.qpic.cn/vcover_vt_pic/0/m441e3rjq9kwpsc1635739384893/220",
//            "text": "更新至181集"
//     }
import 'dart:developer';

class TVideoDataItemListData {
  late String href;
  late String title;
  late String img;
  late String text;
  late String cid;

  TVideoDataItemListData({
    required this.href,
    required this.title,
    required this.img,
    required this.text,
    required this.cid,
  });

  TVideoDataItemListData.fromJson(Map<String, dynamic> json) {
    href = json["href"].toString();
    title = json["title"].toString();
    img = json["img"].toString();
    text = json["text"].toString();
    cid = json["cid"].toString();
  }
}

class TVideoDataItemList {
  int? code;
  String? msg;
  List<TVideoDataItemListData?>? data;
  // List<>

  TVideoDataItemList({this.code, this.msg, this.data});
  TVideoDataItemList.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    final v = json["data"];

    final arr = <TVideoDataItemListData>[];
    v.forEach((e) {
      arr.add(TVideoDataItemListData.fromJson(e));
    });
    data = arr;
  }
}