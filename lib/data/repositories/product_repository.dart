import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductRepository {
  final _client = Supabase.instance.client;

  Future<List<Product>> getProducts() async {
    final res = await _client.from('products').select().order('created_at', ascending: false);
    return (res as List).map((p) => Product.fromMap(p)).toList();
  }

  Future<void> addProduct(Product product) async {
    await _client.from('products').insert(product.toMap());
  }

  Future<void> updateProduct(String id, Product product) async {
    await _client.from('products').update(product.toMap()).eq('id', id);
  }

  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}
