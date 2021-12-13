import 'package:get/get.dart';

class SearchModelController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _query = '';
  String get query => _query;

  RxString _type = 'b'.obs;
  RxString get type => _type.obs.value;

  RxString _key = ''.obs;
  RxString get key => _key.obs.value;

  bool _showMapping = false;
  bool get showMapping => _showMapping;

  Map mapping = {
    "b": "哔哩哔哩",
    "t": "腾讯视频",
  };

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;

    if (query.isEmpty) {
      // _suggestions = history;
    } else {}

    // debugger();
    _isLoading = false;
  }

  void onSubmitted(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;

    if (query.isEmpty) {
      // _suggestions = history;
    } else {}

    // debugger();
    _isLoading = false;
  }

  void clear() {
    // _suggestions = history;
  }

  void setType(value) {
    _type.value = value;
  }

  void setShowMapping() {
    _showMapping = !_showMapping;
  }
}

const List history = [];
