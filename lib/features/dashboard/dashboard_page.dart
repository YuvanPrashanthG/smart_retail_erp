import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
            tooltip: "Refresh Data",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildStatCard("Total Products", "120", Icons.shopping_bag, theme),
                _buildStatCard("Total Sales", "\$8,750", Icons.attach_money, theme),
                _buildStatCard("Total Users", "340", Icons.people, theme),
              ],
            ),
            const SizedBox(height: 24),
            Text("Recent Activities", style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildActivity("🛒 New product added: iPhone 15"),
            _buildActivity("👤 User John registered"),
            _buildActivity("✅ Sale completed: Order #12345"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, ThemeData theme) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: theme.colorScheme.primary),
          const SizedBox(height: 10),
          Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActivity(String message) {
    return ListTile(
      leading: const Icon(Icons.arrow_right),
      title: Text(message),
    );
  }
}
