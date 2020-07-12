import 'package:demo/model/cart_model.dart';
import 'package:flutter/material.dart';

class CollectProvider with ChangeNotifier {
  List<CartInfoModel> cartList = []; // 收藏列表
  double allPrice = 0;
  collectGoods(CartInfoModel model) {
    if (cartList.contains(model)) {
      cartList.remove(model);
    } else {
      cartList.add(model);
    }

    cartList.forEach((value) {
      allPrice += double.parse(value.price);
    });
    notifyListeners();
  }
}
