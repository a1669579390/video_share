class BSearchData {
  late String href;
  late String title;
  late String img;
  late String text;

  BSearchData({
    required this.href,
    required this.title,
    required this.img,
    required this.text,
  });

  BSearchData.fromJson(Map<String, dynamic> json) {
    href = json["href"].toString();
    title = json["title"].toString();
    img = json["img"].toString();
    text = json["text"].toString();
  }
}

class BSearchList {
  late int code;
  late String msg;
  late List<BSearchData?> data;
  // List<>

  BSearchList({required this.code, required this.msg, required this.data});

  BSearchList.fromJson(Map<String, dynamic> json) {
    code = json["code"].toInt();
    msg = json["msg"].toString();
    final v = json["data"];

    final arr = <BSearchData>[];
    v.forEach((e) {
      arr.add(BSearchData.fromJson(e));
    });
    data = arr;
  }
}
