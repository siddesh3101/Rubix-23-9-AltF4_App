import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisaankahaak/screens/dashboard_screen.dart';
import 'package:kisaankahaak/screens/retailer_dashboard.dart';
import 'package:kisaankahaak/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String smsOtp;
  late String verificationId;
  String error = '';
  final UserServices _userServices = UserServices();
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('users');

  Future<void> verifyPhone(
      BuildContext context, String number, bool ischecked, String name) async {
    verificationCompleted(PhoneAuthCredential credential) async {
      await _firebaseAuth.signInWithCredential(credential);
    }

    verificationFailed(FirebaseAuthException e) {
      print(e.code);
    }

    smsOtpSend(String verId, int? resendToken) async {
      verificationId = verId;

      smsOtpDialog(context, number, ischecked, name);
    }

    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> smsOtpDialog(
      BuildContext context, String number, bool isChecked, String name) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: const [
              Text("Verification Code"),
              SizedBox(
                height: 6,
              ),
              Text("Enter 6 digits OTP received as sms"),
            ],
          ),
          content: SizedBox(
            height: 85,
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                smsOtp = value;
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsOtp);
                    final User? user = (await _firebaseAuth
                            .signInWithCredential(phoneAuthCredential))
                        .user;

                    _createUser(
                        id: user!.uid,
                        number: user.phoneNumber,
                        status: isChecked,
                        name: name);
                    if (user != null) {
                      final docUser = profileList.doc(user.uid);
                      final snapshot = await docUser.get();
                      var data = snapshot.data() as Map;
                      // Navigator.of(context).pop();

                      // var _list = data.values.toList();
                      data["status"] == true
                          ? Navigator.pushReplacementNamed(
                              context, DashBoardScreen.id)
                          : Navigator.pushReplacementNamed(
                              context, RetailerDashBoard.id);

                      // Navigator.pushReplacementNamed(
                      //     context, RetailerDashBoard.id);
                    } else {
                      print("login failed");
                    }

                    //NAGIATE TO HOME PAGE AFTER LOGIN
                  } catch (e) {
                    error = 'Invalid Otp';
                    notifyListeners();
                    print(e.toString());
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Done"))
          ],
        );
      },
    );
  }

  void _createUser({id, number, status, name}) {
    _userServices.createUserData(
        {'id': id, 'number': number, 'status': status, 'name': name});
  }
}
