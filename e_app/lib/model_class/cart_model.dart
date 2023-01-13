import 'package:e_app/model_class/e_model_class.dart';

class CartModel {
  static final cartModel = CartModel._inernal();

  CartModel._inernal();

  factory CartModel() => cartModel;

  late Catalog _catalog;

  final List<int> _itemIds = [];

  Catalog get catalog => _catalog;

  set catalog(Catalog newCatalog) {
    _catalog = newCatalog;
  }

  List<Mobile_items> get items =>
      _itemIds.map((ids) => _catalog.getById(ids)).toList();

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price!.toInt());

  void add(Mobile_items item) {
    _itemIds.add(item.ids!.toInt());
  }

  void remove(Mobile_items item) {
    _itemIds.remove(item.ids!.toInt());
  }

  void delete() {
    _itemIds.clear();
  }
}
