import 'package:flutter/material.dart';
import 'package:smart_retail_erp/core/widgets/sidebar.dart';
import 'package:smart_retail_erp/features/product/product_list_page.dart';
import 'package:smart_retail_erp/features/dashboard/dashboard_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  int _selectedIndex = 0;

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return const ProductListPage();
      case 2:
        return const Center(child: Text("Store Page (Coming Soon)"));
      case 3:
        return const Center(child: Text("Visitor Page (Coming Soon)"));
      case 4:
        return const Center(child: Text("Analytics Page (Coming Soon)"));
      case 5:
        return const Center(child: Text("Notifications Page (Coming Soon)"));
      case 6:
        return const Center(child: Text("Help Center Page (Coming Soon)"));
      case 7:
        return const Center(child: Text("Settings Page (Coming Soon)"));
      default:
        return const Center(child: Text("Unknown Page"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Retail ERP"),
        leading: isSmallScreen
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await supabase.auth.signOut();
            },
          )
        ],
      ),
      drawer: isSmallScreen
          ? Drawer(
              child: Sidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isSmallScreen)
            Sidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          Expanded(child: _getSelectedPage(_selectedIndex)),
        ],
      ),
    );
  }
}
