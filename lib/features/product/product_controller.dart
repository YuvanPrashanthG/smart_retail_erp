import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

final productRepoProvider = Provider((ref) => ProductRepository());

final productListProvider = FutureProvider<List<Product>>((ref) {
  return ref.read(productRepoProvider).getProducts();
});
