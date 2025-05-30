import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authControllerProvider = NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);

class AuthController extends Notifier<AsyncValue<void>> {
  final supabase = Supabase.instance.client;

  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> register({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      await supabase.auth.signUp(email: email.trim(), password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      await supabase.auth.signInWithPassword(email: email.trim(), password: password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
