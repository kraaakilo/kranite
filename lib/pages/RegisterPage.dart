import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/TransparentAppBar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/fortnite.png"),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Create an account",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (email) {
                      if (email != null) {
                        var regex = RegExp(r'^[A-Za-z0-9]{2,}@[a-z]+.[a-z]{2,9}$')
                            .stringMatch(email);
                        if (regex == null) {
                          return "Invalid email address";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Fill with your e-mail",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (password) {
                      if (password == null || password.length < 8) {
                        return "Weak password provided";
                      }
                      return null;
                    },
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Create your password",
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          _obscurePassword = !_obscurePassword;
                        }),
                        child: _obscurePassword
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _passwordConfirmController,
                    validator: (password) {
                      if (password == null || password.length < 8) {
                        return "Weak password provided";
                      }
                      if (_passwordController.text !=
                          _passwordConfirmController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Create your password",
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          _obscurePassword = !_obscurePassword;
                        }),
                        child: _obscurePassword
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Your account was successfully created : ${user.user!.email}")));
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.code)));
                        }
                        // _formKey.currentState!.reset();
                      }
                    },
                    child: Text("Register"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
