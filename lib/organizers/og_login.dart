import 'package:flutter/material.dart';
import 'package:seproject/other/api_calls.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/hive/hive.dart';

var org;

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key? key}) : super(key: key);

  @override
  State<OrganizerLogin> createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isButtonClicked = false;
  bool valid = false;
  bool isPwdVisible = false;
  bool signUp = false;
  bool forgotPwd = false;
  String errorMsg = "";
  final _formKey = GlobalKey<FormState>();
  final myBox = HiveManager.myBox;

  @override
  void initState() {
    super.initState();
    callOrg();
    autofill();
  }

  callOrg() async {
    await ApiRequester.getAllOrganizers();
  }

  autofill() {
    var data = myBox.get("Org");
    if (data != null) {
      emailController.text = data[0];
      passwordController.text = data[1];
    }
  }

  findOrg() async {
    var data = myBox.get('OrgAll');
    var orgEmail = myBox.get("Org")[0];
    // print(data + "\n" + orgEmail);
    for (var i = 0; i < data.length; i++) {
      var temp = data[i];
      if (temp['orgEmail'] == orgEmail) {
        await myBox.put("CurrentOrg", temp);
        org = temp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
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
                          "Organizer Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[50],
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          "Sign in to your admin account",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.amber[50],
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        // Uid Input
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

                              // await Future.delayed(Duration(seconds: 2));
                              if (_formKey.currentState!.validate()) {
                                bool valid =
                                    await ApiRequester.validateOrganizers(
                                        emailController.text,
                                        passwordController.text);
                                if (valid) {
                                  myBox.put('Org', [
                                    emailController.text,
                                    passwordController.text
                                  ]);
                                  await findOrg();
                                  Navigator.pushNamed(
                                    context,
                                    Routes.organizerHome,
                                  );
                                } else {
                                  emailController.clear();
                                  passwordController.clear();
                                }

                                setState(() {
                                  isButtonClicked = false;
                                });
                              }
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
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[50],
                              fontSize: 30.0,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
