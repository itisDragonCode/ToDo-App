import 'package:todo_application/providers/sign_provider.dart';
import 'package:todo_application/providers/user_provider.dart';
import 'package:todo_application/screens/todo_list_screen.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignProvider _signProvider = SignProvider();
  late UserProvider _userProvider = UserProvider();

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signProvider = context.read<SignProvider>();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'To Do',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 45,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      label: Text("Email"), icon: Icon(Icons.mail)),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      label: Text("Password"),
                      icon: const Icon(Icons.password)),
                ),
                const SizedBox(
                  height: 40,
                ),
                isLoading
                    ? const SpinKitRing(color: Colors.brown)
                    : ElevatedButton(
                        onPressed: () async {
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }

                          var email = _emailController.text;
                          var password = _passwordController.text;

                          try {
                            var data =
                                await _signProvider.signIn(email, password);
                            var token = data['token'];
                            Autentification.token = token;
                            Autentification.tokenDecoded =
                                JwtDecoder.decode(token);

                            if (Autentification.tokenDecoded?['Role'] !=
                                'User') {
                              alertBox(context, "Error",
                                  "Admin is not allowed to use mobile application");
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {
                              int userId = int.parse(
                                  Autentification.tokenDecoded!['Id']);
                              loggedUser = await _userProvider.getById(userId);

                              print(loggedUser);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const TodoListScreen();
                              }));

                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          } catch (e) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              if (mounted) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    ));
                          }
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 18),
                        )),
                const SizedBox(
                  height: 15,
                ),
                isLoading == true
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Profile",
                              style: const TextStyle(fontSize: 17)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
