import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/enums/gender_enum.dart';
import 'package:todo_application/models/country.dart';
import 'package:todo_application/models/photo.dart';
import 'package:todo_application/models/search_result.dart';
import 'package:todo_application/providers/country_provider.dart';
import 'package:todo_application/providers/photo_provider.dart';
import 'package:todo_application/providers/user_provider.dart';
import 'package:todo_application/screens/profile/change_email.dart';
import 'package:todo_application/screens/profile/change_password.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/widgets/master_screen.dart';

import '../../utils/util_widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late CountryProvider _countryProvider = CountryProvider();
  late UserProvider _userProvider = UserProvider();
  late PhotoProvider _photoProvider = PhotoProvider();

  SearchResult<Country>? countryResult;
  String? photo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'firstName': Autentification.loggedUser?.firstName,
      'lastName': Autentification.loggedUser?.lastName,
      'biography': Autentification.loggedUser?.biography,
      'phoneNumber': Autentification.loggedUser?.phoneNumber,
      'email': Autentification.loggedUser?.email,
      'birthDate': Autentification.loggedUser?.birthDate,
      'lastTimeSignIn': Autentification.loggedUser?.lastTimeSignIn,
      'gender': Autentification.loggedUser?.gender?.index.toString(),
      'countryId': Autentification.loggedUser?.countryId.toString(),
    };

    _countryProvider = context.read<CountryProvider>();
    _userProvider = context.read<UserProvider>();
    _photoProvider = context.read<PhotoProvider>();
    initForm();
  }

  Future<void> initForm() async {
    countryResult = await _countryProvider.getPaged();
    if (Autentification.loggedUser != null &&
        Autentification.loggedUser!.profilePhotoId != null &&
        Autentification.loggedUser!.profilePhotoId! > 0) {
      Photo p = await _photoProvider
          .getById(Autentification.loggedUser!.profilePhotoId!);
      photo = p.data;
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Profile Settings',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 50),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  isLoading
                      ? const SpinKitRing(color: Colors.lightBlue)
                      : _buildForm(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (Autentification.loggedUser == null || isLoading)
                            ? Container()
                            : ElevatedButton(
                                onPressed: () async {
                                  _formKey.currentState?.save();

                                  try {
                                    if (_formKey.currentState!.validate()) {
                                      Map<String, dynamic> request =
                                          Map.of(_formKey.currentState!.value);

                                      request['id'] =
                                          Autentification.loggedUser?.id;
                                      request['role'] = Autentification
                                          .loggedUser?.role?.index;
                                      request['birthDate'] = dateEncode(_formKey
                                          .currentState?.value['birthDate']);

                                      if (_base64Image != null) {
                                        request['profilePhoto'] = _base64Image;
                                      }

                                      request['isActive'] =
                                          Autentification.loggedUser!.isActive;

                                      Autentification.loggedUser =
                                          await _userProvider.update(request);

                                      if (Autentification
                                              .loggedUser?.profilePhotoId !=
                                          null) {
                                        profilePhoto = await _photoProvider
                                            .getById(Autentification.loggedUser
                                                    ?.profilePhotoId ??
                                                0);
                                      }
                                      
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Profile is successsfully updated.')));

                                      Navigator.pop(context, 'getUser');
                                    }
                                  } on Exception catch (e) {
                                    alertBox(context, "Error", e.toString());
                                  }
                                },
                                child: Text(
                                  "Save",
                                  style: const TextStyle(fontSize: 17),
                                )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Column(
                    children: [
                      (photo == null)
                          ? Container()
                          : InkWell(
                              onTap: getimage,
                              child: Container(
                                  constraints: const BoxConstraints(
                                      maxHeight: 350, maxWidth: 350),
                                  child: imageFromBase64String(photo!)),
                            ),
                      photo == null
                          ? ElevatedButton(
                              onPressed: getimage, child: Text("Chose Image"))
                          : Container()
                    ],
                  ),
                )),
              )
            ],
          ),
          rowMethod(
            textField('firstName', "First Name"),
          ),
          const SizedBox(
            height: 25,
          ),
          rowMethod(textField('lastName', "Last Name")),
          const SizedBox(
            height: 25,
          ),
          rowMethod(Expanded(
              child: FormBuilderDateTimePicker(
            name: 'birthDate',
            validator: (value) {
              if (value == null) {
                return mfield;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(label: Text("Birth Date")),
          ))),
          const SizedBox(
            height: 25,
          ),
          rowMethod(textField('phoneNumber', 'Phone Number')),
          const SizedBox(
            height: 25,
          ),
          rowMethod(Expanded(
              child: FormBuilderTextField(
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
            name: 'email',
            readOnly: true,
            decoration: const InputDecoration(label: Text('Email (readonly)')),
          ))),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const ChangeEmailPage())));
                    }),
                    style: buttonStyleSecondary,
                    child: Text(
                      "New Email",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  ElevatedButton(
                      onPressed: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const ChangePasswordPage())));
                      }),
                      style: buttonStyleSecondary,
                      child: Text("New Password",
                          style: const TextStyle(fontSize: 13))),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          rowMethod(
            Expanded(
                child: FormBuilderDropdown<String>(
              name: 'gender',
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
                    _formKey.currentState!
                        .fields['gender'] //brisnje selekcije iz forme
                        ?.reset();
                  },
                ),
              ),
              items: Gender.values.map((Gender gender) {
                return DropdownMenuItem<String>(
                    value: gender.index.toString(),
                    child: Text(gender.toString().split('.').last));
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
              labelText: 'Country',
              suffix: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _formKey.currentState!.fields['countryId']?.reset();
                },
              ),
            ),
            items: countryResult?.items
                    .map((g) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: g.id.toString(),
                          child: Text(g.name ?? ''),
                        ))
                    .toList() ??
                [],
          ))),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Autentification.loggedUser == null
                  ? Expanded(
                      child: FormBuilderTextField(
                        name: 'password',
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
                    )
                  : Container(),
              Autentification.loggedUser == null
                  ? const SizedBox(
                      width: 80,
                    )
                  : Container(),
              Expanded(
                  child: FormBuilderTextField(
                name: 'biography',
                maxLines: 5,
                decoration: InputDecoration(label: Text('Biography')),
              )),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }

  Expanded textField(String name, String label) {
    return Expanded(
        child: FormBuilderTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return mfield;
        } else {
          return null;
        }
      },
      name: name,
      decoration: InputDecoration(label: Text(label)),
    ));
  }

  File? _image; //dart.io
  String? _base64Image;

  Future getimage() async {
    try {
      var result = await FilePicker.platform.pickFiles(
          type: FileType.image); //sam prepoznaj platformu u kjoj radi
      if (result != null && result.files.single.path != null) {
        _image = File(result
            .files.single.path!); //jer smo sa if provjerili pa je sigurn !
        _base64Image = base64Encode(_image!.readAsBytesSync());

        if (mounted) {
          setState(() {
            photo = _base64Image; //opet !
          });
        }
      }
    } on Exception catch (e) {
      alertBox(context, "Error", e.toString());
    }
  }
}
