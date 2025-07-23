import 'package:cinehive_mobile/features/auth/models/auth.dart';
import 'package:cinehive_mobile/features/auth/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  final User? user;
  final bool isInitializing; // Solo per il check iniziale
  final bool isAuthenticating; // Solo per login/signup
  final String? error;
  final bool isManualLogout;

  AuthState({
    this.isLoggedIn = false,
    this.user,
    this.isInitializing = false,
    this.isAuthenticating = false,
    this.error,
    this.isManualLogout = false,
  });

  // Mantieni backward compatibility
  bool get isLoading => isInitializing;
 
  AuthState copyWith({
    bool? isLoggedIn,
    User? user,
    bool? isInitializing,
    bool? isAuthenticating,
    String? error,
    bool? isManualLogout,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isInitializing: isInitializing ?? this.isInitializing,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      error: error ?? this.error,
      isManualLogout: isManualLogout ?? this.isManualLogout,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isInitializing: true, error: null);
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      state = state.copyWith(
        isLoggedIn: isLoggedIn, 
        isInitializing: false,
        isManualLogout: false,
      );
    } catch (e) {
      state = state.copyWith(
        isInitializing: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isAuthenticating: true, error: null, isManualLogout: false);
    
    try {
      final authResponse = await AuthService.login(
        LoginRequest(email: email, password: password),
      );
      
      state = state.copyWith(
        isLoggedIn: true,
        user: authResponse.user,
        isAuthenticating: false,
        error: null,
        isManualLogout: false,
      );
    } catch (e) {
      state = state.copyWith(
        isAuthenticating: false,
        error: e.toString().replaceAll('Exception: ', ''),
        isManualLogout: false,
      );
    }
  }

  Future<void> signup(String email, String password, String username) async {
    state = state.copyWith(isAuthenticating: true, error: null, isManualLogout: false);
    
    try {
      final authResponse = await AuthService.signup(
        SignupRequest(email: email, password: password, username: username),
      );
      
      state = state.copyWith(
        isLoggedIn: true,
        user: authResponse.user,
        isAuthenticating: false,
        error: null,
        isManualLogout: false,
      );
    } catch (e) {
      state = state.copyWith(
        isAuthenticating: false,
        error: e.toString().replaceAll('Exception: ', ''),
        isManualLogout: false,
      );
    }
  }

  Future<void> logout() async {
    try {
      await AuthService.logout();
      
      state = AuthState(
        isLoggedIn: false,
        user: null,
        isInitializing: false,
        isAuthenticating: false,
        error: null,
        isManualLogout: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceAll('Exception: ', ''),
        isManualLogout: false,
      );
      rethrow;
    }
  }

  Future<void> sessionExpired() async {
    await AuthService.logout();
    
    state = AuthState(
      isLoggedIn: false,
      user: null,
      isInitializing: false,
      isAuthenticating: false,
      error: null,
      isManualLogout: false,
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});