import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/collect_page.dart';
import '../providers/tab_index_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.collections), title: Text('收藏')),
  ];
  final List<String> _titleList = ['商品列表', '收藏'];
  final List<Widget> tabBodies = [HomePage(), CollectPage()];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Consumer<CurrentPageProvider>(builder: (context, child, value) {
      int currentIndex =
          Provider.of<CurrentPageProvider>(context, listen: false).currentIndex;
      return Scaffold(
        appBar: AppBar(title: Text(_titleList[currentIndex])),
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.red,
          unselectedItemColor: Colors.black38,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            Provider.of<CurrentPageProvider>(context, listen: false)
                .changeTabIndex(index);
          },
        ),
        body: IndexedStack(index: currentIndex, children: tabBodies),
      );
    });
  }
}
