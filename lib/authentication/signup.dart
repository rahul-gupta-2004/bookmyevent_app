import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seproject/hive/hive.dart';
import 'package:seproject/other/color_palette.dart';
import '../other/routes.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final myBox = HiveManager.myBox;
  TextEditingController nameController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isButtonClicked = false;
  bool valid = false;
  bool isPwdVisible = false;
  bool isConfirmPwdVisible = false;

  final _formKey = GlobalKey<FormState>();

  Future<bool> validateData(String name, String email, String password,
      String uid, String phone) async {
    try {
      Response response =
          await post(Uri.http("localhost:3000", "users/signup"), body: {
        "name": name,
        "email": email,
        "password": password,
        "uid": uid,
        "phone": phone,
      });
      if (response.statusCode == 201) {
        print("User signed up successfully!");
        return true;
      } else {
        print("failure");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(background_darkgrey),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's get started!",
                        style: TextStyle(
                          color: Colors.amber[50],
                          fontWeight: FontWeight.bold,
                          // font
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        "Create an account to book tickets",
                        style: TextStyle(
                          color: Colors.amber[50],
                          fontWeight: FontWeight.w300,
                          fontSize: 20.0,
                        ),
                      ),

                      SizedBox(height: 30.0),
                      // name
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.amber[50],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17)),
                            labelText: "Enter Name",
                            prefixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(height: 20.0),
                      // email id
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email field can't be empty";
                          }
                          bool isEmailValid = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
                          ).hasMatch(value);

                          if (!isEmailValid) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.amber[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
                          labelText: "Enter Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Uid Input
                      TextFormField(
                          controller: uidController,
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
                      // Phone number
                      TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.amber[50],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17)),
                              labelText: "Enter Phone (optional)",
                              prefixIcon: Icon(Icons.phone))),
                      SizedBox(height: 20.0),
                      // password
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password field can't be empty";
                          }
                          if (value.length < 4) {
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
                      SizedBox(height: 15),
                      // confirm password
                      TextFormField(
                        obscureText: isConfirmPwdVisible ? false : true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Kindly confirm password";
                          } else if (passwordController.text != value) {
                            return "Password is not matching";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.amber[50],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isConfirmPwdVisible = !isConfirmPwdVisible;
                              });
                            },
                            child: Icon(isConfirmPwdVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),
                      Material(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xFFFFC107),
                        child: GestureDetector(
                          onTap: () async {
                            // saveUserDataLocally();
                            setState(() {
                              isButtonClicked = true;
                            });

                            if (_formKey.currentState!.validate()) {
                              valid = await validateData(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  uidController.text,
                                  phoneController.text);
                            }
                            await Future.delayed(Duration(seconds: 1));
                            if (valid) {
                              Navigator.pushNamed(context, Routes.verifyEmail,
                                  arguments: {
                                    'uid': uidController.text,
                                  });
                            } else {
                              const snackBar =
                                  SnackBar(content: Text('Kindly fill appropriate values'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            setState(() {
                              isButtonClicked = false;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              height: 50.0,
                              width: isButtonClicked ? 50.0 : 200.0,
                              alignment: Alignment.center,
                              child: isButtonClicked
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.black,
                                    )
                                  : Text("CREATE",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ))),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.amber[50])),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.loginPage);
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
                          Text("Are you an Organizer?",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.amber[50])),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.organizerLogin);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.amber[100]),
                            ),
                            // ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: valid,
                        child: Text(
                          valid
                              ? "Account created successfully "
                              : "Incorrect username or password", // ERROR: error msg is null everytime
                          style: TextStyle(
                              color: valid ? Colors.green : Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}
