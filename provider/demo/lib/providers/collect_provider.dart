import 'package:flutter/material.dart';

class CollectProvider with ChangeNotifier {
  List collectList = []; // 收藏列表
  collectIndex(int index) {
    if (collectList.contains(index)) {
      collectList.remove(index);
    } else {
      collectList.add(index);
    }
    print('-------collect:${collectList}');
    notifyListeners();
  }
}
