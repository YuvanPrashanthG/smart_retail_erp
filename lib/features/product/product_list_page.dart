import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retail_erp/features/product/add_product.dart';
import 'package:smart_retail_erp/features/product/update_product.dart';
import 'product_controller.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListAsync = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          TextButton.icon(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const AddProductDialog(),
            ),
            icon: const Icon(Icons.add_circle),
            label: const Text("Add Product"),
          ),
        ],
      ),
      body: productListAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹${product.price.toStringAsFixed(2)}"),
                  Text("Stock: ${product.stock}"),
                ],
              ),
              leading: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.shopping_bag, size: 32),
                  if (product.stock < 3)
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit_note),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => UpdateProductDialog(product: product),
                  );
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
