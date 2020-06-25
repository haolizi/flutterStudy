# Fluro使用教程（二）

* [Fluro使用教程（一）](FLURO1.md)

## Fluro封装
我们新建三个dart文件（在[项目](https://github.com/haolizi/electricity_flutter)中路径config/router文件夹下）。
* router_application.dart  // 初始化路由
* router_handler.dart      // handler集合
* routers.dart             // 路由集合

### router_application.dart
统一封装路由的初始化。
```
import 'package:fluro/fluro.dart';

class ApplicationRouter {
  static Router router;
}
```
MyApp中引入一下
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由
    final router = Router();
    ApplicationRouter.router = router;
    ...

    return new MaterialApp(
      title: '某知名电商',
      onGenerateRoute: ApplicationRouter.router.generator,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new Tabs()
    );
  }
}
```
在需要跳转的页面执行即可（users/1234是临时命名）
```
ApplicationRouter.router.navigateTo(context,'/users/1234', transition:TransitionType.fadeIn);
```
### router_handler.dart
在上篇Handler源码中可以看到HandleFunc需要传入Map<String, List<string> parameters>,也就是我们跳转页面需要传的值，类型是字符串，所以我们可以这样写：

```
// 你也可以不用id，自己定个规范就好
ApplicationRouter.router.navigateTo(context,'/users/1234?id=${id}', transition:TransitionType.fadeIn);
```

Handler我们改造成这样：
```
Handler homeDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // 取出传的值
    String goodsId = params['id'].first;
    // 跳页面时传过去
    return HomeDetailPage(goodsId:goodsId);
  }
);

// 订单支付页（不需要传值）
Handler orderPayHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return OrderPayPage();
  }
);
```
### routers.dart
跳转页面多的话，也会有很多路由配置，统一写进routers.dart中方便管理。
```
class Routes {
  static String root = '/';                   // 根目录
  static String detailPage = '/detail';       // 商品详情
  static String orderPayPage = '/order/pay';  // 订单支付
  ...
  
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        // 跳转未定义的路由，可以自定义个错误页面
        return Text('未找到页面');
      }
    );
    
    // 创建pageRouter
    router.define(detailPage, handler: homeDetailsHandler);
    router.define(orderPayPage, handler: orderPayHandler);
  }
}
```
MyApp中还需调用configureRoutes来完成全局配置和路由定义
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 路由
    final router = Router();
    ApplicationRouter.router = router;
    Routes.configureRoutes(router);

    return new MaterialApp(
      title: '某知名电商',
      onGenerateRoute: ApplicationRouter.router.generator,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new Tabs()
    );
  }
}
```
至此，Fluro的使用基本完成。
