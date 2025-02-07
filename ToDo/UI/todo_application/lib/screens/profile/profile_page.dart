import 'package:flutter/material.dart';
import 'package:todo_application/screens/profile/login_page.dart';
import 'package:todo_application/screens/profile/profile_list_tile.dart';
import 'package:todo_application/screens/profile/profile_settings.dart';
import 'package:todo_application/utils/util.dart';
import 'package:todo_application/utils/util_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF2F2F2),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/profile_background.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              /// Content
              Column(
                children: [
                  AppBar(
                    title: const Text('Profile'),
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    titleTextStyle:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Autentification.loggedUser?.profilePhotoId != null &&
                                Autentification.loggedUser!.profilePhotoId! > 0
                            ? SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipOval(
                                  child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: profilePhoto != null
                                          ? imageFromBase64String(
                                              profilePhoto?.data ?? '')
                                          : Placeholder()),
                                ))
                            : const SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipOval(
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${Autentification.loggedUser?.firstName ?? "First Name"} ${Autentification.loggedUser?.lastName ?? "Last Name"}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Age: ${Autentification.loggedUser?.birthDate != null ? calculateAge(Autentification.loggedUser!.birthDate!) : "Unknown"} years old',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                  color: Colors.black.withOpacity(0.04),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ProfileListTile(
                    title: 'My Profile',
                    icon: Icon(Icons.person),
                    onTap: () async {
                      var refresh = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ProfileSettings();
                      }));

                      if (refresh == 'getUser') {
                        setState(() {});
                      }
                    }),
                const Divider(thickness: 0.1),
                ProfileListTile(
                    title: 'Logout',
                    icon: Icon(Icons.logout),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Log out"),
                                content:
                                    Text("Do you want to log out from app?"),
                                actions: [
                                  TextButton(
                                      onPressed: (() {
                                        Navigator.pop(context);
                                      }),
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () async {
                                        try {
                                          Autentification.token = '';
                                          Autentification.tokenDecoded = null;
                                          Autentification.loggedUser = null;

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LoginPage()),
                                              (route) => false);
                                        } catch (e) {
                                          alertBoxMoveBack(
                                              context, "Error", e.toString());
                                        }
                                      },
                                      child: const Text('Ok')),
                                ],
                              ));
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

