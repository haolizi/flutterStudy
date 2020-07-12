import 'providers/tab_index_provider.dart';
import 'providers/collect_provider.dart';
import 'package:flutter/material.dart';
import './config/tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentPageProvider()),
        ChangeNotifierProvider(create: (context) => CollectProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '商品列表',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: new Tabs(),
    );
  }
}
