import 'package:flutter/material.dart';
import 'package:optima/screens/dashboard_screen.dart';

void main() {
  runApp(const InventoryApp());
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key}); // ✅ Fixed 'key' parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key}); // ✅ Fixed 'key' parameter

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void submitForm() {
  if (_formKey.currentState!.validate()) {
    debugPrint("Email: ${emailController.text}");
    debugPrint("Password: ${passwordController.text}");

    // ✅ Navigate to Dashboard on successful login/signup
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "Login" : "Sign Up",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text(isLogin ? "Login" : "Sign Up"),
                    ),
                    TextButton(
                      onPressed: toggleAuthMode,
                      child: Text(
                        isLogin ? "Don't have an account? Sign Up" : "Already have an account? Login",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
