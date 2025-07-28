import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_retail_erp/features/analytics/analytics_providers.dart';

class SalesOverTimeChart extends ConsumerWidget {
  const SalesOverTimeChart({super.key});

  // Format currency (e.g., ₹10K, ₹2.5M)
  String formatCurrency(double value) {
    if (value >= 1000000) {
      return '₹${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '₹${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return '₹${value.toStringAsFixed(0)}';
    }
  }

  // Dynamic interval for left axis
  double calculateInterval(List data) {
    final maxVal = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    if (maxVal > 1000000) return 200000;
    if (maxVal > 100000) return 50000;
    if (maxVal > 10000) return 10000;
    if (maxVal > 1000) return 2000;
    return 500;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesDataAsync = ref.watch(salesOverTimeProvider);
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: salesDataAsync.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(child: Text("No sales data available"));
            }

            final spots = List.generate(
              data.length,
              (i) => FlSpot(i.toDouble(), data[i].amount),
            );

            final dateLabels = data.map((e) => DateFormat('MM/dd').format(e.date)).toList();
            final maxY = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.show_chart, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Sales Over Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "This chart shows how total sales have changed over time.",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.black87,
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final index = spot.x.toInt();
                              final date = dateLabels[index];
                              final amount = formatCurrency(spot.y);
                              return LineTooltipItem(
                                "$date\n$amount",
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, _) {
                              final index = value.toInt();
                              if (index >= dateLabels.length) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  dateLabels[index],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: calculateInterval(data),
                            reservedSize: 48,
                            getTitlesWidget: (value, _) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  formatCurrency(value),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(color: Colors.grey),
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: theme.colorScheme.primary,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: theme.colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                      ],
                      minY: 0,
                      maxY: maxY + (maxY * 0.2), // Add 20% headroom
                    ),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
        ),
      ),
    );
  }
}
