class SalesData {
  final String date;
  final double total;

  SalesData({required this.date, required this.total});
}

class TopProductData {
  final String productName;
  final int quantitySold;

  TopProductData({required this.productName, required this.quantitySold});
}

class StockLevelData {
  final String productName;
  final int stock;

  StockLevelData({required this.productName, required this.stock});
}
class SalesDataPoint {
  final DateTime date;
  final double amount;

  SalesDataPoint({required this.date, required this.amount});
}
class TopProductAnalytics {
  final String productName;
  final int quantity;

  TopProductAnalytics({
    required this.productName,
    required this.quantity,
  });
}
