class SearchModel {
  late bool status;
  late SearchDataModel data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  late int currentPage;
  List<SearchProductData> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((element) {
      data.add(SearchProductData.fromJson(element));
    });
  }
}

class SearchProductData {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late List<String> images = [];
  late bool inFavorites;
  late bool inCart;

  SearchProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
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
