import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    debugPrint('Product: ${product.toJson()}');
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    ValueNotifier<bool> isProductAdded = ValueNotifier(false);
    Product? tempProduct;

    if (cartProvider.cartItems.isNotEmpty) {
      try {
        for (var entry in cartProvider.cartItems.values) {
          tempProduct = entry['product'] as Product;
          if (tempProduct.id == product.id) {
            isProductAdded.value = tempProduct.id == product.id;
            break;
          }
        }
      } catch (e, st) {
        debugPrint("e: $e, st: $st");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Price
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),

                  // Category
                  Text(
                    "Category: ${product.category}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),

                  // Description
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 24),

                  ValueListenableBuilder(
                    valueListenable: isProductAdded,
                    builder: (context, value, child) {
                      if (isProductAdded.value) {
                        // Remove from Cart Button
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Remove from Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              textStyle: TextStyle(fontSize: 18, color: Colors.white),
                              backgroundColor: isProductAdded.value ? Colors.red : Colors.purple,
                            ),
                            onPressed: () {
                              cartProvider.removeFromCart(product);
                              isProductAdded.value = false;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Removed from Cart"),
                                duration: Duration(seconds: 1),
                              ));
                            },
                          ),
                        );
                      } else {
                        // Add to Cart Button
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              textStyle: TextStyle(fontSize: 18, color: Colors.white),
                              backgroundColor: isProductAdded.value ? Colors.red : Colors.purple,
                            ),
                            onPressed: () {
                              cartProvider.addToCart(product);
                              isProductAdded.value = true;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Added to Cart"),
                                duration: Duration(seconds: 1),
                              ));
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
