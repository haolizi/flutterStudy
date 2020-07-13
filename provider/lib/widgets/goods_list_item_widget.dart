import 'package:flutter/material.dart';
import '../model/cart_model.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  final CartInfoModel model;
  final bool isCollect;
  const ItemWidget({Key key, this.model, this.isCollect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _goodsNamePriceWidget(model),
              _goodsDetailWidget(model),
            ],
          ),

          // 收藏图标
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Icon(
                isCollect ? Icons.favorite : Icons.favorite_border,
                color: isCollect ? Colors.red : null,
              ),
              onTap: () {
                Provider.of<CartProvider>(context, listen: false)
                    .collectGoods(model);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 商品名称和价格
  Widget _goodsNamePriceWidget(CartInfoModel model) {
    return Row(
      children: <Widget>[
        // 商品名称
        Text(
          model.title,
          style: TextStyle(fontSize: 17),
        ),

        // 商品价格
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(left: 10),
          child: Text(
            '￥${model.price}',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  // 商品价格
  Widget _goodsDetailWidget(CartInfoModel model) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        model.detail,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
