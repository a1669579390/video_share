class BSearchData {
  late String areas;
  late String cover;
  late String text;
  late String title;
  late String url;
  late List eps;

  BSearchData({
    required this.areas,
    required this.cover,
    required this.text,
    required this.title,
    required this.eps,
    required this.url,
  });

  BSearchData.fromJson(Map<String, dynamic> json) {
    areas = json["areas"].toString();
    cover = json["cover"].toString();
    text = json["text"].toString();
    title = json["title"].toString();
    final v = json["eps"];
    final arr = <EpsList>[];
    v.forEach((e) {
      arr.add(EpsList.fromJson(e));
    });
    eps = arr;
    url = json["url"].toString();
  }
}

class EpsList {
  late int id;
  late String cover;
  late String title;
  late String long_title;
  late String url;

  EpsList({
    required this.id,
    required this.cover,
    required this.title,
    required this.long_title,
    required this.url,
  });

  EpsList.fromJson(Map<String, dynamic> json) {
    id = json["id"].toInt();
    cover = json["cover"].toString();
    title = json["title"].toString();
    long_title = json["long_title"].toString();
    url = json["url"].toString();
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
