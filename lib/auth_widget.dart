import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {

  final FirebaseAuth auth;
  AuthWidget({super.key, FirebaseAuth? auth}) : auth = auth ?? FirebaseAuth.instance;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();

}


class _AuthWidgetState extends State<AuthWidget> {
  bool _isLoginView = true;

  // Controllers for login
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Controllers for registration
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Simple login handling
    final email = _loginEmailController.text;
    final password = _loginPasswordController.text;

    print('Login attempt with: $email');
    try {
      final credential = await widget.auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleRegister() async {
    // Simple registration handling
    final email = _registerEmailController.text;
    final password = _registerPasswordController.text;
    final confirmPassword = _registerConfirmPasswordController.text;

    if (password != confirmPassword) {
      print('Passwrods do not match');
      return;
    }

    print('Registeration attempt with: $email');
    try {
      final credential = await widget.auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Toggle button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setState(() => _isLoginView = true),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: _isLoginView ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _isLoginView = false),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: _isLoginView ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            //show either login or register form
            _isLoginView ? _buildLoginForm() : _buildRegisterFrom(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _loginEmailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _loginPasswordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handleLogin,
          child: const Text('Login'),
        ),
      ],
    );
  }

  Widget _buildRegisterFrom() {
    return Column(
      children: [
        TextField(
          controller: _registerEmailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _registerPasswordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _registerConfirmPasswordController,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handleRegister,
          child: const Text('Register'),
        ),
      ],
    );
  }

}

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _handleLogout,
          child: const Text('Logout'),
        ),
      ],
    );
  }
}