import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retail_erp/data/models/cart_item.dart';
import '../product/product_controller.dart';
import 'cart_provider.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorePage extends ConsumerWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListAsync = ref.watch(productListProvider);
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final imgNot =
        'https://media.istockphoto.com/id/868482206/vector/shopping-bag-icon.jpg?s=612x612&w=0&k=20&c=R2O9rX1HxPkz3pvzRe2T0nY0Ko_SECNloAWm6AMk8n4=';
    double total = cart.fold(0.0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  _showCartDialog(context, cartNotifier, total, ref);
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: productListAsync.when(
        data: (products) => GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (_, index) {
            final product = products[index];
            return ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 400),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 5,
                        child: Image.network(
                          product.imageUrl ?? imgNot,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        child: Text("₹${product.price.toStringAsFixed(2)}"),
                      ),
                      Flexible(
                        child: Text("Stock: ${product.stock}"),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (product.stock > 0) {
                              cartNotifier.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("${product.name} added to cart")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Out of stock")),
                              );
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }

  void _showCartDialog(BuildContext context, CartNotifier cartNotifier,
      double total, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final cart = ref.watch(cartProvider);
          final total = cart.fold(0.0, (sum, item) => sum + item.total);

          return AlertDialog(
            title: const Text("Your Cart"),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cart.isEmpty) const Text("Your cart is empty."),
                  if (cart.isNotEmpty)
                    ...cart.map(
                      (item) => ListTile(
                        title: Text(item.product.name),
                        subtitle: Text("Qty: ${item.quantity}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .removeFromCart(item.product.id);
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text("Total: ₹${total.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              if (cart.isNotEmpty)
                ElevatedButton.icon(
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("Checkout"),
                  onPressed: () async {
                    await _checkoutAndSaveToSupabase(
                        cart, total, cartNotifier, ref);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Bill generated and stock updated")),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _checkoutAndSaveToSupabase(List<CartItem> cart, double total,
      CartNotifier cartNotifier, WidgetRef ref) async {
    final supabase = Supabase.instance.client;
    final billId = DateTime.now().millisecondsSinceEpoch.toString();
    final date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    try {
      // 1. Insert into 'bills' table FIRST
      await supabase.from('bills').insert({
        'bill_id': billId,
        'total': total,
        'date': date,
      });

      // 2. Then insert each purchase into 'purchase_history'
      for (final item in cart) {
        await supabase.from('purchase_history').insert({
          'bill_id': billId,
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.product.price,
          'total': item.total,
          'date': date,
        });

        // 3. Update product stock
        await supabase.from('products').update({
          'stock': item.product.stock - item.quantity,
        }).eq('id', item.product.id);
      }

      // 4. Clear cart and refresh product list
      cartNotifier.clearCart();
      // ignore: unused_result
      ref.refresh(productListProvider);
    } catch (e) {
      debugPrint("Checkout failed: $e");
      // You can show an error snackbar or handle it as needed
    }
  }
}
