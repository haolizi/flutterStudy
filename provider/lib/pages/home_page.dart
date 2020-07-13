import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../config/list_data.dart';
import '../model/cart_model.dart';
import '../widgets/goods_list_item_widget.dart';

class HomePage extends StatelessWidget {
  final List<CartInfoModel> list = [];
  @override
  Widget build(BuildContext context) {
    // 获取商品信息
    listData.cast().forEach((element) {
      list.add(CartInfoModel.fromJson(element));
    });
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _itemWidget(context, list[index]);
      },
    );
  }

  // Consumer监听收藏状态，rebuild单个item
  Widget _itemWidget(BuildContext context, CartInfoModel model) {
    return Consumer<CartProvider>(builder: (context, child, value) {
      List<CartInfoModel> collectList =
          Provider.of<CartProvider>(context, listen: false).cartList;
      bool isCollect = collectList.contains(model);
      return ItemWidget(model: model, isCollect: isCollect);
    });
  }
}
