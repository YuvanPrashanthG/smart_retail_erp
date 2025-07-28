import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockLevelsChart extends StatelessWidget {
  final List<String> productNames;
  final List<int> stockLevels;

  const StockLevelsChart({
    super.key,
    required this.productNames,
    required this.stockLevels,
  });

  @override
  Widget build(BuildContext context) {
    if (productNames.isEmpty || stockLevels.isEmpty || productNames.length != stockLevels.length) {
      return const Center(child: Text("No stock data available"));
    }

    final theme = Theme.of(context);
    final barGroups = List.generate(productNames.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: stockLevels[i].toDouble(),
            color: Colors.teal,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Stock Levels", style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < 0 || index >= productNames.length) return const Text("");
                          return Text(
                            productNames[index],
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
