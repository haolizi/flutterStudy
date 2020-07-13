import 'package:demo/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartInfoModel> cartList = []; // 收藏列表
  double allPrice = 0;
  collectGoods(CartInfoModel model) {
    if (cartList.contains(model)) {
      cartList.remove(model);
    } else {
      cartList.add(model);
    }

    allPrice = 0;
    cartList.forEach((value) {
      allPrice += value.price;
    });
    notifyListeners();
  }
}
