import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../home_page.dart'; // Importa HomePage desde el nivel superior

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = _isLoading ? 3.0 : 1.0; // Slow down the animation when loading
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'CultivaSmart', // Título sobre el logo
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/logologologo.png',
                    height: 150, // Ajusta la altura del logo aquí
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su nombre de usuario';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Ingresar'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
