// ignore_for_file: prefer_const_constructors

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seproject/hive/hive.dart';
import 'package:seproject/other/api_calls.dart';
import 'signup.dart';
import 'package:http/http.dart';
import '../other/routes.dart';
import 'package:hive/hive.dart';
import 'package:seproject/other/color_palette.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController uidcontroller = TextEditingController();

  bool isButtonClicked = false;
  bool valid = false;
  bool isPwdVisible = false;
  bool signUp = false;
  bool forgotPwd = false;
  String errorMsg = "";

  final _formKey = GlobalKey<FormState>();

  Future<bool> checkData(String uid, String password) async {
    Response response = await post(Uri.http("localhost:3000", "users/login/"),
        body: {"uid": uid, "password": password});

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      print("Incorrect Password");
      valid = false;
    } else {
      print("Empty Password");
      valid = true;
    }
    return false;
  }

  final myBox = HiveManager.myBox;
  late dynamic user;

  @override
  void initState() {
    super.initState();
    ApiRequester.getAllOrganizers();
    autoFill();
  }

  autoFill() {
    final data = myBox.get('User');
    if (data != null) {
      uidcontroller.text = data[0];
      passwordController.text = data[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(background_darkgrey),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 30,
                            child: Icon(Icons.person_rounded,
                                size: 50, color: Colors.black)),

                        SizedBox(height: 20.0),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[50],
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          "Login to your existing account",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.amber[50],
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        // Uid Input
                        TextFormField(
                            controller: uidcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Uid field can't be empty";
                              }

                              if (value.length > 7) {
                                return "Please enter valid UID";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.amber[50],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                labelText: "Enter UID",
                                prefixIcon: Icon(Icons.person))),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password field can't be empty";
                            }
                            if (value.length <= 4) {
                              return "Password should have minimum 4 characters";
                            }
                            return null;
                          },
                          obscureText: isPwdVisible ? false : true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.amber[50],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17)),
                            labelText: "Enter Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPwdVisible = !isPwdVisible;
                                });
                              },
                              child: Icon(isPwdVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                        // SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // checkData(uidcontroller.text, passwordController.text);
                              Navigator.pushNamed(
                                  context, Routes.verifyAccount);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.amber[100]),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Material(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.amber,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                isButtonClicked = true;
                              });

                              if (_formKey.currentState!.validate()) {
                                valid = await checkData(uidcontroller.text,
                                    passwordController.text);

                                if (valid) {
                                  myBox.put('User', [
                                    uidcontroller.text,
                                    passwordController.text
                                  ]);
                                  if (myBox.get('CurUser') == null) {
                                    var parsed = uidcontroller.text;
                                    var temp =
                                        await ApiRequester.getUser(parsed);
                                    setState(() {
                                      user = temp;
                                    });
                                  }
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.navigator,
                                  );
                                } else {
                                  const snackBar = SnackBar(
                                      content: Text(
                                          'Incorrect username & password'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                uidcontroller.clear();
                                passwordController.clear();
                              }

                              setState(() {
                                isButtonClicked = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: 50.0,
                              width: valid ? 50.0 : 100.0,
                              alignment: Alignment.center,
                              child: valid
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : Text("Login",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Visibility(
                          visible: isButtonClicked,
                          child: Text(
                            valid
                                ? "${emailController.text} logging in..."
                                : errorMsg, // ERROR: error msg is null everytime
                            style: TextStyle(
                                color: valid ? Colors.green : Colors.red),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Are you an Organizer?",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.amber[50])),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.organizerLogin);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.amber[100]),
                              ),
                              // ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.amber[50])),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.signUp,
                                  );
                                });
                              },
                              child: Text("Create now",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.amber[100])),
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              visible: isButtonClicked && valid,
                              child: Text(
                                valid
                                    ? "Account created successfully "
                                    : "Incorrect username or password", // ERROR: error msg is null everytime
                                style: TextStyle(
                                    color: valid ? Colors.white : Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
