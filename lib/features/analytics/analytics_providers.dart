import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/analytics_controller.dart';
import 'model/analytics_models.dart';

// Provide an instance of the controller
final analyticsControllerProvider = Provider((ref) => AnalyticsController());

// Provider for Sales Over Time
final salesOverTimeProvider = FutureProvider<List<SalesDataPoint>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('bills')
      .select('date, total')
      .order('date', ascending: true);

  return (response as List).map((entry) {
    return SalesDataPoint(
      date: DateTime.parse(entry['date']),
      amount: (entry['total'] as num).toDouble(),
    );
  }).toList();
});

// ✅ Provider for Top Products
final topProductsProvider = FutureProvider<List<TopProductAnalytics>>((ref) async {
  final controller = ref.read(analyticsControllerProvider);
  return controller.getTopProducts();
});


// Provider for Stock Levels
final stockLevelsProvider = FutureProvider<List<StockLevelData>>((ref) async {
  final controller = ref.read(analyticsControllerProvider);
  return controller.getStockLevels();
});
   