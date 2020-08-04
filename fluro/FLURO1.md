# Fluro使用教程（-）

* [Fluro使用教程（二）](FLURO2.md)

> 本文主要介绍Fluro的使用，至于什么是Fluro，为什么使用Fluro，还请自行搜索。
> 本文会以本人的【[练手项目](https://github.com/haolizi/electricity_flutter)】为实例，一步步展开，如果有需要，还望前去clone，对比代码，方便理解。

### 前提须知
```dart
// 需要跳转到的页面：
- 商品详情页 HomeDetailPage()  // 项目路径pages/home/pages/home_detail_page.dart
- 订单支付页 OrderPayPage()    // 项目路径pages/order/home_detail_page.dart
```

### 初始化路由
```dart
final router = Router();
```

### 路由跳转
点击进入查看源码，具体如下：
```dart
///你可以手动推送一个路由，比如这样：
router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);

Future navigateTo(BuildContext context, String path,
    {bool replace = false,
    bool clearStack = false,
    TransitionType transition,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder}) {
    ....
    return future;
  }
```

navigateTo返回一个future，future是什么呢？继续往下看：
```dart
if (route != null) {
    if (clearStack) {
        future = 
        Navigator.pushAndRemoveUntil(context, route, (check) => false);
    } else {
        future = replace
            ? Navigator.pushReplacement(context, route)
            : Navigator.push(context, route);
        }
        ...
    }
```

默认clearStack为false，replace也是false，这不就是我们常见的Navigator跳转future = Navigator.push(context, route); context是是直接传入的上下文，那么route呢？
```dart
RouteMatch routeMatch = matchRoute(context, path,
    transitionType: transition,
    transitionsBuilder: transitionBuilder,
    transitionDuration: transitionDuration);
Route<dynamic> route = routeMatch.route;
```

传入path等参数，即可得到route，path也就是我们命名的路由，这时候如果我们直接调用作者示例
```dart
final router = Router();
router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);
```

大概会报错：
```dart
No registered route was found to handle '/users/1234'。
```

说我们路由没有注册，而这个handle又是什么呢：
* 路由在哪注册？源码如下
```dart
/// The tree structure that stores the defined routes
  final RouteTree _routeTree = RouteTree();
    ...

 /// Creates a [PageRoute] definition for the passed [RouteHandler].
 /// You can optionally provide a default transition type.
  void define(String routePath,
    {@required Handler handler, TransitionType transitionType}) {
        _routeTree.addRoute(
            AppRoute(routePath, handler, transitionType: transitionType),
        );
  }
```

RouteTree用来存储定义的路由，define创建PageRoute，比如：
```dart
router.define('/users/1234', handler: XXX);
```

* Handle源码如下
```dart
class Handler {
  Handler({this.type = HandlerType.route, this.handlerFunc});
  final HandlerType type;
  final HandlerFunc handlerFunc;
}
...
typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> parameters);
```

Handler是构造成HandlerType.route类型的类，参考代码，我们构造一个handle
```dart
/* 商品详情
 * 项目路径config/routers/router_handle.dart
 */
Handler homeDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomeDetailPage();
  }
);
```

### 总结
至此，如果我们依次调用以下代码，应该就能够跳转到商品详情页了（/users/1234 是临时命名）。
```dart
final router = Router();

router.define('/users/1234', handler: homeDetailsHandler);

Handler homeDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomeDetailPage();
  }
);

router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);
```
设想下，一个项目肯定不可能只有一个界面跳转，既然代码相同，我们是不是可以抽离出来统一调用呢？详见下一篇[Fluro使用教程（二）](FLURO2.md)。
