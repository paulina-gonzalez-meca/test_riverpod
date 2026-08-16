import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_riverpod/providers/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userInput = "";
  String passwordInput = "";
  String notification = "";

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Read the users from Riverpod
    final myUsers = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Ingresar tu usuario y contraseña",
              style: TextStyle(fontSize: 24, color: Color.fromRGBO(100, 150, 200, 1)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(hintText: "Usuario"),
              keyboardType: TextInputType.emailAddress,
              controller: userController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(hintText: "Contraseña"),
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userInput = userController.text;
                  passwordInput = passwordController.text;

                  if (myUsers.any((user) => user.email == userInput && user.password == passwordInput)) {
                    context.go('/results');
                  } else {
                    if (userInput.isEmpty || passwordInput.isEmpty) {
                      notification = "Usuario o contraseña vacíos";
                    } else if (!userInput.contains("@")) {
                      notification = "El usuario no contiene @";
                    } else if (userInput.length < 3 || passwordInput.length < 3) {
                      notification = "El usuario y contraseña deben tener como mínimo 3 caracteres";
                    } else {
                      notification = "Usuario o contraseña incorrectos";
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(notification),
                        action: SnackBarAction(label: "Cerrar", onPressed: () {}),
                      ),
                    );
                  }
                });
              },
              child: const Text('Enter'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push('/register'),
              child: const Text('Registrar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}