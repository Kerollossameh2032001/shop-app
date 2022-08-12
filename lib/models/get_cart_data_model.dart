class GetCartData{
  late bool status;
  late CartData data;
  GetCartData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CartData.fromJson(json['data']);
  }
}

class CartData {
  late List<CartItem> cartItem=[];
  dynamic subTotal;
  dynamic total;
  CartData.fromJson(Map<String, dynamic> json){
    json['cart_items'].forEach((element) {
      cartItem.add(CartItem.fromJson(element));
    });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItem {
  late int id;
  late int quantity;
  late CartPoduct product;
  CartItem.fromJson(Map<String, dynamic> json){
    id=json['id'];
    quantity =json['quantity'];
    product =CartPoduct.fromJson(json['product']);
  }
}

class CartPoduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late List<String> images = [];
  late bool inFavorites;
  late bool inCart;

  CartPoduct.fromJson(Map<String, dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    json['images'].forEach((element) {
      images.add(element);
    });
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}