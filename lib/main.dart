//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//theme
import 'package:smart_retail_erp/app/theme/theme.dart';
import 'package:smart_retail_erp/app/theme/theme_provider.dart';
//supabase
import 'package:supabase_flutter/supabase_flutter.dart';

//pages
import 'package:smart_retail_erp/features/auth/login_page.dart';
import 'package:smart_retail_erp/features/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Supabase.initialize(
    url: 'https://ymqjygqltvgistrqgwhe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltcWp5Z3FsdHZnaXN0cnFnd2hlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgxNTMwNzYsImV4cCI6MjA2MzcyOTA3Nn0.hZ0d4pBZk5zKlbTry-MOfqb7mKATZe9S50eUS5NH5rg',
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Smart Retail ERP',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
