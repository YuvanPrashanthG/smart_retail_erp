import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/analytics_models.dart';

final analyticsControllerProvider = Provider((ref) => AnalyticsController());

class AnalyticsController {
  final supabase = Supabase.instance.client;

  // Sales Over Time (Total by Date)
  Future<List<SalesData>> getSalesOverTime() async {
    final response = await supabase
        .from('purchase_history')
        .select('date, total')
        .order('date');

    final grouped = <String, double>{};

    for (var record in response) {
      final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(record['date']));
      final total = (record['total'] as num).toDouble();
      grouped[date] = (grouped[date] ?? 0) + total;
    }

    return grouped.entries
        .map((entry) => SalesData(date: entry.key, total: entry.value))
        .toList();
  }

  // Top Products Sold (Quantity-wise)
  Future<List<TopProductAnalytics>> getTopProducts() async {
    final response = await supabase
        .from('purchase_history')
        .select('product_id, quantity, products(name)')
        .order('quantity', ascending: false);

    final raw = response as List;

    final Map<String, int> productTotals = {};

    for (var row in raw) {
      final name = row['products']['name'];
      final qty = row['quantity'] as int;
      productTotals[name] = (productTotals[name] ?? 0) + qty;
    }

    return productTotals.entries
        .map((e) => TopProductAnalytics(productName: e.key, quantity: e.value))
        .toList();
  }

  // Stock Levels (From Product Table)
  Future<List<StockLevelData>> getStockLevels() async {
    final response = await supabase.from('products').select('name, stock');

    return response.map<StockLevelData>((item) {
      return StockLevelData(
        productName: item['name'],
        stock: (item['stock'] as num).toInt(),
      );
    }).toList();
  }
}
