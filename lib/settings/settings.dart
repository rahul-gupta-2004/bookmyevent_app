import 'package:flutter/material.dart';
import 'package:seproject/other/routes.dart';
import 'package:seproject/other/color_palette.dart';
import 'package:seproject/hive/hive.dart';

void main() {
  runApp(const SettingsPage());
}

final myBox = HiveManager.myBox;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key,}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = myBox.get('CurUser');
  bool _isDarkMode = false;

  void _toggleTheme(bool newValue) {
    setState(() {
      _isDarkMode = newValue;
      print('Theme switched to: ${newValue ? 'Dark' : 'Light'}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: Color(background_darkgrey),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(golden_yellow),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.pushNamed(
                                context,
                                Routes.navigator,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(background_darkgrey),
                            )),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(text_dm_offwhite)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(text_dm_offwhite),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.userProfile);
                    },
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Color(golden_yellow),
                          foregroundColor: Color(background_darkgrey),
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'],
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(text_dm_offwhite)),
                            ),
                            Text(
                              user['uid'].toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Color(text_dm_offwhite)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // Implement action for forward button
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(text_dm_offwhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Divider(
                  //   height: 25,
                  //   thickness: 2,
                  //   indent: 0,
                  //   endIndent: 0,
                  //   color: Color(text_dm_offwhite),
                  // ),
                  // Text(
                  //   'Appearance',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(text_dm_offwhite),
                  //   ),
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     const Text(
                  //       'Change Theme',
                  //       style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite)),
                  //     ),
                  //     const Spacer(),
                  //     Switch(
                  //       inactiveThumbColor: Color(text_dm_offwhite),
                  //       inactiveTrackColor: Color(golden_yellow),
                  //       activeColor: Color(text_dm_offwhite),
                  //       activeTrackColor: Color(golden_yellow),
                  //       splashRadius: 0,
                  //       value: _isDarkMode,
                  //       onChanged: _toggleTheme,
                  //     ),
                  //   ],
                  // ),
                  // Divider(
                  //   height: 25,
                  //   thickness: 2,
                  //   indent: 0,
                  //   endIndent: 0,
                  //   color: Color(text_dm_offwhite),
                  // ),
                  const SizedBox(height: 24),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(text_dm_offwhite),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.aboutUs);
                      },
                      child: _buildSettingRow(Icons.info, 'About Us')),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.privacy);
                      },
                      child: _buildSettingRow(Icons.lock, 'Privacy Policy')),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        
                        Navigator.pushNamed(context, Routes.termsConditons);
                      },
                      child: _buildSettingRow(
                          Icons.description, 'Terms and Conditions')),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.helpCenter);
                      },
                      child: _buildSettingRow(Icons.help, 'Help Center')),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSettingRow(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Color(golden_yellow),
          foregroundColor: Color(background_darkgrey),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Color(text_dm_offwhite)),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Implement action for forward button
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Color(text_dm_offwhite),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}
