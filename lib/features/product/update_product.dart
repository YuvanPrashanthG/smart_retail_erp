import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retail_erp/data/models/product_model.dart';
import 'package:smart_retail_erp/features/product/product_controller.dart';

class UpdateProductDialog extends ConsumerStatefulWidget {
  final Product product;
  const UpdateProductDialog({super.key, required this.product});

  @override
  ConsumerState<UpdateProductDialog> createState() => _UpdateProductDialogState();
}

class _UpdateProductDialogState extends ConsumerState<UpdateProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  late double price;
  late int stock;

  @override
  void initState() {
    super.initState();
    name = widget.product.name;
    description = widget.product.description;
    price = widget.product.price;
    stock = widget.product.stock;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Product"),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                  onChanged: (val) => name = val,
                  validator: (val) => val == null || val.isEmpty ? "Enter product name" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                  onChanged: (val) => description = val,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: price.toString(),
                  decoration: const InputDecoration(labelText: "Price", border: OutlineInputBorder()),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (val) => price = double.tryParse(val) ?? 0.0,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: stock.toString(),
                  decoration: const InputDecoration(labelText: "Stock", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => stock = int.tryParse(val) ?? 0,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                // delete action
                await ref.read(productRepoProvider).deleteProduct(widget.product.id);
                // ignore: unused_result
                ref.refresh(productListProvider);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
            SizedBox(width: 20,),
            TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
          ],
        ),
        
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final updatedProduct = Product(
                id: widget.product.id,
                name: name,
                description: description,
                price: price,
                stock: stock,
              );
              await ref.read(productRepoProvider).updateProduct(widget.product.id, updatedProduct);
              // ignore: unused_result
              ref.refresh(productListProvider);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
