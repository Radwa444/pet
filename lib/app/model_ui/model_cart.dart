class ModelCart {
  String image;
  String name;
  String price;
  String qty;
  Map<String, dynamic>? attribute;

  ModelCart(this.image, this.name, this.price, this.qty, {this.attribute});
}
