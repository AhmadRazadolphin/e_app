class Catalog {
  static final catModel = Catalog._inernal();

  Catalog._inernal();

  factory Catalog() => catModel;

  static List<Mobile_items> products = [];

  Mobile_items getById(int ids) => products.firstWhere(
        (element) => element.ids == ids,
        // orElse: null
      );

  Mobile_items getByPosition(int pos) => products[pos];
}

class Mobile_items {
  int? ids;
  final String? name;
  final String? desc;
  final int? price;
  final String? color;
  final String? image;

  Mobile_items(
      {this.ids, this.name, this.desc, this.price, this.color, this.image});

  factory Mobile_items.fromMap(Map<String, dynamic> map) {
    return Mobile_items(
      ids: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      color: map["color"],
      image: map["image"],
    );
  }
  toMap() => {
        "ids": ids,
        "name": name,
        "desc": desc,
        "price": price,
        "color": color,
        "image": image,
      };
}
