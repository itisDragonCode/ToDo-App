import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/enums/gender_enum.dart';
import 'package:todo_application/enums/role_enum.dart';
import 'package:todo_application/models/country.dart';
import 'package:todo_application/models/search_result.dart';
import 'package:todo_application/providers/country_provider.dart';
import 'package:todo_application/providers/sign_provider.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CountryProvider _countryProvider = CountryProvider();
  late SignProvider _signProvider = SignProvider();

  SearchResult<Country>? countryResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _countryProvider = context.read<CountryProvider>();
    _signProvider = context.read<SignProvider>();

    intiForm();
  }

  Future<void> intiForm() async {
    try {
      countryResult = await _countryProvider.getPaged();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBoxMoveBack(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up"), centerTitle: true),
      body: isLoading
          ? const SpinKitRing(color: Colors.brown)
          : SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          rowMethod(_textField('firstName', "First Name")),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(_textField('lastName', "Last Name")),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'email',
                                validator: ((value) {
                                  if (value == null || value.isEmpty) {
                                    return mfield;
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    "Invalid email";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: const InputDecoration(
                                  label: Text('Email'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(_textField('phoneNumber', "Phone number")),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'password',
                                obscureText: true,
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
                                decoration: InputDecoration(
                                  label: Text("Password"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(
                            Expanded(
                                child: FormBuilderDateTimePicker(
                              name: 'birthDate',
                              validator: (value) {
                                if (value == null) {
                                  return mfield;
                                } else {
                                  return null;
                                }
                              },
                              decoration:
                                  InputDecoration(label: Text("Birth Date")),
                            )),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(
                            Expanded(
                                child: FormBuilderDropdown<String>(
                              name: 'genderId',
                              validator: (value) {
                                if (value == null) {
                                  return mfield;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Gender",
                                suffix: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _formKey
                                        .currentState!
                                        .fields[
                                            'genderId'] //brisnje selekcije iz forme
                                        ?.reset();
                                  },
                                ),
                              ),
                              items: Gender.values.map((Gender gender) {
                                return DropdownMenuItem<String>(
                                    value: gender.toString(),
                                    child: Text(gender.toString()));
                              }).toList(),
                            )),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          rowMethod(Expanded(
                              child: FormBuilderDropdown<String>(
                            name: 'countryId',
                            validator: (value) {
                              if (value == null) {
                                return mfield;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Country",
                              suffix: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _formKey
                                      .currentState!
                                      .fields[
                                          'countryId'] //brisnje selekcije iz forme
                                      ?.reset();
                                },
                              ),
                            ),
                            items: countryResult?.items
                                    .map((g) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.center,
                                          value: g.id.toString(),
                                          child: Text(g.name ?? ''),
                                        ))
                                    .toList() ??
                                [],
                          ))),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      _formKey.currentState?.save();
                                      if (_formKey.currentState!.validate()) {
                                        Map<String, dynamic> request = Map.of(
                                            _formKey.currentState!.value);

                                        request['birthDate'] = dateEncode(
                                            _formKey.currentState
                                                ?.value['birthDate']);

                                        request['isActive'] = true;

                                        request['role'] = Role.user;

                                        await _signProvider.signUp(request);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Successsfully signed up")));

                                        Navigator.pop(context);
                                      } else {}
                                    } catch (e) {
                                      alertBox(context, "Error", e.toString());
                                    }
                                  },
                                  child: Text("Sign Up"))
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Expanded _textField(String name, String label) {
    return Expanded(
      child: FormBuilderTextField(
        name: name,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return mfield;
          } else {
            return null;
          }
        }),
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }
}
