import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_state.dart';

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController() : super(DashboardState.initial()) {
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    final client = Supabase.instance.client;

    final productResponse = await client.from('products').select('id, stock');
    final billResponse = await client.from('bills').select('total');

    int totalStock = 0;
    for (var p in productResponse) {
      totalStock += (p['stock'] ?? 0) as int;
    }

    double totalSales = 0.0;
    for (var b in billResponse) {
      totalSales += (b['total'] ?? 0).toDouble(); // <-- fixed here
    }

    state = DashboardState(
      totalProducts: productResponse.length,
      totalStock: totalStock,
      totalSales: totalSales,
      totalBills: billResponse.length,
    );
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardController, DashboardState>(
        (ref) => DashboardController());
