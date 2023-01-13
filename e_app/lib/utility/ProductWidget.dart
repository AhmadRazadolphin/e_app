import 'package:e_app/model_class/cart_model.dart';
import 'package:e_app/model_class/e_model_class.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final Mobile_items;

  const ProductWidget({super.key, required this.Mobile_items})
      : assert(Mobile_items != null);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final _catalogModel = Catalog();
  final _cartModel = CartModel();
  String select = "Add to cart";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: ListTile(
          selectedColor: Colors.yellow,
          leading: SizedBox(
            height: height / 3,
            width: width / 5,
            child: Image.asset(
              widget.Mobile_items.image,
              height: 80,
            ),
          ),
          title: Text(widget.Mobile_items.name),
          subtitle: Text(widget.Mobile_items.desc),
          trailing: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                "\$${widget.Mobile_items.price.toString()}",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    _cartModel.catalog = _catalogModel;
                    _cartModel.add(widget.Mobile_items);

                    // if () {
                    //   select = "Selected";
                    // } else {
                    //   select = "Selected";
                    // }
                    // setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Add to cart")));
                  },
                  child: Text(select)),
            ],
          ),
        ),
      ),
    );
  }
}
