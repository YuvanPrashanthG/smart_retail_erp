import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/sales_over_time_chart.dart';
import '../widgets/top_products_chart.dart';

class AnalyticsDashboardPage extends ConsumerWidget {
  const AnalyticsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SalesOverTimeChart(),
            SizedBox(height: 20),
            TopProductsChart(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
