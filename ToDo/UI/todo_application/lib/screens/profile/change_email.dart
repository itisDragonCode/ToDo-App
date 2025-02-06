import 'package:todo_application/providers/user_provider.dart';
import 'package:todo_application/screens/profile/login_page.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';
import 'package:todo_application/widgets/master_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';


class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  late UserProvider _userProvider = UserProvider();
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'currentEmail': Autentification.tokenDecoded?['Email'],
    };
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: "Changin Email",
        child: SingleChildScrollView(
          
            child: FormBuilder(
              key: _formKey,
              initialValue: _initialValue,
              child:Padding(
                    padding: const EdgeInsets.fromLTRB(65, 80, 65, 50),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormBuilderTextField(
                            name: 'currentEmail',
                            readOnly: true,
                            decoration:  InputDecoration(
                                label: Text("Current Email")),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormBuilderTextField(
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return mfield;
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Invalid email";
                              } else {
                                return null;
                              }
                            }),
                            name: 'newEmail',
                            decoration:
                                InputDecoration(label: Text("New Email")),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          ElevatedButton(
                              onPressed: (() async {
                                _formKey.currentState?.save();
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    var res = await _userProvider.changeEmail(
                                        int.parse(Autentification
                                            .tokenDecoded?['Id']),
                                        _formKey
                                            .currentState?.value['newEmail']);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                            content: Text(
                                                "Email is successfully changed")));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const LoginPage()),
                                        (route) => false);
                                  }
                                } catch (e) {
                                  alertBox(context, "Error", e.toString());
                                }
                              
                               
                              }),
                              child:  Text("Save"))
                        ]),
                  ),
              
            ),
         
        ));
  }
}