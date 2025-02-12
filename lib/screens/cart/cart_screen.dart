import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final productId = cartItems.keys.elementAt(index);
                  final productData = cartItems[productId]!;
                  final product = productData['product'] as Product;
                  final quantity = productData['quantity'] as int;

                  return Card(
                    elevation: 0.8,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 40,
                        child: Image.network(product.image, fit: BoxFit.cover),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Now correctly using product title
                      subtitle: Text(
                          "Original Price:${product.price}\nItem Total: \$${(product.price * quantity).toStringAsFixed(2)}"),
                      // Using actual product price
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () {
                              cartProvider.removeFromCart(product);
                            },
                          ),
                          CircleAvatar(child: Text("$quantity")),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.green),
                            onPressed: () {
                              cartProvider.addToCart(product);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blueGrey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      cartProvider.totalPrice.toStringAsFixed(2).toString() != '0.00' ? Colors.purple : Colors.grey)),
              onPressed: cartProvider.totalPrice.toStringAsFixed(2).toString() != '0.00'
                  ? () {
                      if (cartProvider.totalPrice.toStringAsFixed(2).toString() != '0.00') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("The Payment screen will open from here"),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    }
                  : null,
              child: Text(
                "Proceed to Checkout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
