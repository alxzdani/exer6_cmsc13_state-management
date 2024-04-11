//CheckoutPage.dart


import 'package:exer6_cmsc23/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context), // display items
          computeCost(), // display cost
          const Divider(height: 4, color: Colors.black),
          Flexible(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //PAY NOW BUTTON

                  ElevatedButton(
                    onPressed: () {
                      final cart = context.read<ShoppingCart>();
                      if (cart.cart.isNotEmpty) {
                        cart.checkout();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        cart.removeAll(); // reset the state of the cart
                        
                        // navigate back to MyCatalog after successful payment
                        Navigator.pushNamed(context, "/products", arguments: "Payment Successful!");


                      } else { // catcher for the case that user can still see the checkout button
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No items to checkout"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Pay Now!"), // text button
                  ),
                ],
              ))),
        ],
      ),
    );
  }


  // get the item from the cart
  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? const Text('No Items yet!')
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(products[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        productname = products[index].name;
                        context.read<ShoppingCart>().removeItem(productname);

                        if (products.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname removed!"),
                            duration:
                                const Duration(seconds: 1, milliseconds: 100),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cart Empty!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
              ],
          ));
  }


  //get the total cost
  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
       return Text("Total: ${cart.cartTotal}");
    });
  }
}




