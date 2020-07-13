/*
 * -------购物车-------
 */

// 添加购物车
class CartInfoModel {
  String id;
  String title;
  String detail;
  double price;
  bool isCheck;

  CartInfoModel({this.id, this.title, this.detail, this.price, this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    price = json['price'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
