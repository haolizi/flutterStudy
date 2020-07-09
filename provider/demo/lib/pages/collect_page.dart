import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/collect_provider.dart';

class CollectPage extends StatelessWidget {
  const CollectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectProvider>(builder: (context, child, value) {
      List collectList =
          Provider.of<CollectProvider>(context, listen: false).collectList;
      return ListView.builder(
        itemCount: collectList.length,
        itemBuilder: (context, index) {
          return _itemWidget(context, collectList[index]);
        },
      );
    });
  }

  Widget _itemWidget(BuildContext context, int collectIndex) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        title: Text('我是商品${collectIndex}'),
        trailing: Icon(Icons.favorite, color: Colors.red),
        onTap: () {
          Provider.of<CollectProvider>(context, listen: false)
              .collectIndex(collectIndex);
        },
      ),
    );
  }
}
