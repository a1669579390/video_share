import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchModelController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _query = '';
  String get query => _query;

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

  void clear() {
    // _suggestions = history;
  }
}

const List history = [];
