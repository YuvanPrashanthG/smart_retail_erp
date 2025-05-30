import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_controller.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage ({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListAsync = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          Text("Add Product"),
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {},
            tooltip: "Add Data",
          ),
        ],),
      body: productListAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await ref.read(productRepoProvider).deleteProduct(product.id);
                  // ignore: unused_result
                  ref.refresh(productListProvider);
                },
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
