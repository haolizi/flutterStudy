import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/goods_list_item_widget.dart';

class CollectPage extends StatelessWidget {
  const CollectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 购物车，使用Consumer监听数据变化，rebuild整个列表
        Consumer<CartProvider>(builder: (context, child, value) {
          return ListView.builder(
            itemCount: child.cartList.length,
            itemBuilder: (context, index) {
              return ItemWidget(model: child.cartList[index], isCollect: true);
            },
          );
        }),

        // 底部总价，selector监听总价变化，仅仅rebuild价格
        _bottomWidget(context),
      ],
    );
  }

  // 底部总价
  Widget _bottomWidget(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Selector<CartProvider, double>(
        builder: (BuildContext context, double price, child) {
          return Container(
            width: screenWidth,
            height: 50,
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              '总价：￥${price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          );
        },
        selector: (BuildContext context, CartProvider collectProvider) {
          return collectProvider.allPrice;
        },
      ),
    );
  }
}
