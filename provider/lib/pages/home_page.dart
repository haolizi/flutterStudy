import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/collect_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return _itemWidget(context, index);
      },
    );
  }

  Widget _itemWidget(BuildContext context, int index) {
    return Consumer<CollectProvider>(builder: (context, child, value) {
      // 获取收藏列表
      List collectList =
          Provider.of<CollectProvider>(context, listen: false).collectList;
      // 当前商品是否是收藏状态
      bool isCollect = collectList.contains(index);
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: ListTile(
          title: Text('我是商品${index}'),
          trailing: Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
          onTap: () {
            Provider.of<CollectProvider>(context, listen: false)
                .collectIndex(index);
          },
        ),
      );
    });
  }
}
