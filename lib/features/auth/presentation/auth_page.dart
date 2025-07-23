import 'package:cinehive_mobile/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoginMode = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).clearError();
    });
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _confirmPasswordController.clear();
      ref.read(authProvider.notifier).clearError();
    });
  }

  void _submitForm() {
    ref.read(authProvider.notifier).clearError();

    if (_isLoginMode) {
      ref.read(authProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } else {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Passwords do not match'),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }
      
      ref.read(authProvider.notifier).signup(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );
    }
  }

  // ...existing code...
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 
                 MediaQuery.of(context).padding.top - 
                 MediaQuery.of(context).padding.bottom,
          child: Column(
            children: [
              // Logo in alto
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Image.asset(
                  'assets/images/logo-no-bg.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              
              // Form container
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Titolo
                      Text(
                        _isLoginMode ? 'Welcome Back' : 'Create Account',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isLoginMode 
                          ? 'Sign in to continue'
                          : 'Join CineHive today',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),

                      ..._buildFormFields(),

                      const SizedBox(height: 24),

                      // Submit Button con loading state
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: authState.isAuthenticating ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: authState.isAuthenticating 
                                ? Colors.grey[600] 
                                : Colors.pink,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: authState.isAuthenticating
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  _isLoginMode ? 'Sign In' : 'Sign Up',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      // Error display
                      if (authState.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Colors.red, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    authState.error!.replaceAll('Exception: ', ''),
                                    style: const TextStyle(color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 40), 
                    ],
                  ),
                ),
              ),

              // Toggle auth mode
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLoginMode 
                        ? "Don't have an account? "
                        : "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: authState.isAuthenticating ? null : _toggleAuthMode,
                      child: Text(
                        _isLoginMode ? 'Sign Up' : 'Sign In',
                        style: TextStyle(
                          color: authState.isAuthenticating ? Colors.grey : Colors.pink,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final authState = ref.watch(authProvider);
    
    return [
      if (!_isLoginMode) ...[
        TextField(
          controller: _nameController,
          enabled: !authState.isAuthenticating,
          style: TextStyle(
            color: authState.isAuthenticating ? Colors.grey : Colors.white,
          ),
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(
              color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
            ),
            prefixIcon: Icon(
              Icons.person_outline, 
              color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: authState.isAuthenticating 
                    ? Colors.grey[600]!.withAlpha(100)
                    : Colors.purple[200]!.withAlpha(100),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: authState.isAuthenticating 
                    ? Colors.grey[600]!.withAlpha(100)
                    : Colors.pink[300]!.withAlpha(100),
              ),
            ),
            filled: true,
            fillColor: authState.isAuthenticating 
                ? Colors.grey[800]?.withAlpha(50)
                : Colors.purple[200]?.withAlpha(50),
          ),
        ),
        const SizedBox(height: 16),
      ],

      TextField(
        controller: _emailController,
        enabled: !authState.isAuthenticating,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: authState.isAuthenticating ? Colors.grey : Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.email_outlined, 
            color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: authState.isAuthenticating 
                  ? Colors.grey[600]!.withAlpha(100)
                  : Colors.purple[200]!.withAlpha(100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: authState.isAuthenticating 
                  ? Colors.grey[600]!.withAlpha(100)
                  : Colors.pink[300]!.withAlpha(100),
            ),
          ),
          filled: true,
          fillColor: authState.isAuthenticating 
              ? Colors.grey[800]?.withAlpha(50)
              : Colors.purple[200]?.withAlpha(50),
        ),
      ),
      const SizedBox(height: 16),

      TextField(
        controller: _passwordController,
        enabled: !authState.isAuthenticating,
        obscureText: true,
        style: TextStyle(
          color: authState.isAuthenticating ? Colors.grey : Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.lock_outline, 
            color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: authState.isAuthenticating 
                  ? Colors.grey[600]!.withAlpha(100)
                  : Colors.purple[200]!.withAlpha(100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: authState.isAuthenticating 
                  ? Colors.grey[600]!.withAlpha(100)
                  : Colors.pink[300]!.withAlpha(100),
            ),
          ),
          filled: true,
          fillColor: authState.isAuthenticating 
              ? Colors.grey[800]?.withAlpha(50)
              : Colors.purple[200]?.withAlpha(50),
        ),
      ),

      if (!_isLoginMode) ...[
        const SizedBox(height: 16),
        TextField(
          controller: _confirmPasswordController,
          enabled: !authState.isAuthenticating,
          obscureText: true,
          style: TextStyle(
            color: authState.isAuthenticating ? Colors.grey : Colors.white,
          ),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
              color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
            ),
            prefixIcon: Icon(
              Icons.lock_outline, 
              color: authState.isAuthenticating ? Colors.grey[600] : Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: authState.isAuthenticating 
                    ? Colors.grey[600]!.withAlpha(100)
                    : Colors.purple[200]!.withAlpha(100),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: authState.isAuthenticating 
                    ? Colors.grey[600]!.withAlpha(100)
                    : Colors.pink[300]!.withAlpha(100),
              ),
            ),
            filled: true,
            fillColor: authState.isAuthenticating 
                ? Colors.grey[800]?.withAlpha(50)
                : Colors.purple[200]?.withAlpha(50),
          ),
        ),
      ],
    ];
  }
// ...existing code...
}