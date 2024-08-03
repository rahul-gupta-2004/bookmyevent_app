// ignore_for_file: prefer_const_constructors
// ignore: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:seproject/other/routes.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController uidController = TextEditingController();
    TextEditingController otpController = TextEditingController();
    bool isEmailSent = false;
    final _formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState<String>> _pincodekey =
        GlobalKey<FormFieldState<String>>();

    return Material(
      color: Color(0xff181816),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Verfication",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffECFFD1)),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: uidController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffECFFD1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        labelText: "Enter UID",
                        hintText: "Enter your UID:",
                        prefixIcon: Icon(Icons.perm_identity),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffE1A730),
                            foregroundColor: Colors.black),
                        onPressed: () async {
                          print("request for otp...");
                          Response resp = await get(Uri.http("localhost:3000",
                              "users/newotp/${int.parse(uidController.text)}"));
                          if (resp.statusCode == 200) {
                            print("OTP sent");
                          } else {
                            print("uhoh");
                          }
                        },
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text("Enter the given OTP below",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffECFFD1),
                        )),
                    SizedBox(
                      height: 5.0,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      controller: otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textStyle: TextStyle(color: Colors.white),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50.0,
                          fieldWidth: 50.0,
                          activeColor: Colors.green,
                          activeFillColor: Colors.red,
                          fieldOuterPadding:
                              EdgeInsets.symmetric(horizontal: 7.0)),
                      onCompleted: (pin) async {
                        Response response = await post(
                            Uri.http("localhost:3000", "users/otpcheck"),
                            body: {
                              "uid": uidController.text,
                              "otp": pin.toString()
                            });
                        if (response.statusCode == 200) {
                          print("OTP Validated");
                          Navigator.pushNamed(context, Routes.resetPassword,
                              arguments: {"uid": uidController.text});
                        } else if (response.statusCode == 401) {
                          print("Incorrect OTP");
                        } else {
                          print("OTP expired!");
                        }
                      },
                      onChanged: (value) {
                        // every time the value changes
                        print("changed: $value");
                      },
                      key: _pincodekey,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't recieve OTP?",
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
                          child: InkWell(
                            onTap: () {},
                            child: Text("Resend Again",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.amber[100],
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
