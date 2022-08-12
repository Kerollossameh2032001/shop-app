class ChangeCarts {
  late bool status;
  late String message;
  late ChangeCartData data;

  ChangeCarts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = ChangeCartData.fromJson(json['data']);
  }
}

class ChangeCartData {
  late int id;
  late int quantity;
  late CartProductItem product;

  ChangeCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = CartProductItem.fromJson(json['product']);
  }
}

class CartProductItem {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String? name;
  late String description;

  CartProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
