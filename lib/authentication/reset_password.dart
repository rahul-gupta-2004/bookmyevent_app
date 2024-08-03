// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/hive/hive.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

final myBox = HiveManager.myBox;
final user = myBox.get('CurUser');

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmedController = TextEditingController();

  bool isPwdVisible = false;
  bool isConfirmPwdVisible = false;
  bool isButtonClicked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings?.arguments;
    return Material(
        color: Color(0xff181816),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set New Password",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffECFFD1)),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password field can't be empty";
                        }
                        if (value.length < 4) {
                          return "Password should have minimum 4 characters";
                        }
                      },
                      obscureText: isPwdVisible ? false : true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffECFFD1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
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
                    SizedBox(height: 20),
                    // confirm password
                    TextFormField(
                      obscureText: isConfirmPwdVisible ? false : true,
                      controller: confirmedController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Kindly confirm password";
                        } else if (passwordController.text != value) {
                          return "Password is not matching";
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffECFFD1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isConfirmPwdVisible = !isConfirmPwdVisible;
                                });
                              },
                              child: Icon(isConfirmPwdVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30.0),
                    Material(
                      borderRadius: BorderRadius.circular(35),
                      // color: Colors.deepPurple[700],
                      color: Color(0xffE1A730),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            isButtonClicked = true;
                          });

                          await Future.delayed(Duration(seconds: 2));
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmedController.text) {
                              print("sent");
                              Response resp = await put(
                                  Uri.http("localhost:3000", "users/"),
                                  body: {
                                    "uid": user['uid'],
                                    "password": passwordController.text
                                  });
                              if (resp.statusCode == 201) {
                                print("User updated");
                                await Navigator.pushNamed(
                                    context, Routes.loginPage);
                              } else {
                                print("UHoh");
                                //Show error, refresh page.
                              }
                            }
                          }

                          setState(() {
                            isButtonClicked = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50.0,
                          width: isButtonClicked ? 50.0 : 200.0,
                          alignment: Alignment.center,
                          child: isButtonClicked //&& valid
                              ? Icon(
                                  Icons.done,
                                  color: Colors.black,
                                )
                              : Text("CONFIRM",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  )),
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
