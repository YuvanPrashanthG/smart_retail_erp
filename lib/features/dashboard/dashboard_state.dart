class DashboardState {
  final int totalProducts;
  final int totalStock;
  final double totalSales;
  final int totalBills;

  DashboardState({
    required this.totalProducts,
    required this.totalStock,
    required this.totalSales,
    required this.totalBills,
  });

  factory DashboardState.initial() => DashboardState(
        totalProducts: 0,
        totalStock: 0,
        totalSales: 0.0,
        totalBills: 0,
      );
}
