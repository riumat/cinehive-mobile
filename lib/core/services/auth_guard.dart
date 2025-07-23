import 'package:cinehive_mobile/features/auth/presentation/auth_page.dart';
import 'package:cinehive_mobile/features/auth/providers/auth_provider.dart';
import 'package:cinehive_mobile/core/layout/main_layout.dart';
import 'package:cinehive_mobile/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends ConsumerStatefulWidget {
  const AuthGuard({super.key});

  @override
  ConsumerState<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends ConsumerState<AuthGuard> {
  bool _hasShownSessionExpired = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted) return; 

      if (previous?.isLoggedIn == true && 
          next.isLoggedIn == false && 
          !next.isManualLogout && 
          !_hasShownSessionExpired) {
        
        _hasShownSessionExpired = true;
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSessionExpiredSnackBar();
          }
        });
      }

      if (next.isLoggedIn && _hasShownSessionExpired) {
        _hasShownSessionExpired = false;
      }
    });

    if (authState.isInitializing) {
      return _buildLoadingScreen();
    }

    if (authState.isLoggedIn) {
      return const MainLayout(
        body: HomePage(),
      );
    }

    return const AuthPage();
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.purple,
                strokeWidth: 3,
              ),
              const SizedBox(height: 24),
              const Text(
                'Waking up Cinehive...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Cinehive is a cold start web service, this may take up to a minute.',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSessionExpiredSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Session expired. Please log in again.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange[700],
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hasShownSessionExpired = false;
    super.dispose();
  }
}