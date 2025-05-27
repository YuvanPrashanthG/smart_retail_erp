import 'package:flutter/material.dart';
import 'package:smart_retail_erp/features/product/product_list_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Retail ERP"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await supabase.auth.signOut();
            },
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text("Welcome to Smart Retail ERP"),
          TextButton(
            child: Text("View Products"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductListPage()),
            ),
          ),
        ],
      )),
    );
  }
}
