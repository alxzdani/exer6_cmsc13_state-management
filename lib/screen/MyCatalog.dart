import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import '../provider/shoppingcart_provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> productsCatalog = [
    Item("Shampoo", 10.00, 2),
    Item("Soap", 12, 3),
    Item("Toothpaste", 40, 3),
  ];
  @override
  Widget build(BuildContext context) {
    // Receive payment status parameter
    final paymentStatus = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text("My Catalog")),
      body: Column(
        children: [
          // Display payment status if available
          if (paymentStatus != null) Text(paymentStatus),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(
                    "${productsCatalog[index].name} - ${productsCatalog[index].price}",
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      context
                          .read<ShoppingCart>()
                          .addItem(productsCatalog[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${productsCatalog[index].name} added!",
                          ),
                          duration: const Duration(seconds: 1, milliseconds: 100),
                        ),
                      );
                    },
                    child: const Text("Add"),
                  ),
                );
              },
              itemCount: productsCatalog.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.pushNamed(context, "/cart");
        },
      ),
    );
  }
}
