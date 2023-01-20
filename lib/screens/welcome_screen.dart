import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome-screen';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    bool _validName = false;
    bool? isChecked = true;
    var _phoneNumberController = TextEditingController();
    var _nameController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (context) => StatefulBuilder(
                builder: (context, StateSetter mysetter) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: auth.error == 'Invalid Otp' ? true : false,
                            child: Container(
                              child: Column(children: [
                                Text(auth.error),
                                const SizedBox(
                                  height: 3,
                                ),
                              ]),
                            ),
                          ),
                          const Text("Login"),
                          const Text("Enter Your Phone Number To Process"),
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                prefixText: '+91',
                                labelText: '10 digits Mobile Number'),
                            // autofocus: true,
                            maxLength: 10,
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              if (value.length == 10) {
                                mysetter(
                                  () {
                                    _validPhoneNumber = true;
                                  },
                                );
                              } else {
                                mysetter(
                                  () {
                                    _validPhoneNumber = false;
                                  },
                                );
                              }
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                // prefixText: '+91',
                                labelText: 'Enter your name'),
                            // autofocus: true,
                            maxLength: 15,
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              if (value.length > 3) {
                                mysetter(
                                  () {
                                    _validName = true;
                                  },
                                );
                              } else {
                                mysetter(
                                  () {
                                    _validName = false;
                                  },
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: Colors.green,
                                tristate: true,
                                onChanged: (value) {
                                  mysetter(
                                    () {
                                      isChecked = value;
                                    },
                                  );
                                },
                              ),
                              Text(
                                "Are you a farmer",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  absorbing: _validPhoneNumber ? false : true,
                                  child: TextButton(
                                    style: _validPhoneNumber
                                        ? TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.orangeAccent)
                                        : TextButton.styleFrom(
                                            backgroundColor: Colors.grey),
                                    onPressed: () {
                                      String number =
                                          '+91${_phoneNumberController.text}';
                                      auth
                                          .verifyPhone(
                                              context,
                                              number,
                                              isChecked!,
                                              _nameController.text
                                                  .trim()
                                                  .toString())
                                          .then((value) {
                                        _phoneNumberController.clear();
                                      });
                                    },
                                    child: _validPhoneNumber
                                        ? const Text("Continue",
                                            style:
                                                TextStyle(color: Colors.white))
                                        : const Text(
                                            "Enter Your Mobile Number",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  );
                },
              ));
    }

    // final locationData = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  top: 10,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.orange),
                      ))),
              Column(
                children: [
                  const Expanded(child: OnBoardingScreen()),
                  const Text(
                    "Ready To Order From Your Favourite Stores?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () async {
                      // await locationData.getCurrentPosition();
                      // if (locationData.permissionAllowed == true) {
                      //   // Navigator.pushReplacementNamed(context, MapScreen.id);
                      // } else {
                      //   print("Permission Denied");
                      // }
                    },
                    child: const Text("Set Your Location"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Already a Customer ? ",
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
