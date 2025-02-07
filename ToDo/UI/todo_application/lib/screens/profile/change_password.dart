import 'package:provider/provider.dart';
import 'package:todo_application/providers/user_provider.dart';
import 'package:todo_application/screens/profile/login_page.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/widgets/master_screen.dart';

import '../../utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late UserProvider _userProvider = UserProvider();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Changing Password",
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(65, 80, 65, 50),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return mfield;
                      }
                      {
                        return null;
                      }
                    }),
                    name: 'password',
                    decoration: InputDecoration(
                        label: Text("Password")),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormBuilderTextField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return mfield;
                      } else if (value.length < 8 ||
                          !value.contains(RegExp(r'[A-Z]')) ||
                          !value.contains(RegExp(r'[a-z]')) ||
                          !value.contains(RegExp(r'[0-9]'))) {
                        return "Password has to contain at least 8 characters, lowercase and uppercase letters and numbers.";
                      } else {
                        return null;
                      }
                    }),
                    name: 'newPassword',
                    decoration: InputDecoration(
                        label: Text("New Password")),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormBuilderTextField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return mfield;
                      } else if (value !=
                          _formKey.currentState?.value['newPassword']) {
                        return "New password and confirm password don't match.";
                      } else {
                        return null;
                      }
                    }),
                    name: 'confirmPassword',
                    decoration: InputDecoration(
                        label: Text("Confirm password")),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                      onPressed: (() async {
                        _formKey.currentState?.save();
                        try {
                          if (_formKey.currentState!.validate()) {
                            var res = await _userProvider.changePassword({
                              'id': Autentification.tokenDecoded?['Id'],
                              'password':
                                  _formKey.currentState?.value['password'],
                              'newPassword':
                                  _formKey.currentState?.value['newPassword'],
                              'confirmNewPassword': _formKey
                                  .currentState?.value['confirmPassword']
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Password is successfully changed")));
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()),
                                (route) => false);
                          }
                        } catch (e) {
                          alertBox(context, "Error",
                              e.toString());
                        }
                       
                      }),
                      child: Text("Save"))
                ]),
          ),
        ),
      ),
    );
  }
}