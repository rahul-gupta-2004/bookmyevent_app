import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/hive/hive.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

final myBox = HiveManager.myBox;

class _ProfileState extends State<Profile> {
  final user = myBox.get('CurUser');
  String str = "";
  // Map<String, dynamic> userData =user;
  late final TextEditingController email;
  late final TextEditingController pass;
  late final TextEditingController uname;

  final _formKey = GlobalKey<FormState>();
  //TODO should come from hive

  @override
  void dispose() {
    uname.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    email = TextEditingController(text: user['email']);
    pass = TextEditingController(text: user['password']);
    uname = TextEditingController(text: user['name']);
  }

  bool isReadOnly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(background_darkgrey),
      appBar: AppBar(
          backgroundColor: Color(background_darkgrey),
          title: Container(
            decoration: BoxDecoration(
                color: Color(golden_yellow),
                borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settings);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Color(background_darkgrey),
                )),
          )),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextButton(
                  onPressed: () {
                    isReadOnly = false;
                    print(isReadOnly);
                  },
                  child: Text(
                    textAlign: TextAlign.justify,
                    "Edit Profile",
                    style: TextStyle(
                      color: Color(text_dm_offwhite),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: CircleAvatar(
                  backgroundColor: Color(golden_yellow),
                  radius: 30,
                  child: Icon(
                    Icons.person_rounded,
                    color: Color(background_darkgrey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  readOnly: true,
                  initialValue: user['uid'].toString(),
                  decoration: InputDecoration(
                      labelText: 'UID',
                      labelStyle: TextStyle(color: Color(background_darkgrey)),
                      fillColor: Color(text_dm_offwhite),
                      filled: true),
                  cursorColor: Color(background_darkgrey),
                  style: TextStyle(color: Color(background_darkgrey)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  controller: uname,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color(background_darkgrey)),
                      fillColor: Color(text_dm_offwhite),
                      filled: true),
                  cursorColor: Color(background_darkgrey),
                  style: TextStyle(color: Color(background_darkgrey)),
                  onChanged: (str) => {
                    print("onChanged: " + str + " controller: " + uname.text)
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kindly enter correct username";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      labelText: 'Email ID',
                      labelStyle: TextStyle(color: Color(background_darkgrey)),
                      fillColor: Color(text_dm_offwhite),
                      filled: true),
                  cursorColor: Color(background_darkgrey),
                  style: TextStyle(color: Color(background_darkgrey)),
                  onChanged: (str) => {
                    print("onChanged: " + str + " controller: " + email.text)
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kindly enter correct username";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  controller: pass,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(background_darkgrey)),
                      fillColor: Color(text_dm_offwhite),
                      filled: true),
                  cursorColor: Color(background_darkgrey),
                  style: TextStyle(color: Color(background_darkgrey)),
                  onChanged: (str) => {
                    print("onChanged: " + str + " controller: " + pass.text)
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kindly enter correct username";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(golden_yellow),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool updated = await ApiRequester.updateUser({
                            'uid': user['uid'].toString(),
                            'email': email.text,
                            'password': pass.text,
                            'name': uname.text
                          });
                          if (updated) {
                            myBox.put(
                                'CurUser',
                                await ApiRequester.getUser(
                                    user['uid'].toString()));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Details updated')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Update failed :(')),
                            );
                          }
                        }
                      },
                      child: Text("Update Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(background_darkgrey))),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(golden_yellow),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextButton(
                        onPressed: () {
                          myBox.delete("CurUser");
                          myBox.delete("User");
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.loginPage, (route) => false);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(background_darkgrey)),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
