import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_mimic/utils/firestore/users.dart';
import 'package:twitter_mimic/view/screen.dart';
import 'package:twitter_mimic/view/start_up/create_account_page.dart';

import '../../utils/authentication.dart';
import '../../utils/widget_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControlier = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('新規登録'),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text('Infty SNS',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailControlier,
                    decoration: InputDecoration(hintText: 'メールアドレス'),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(hintText: 'パスワード'),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                    TextSpan(text: 'アカウントを作成していない方は'),
                    TextSpan(
                        text: 'こちら',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccountPage()));
                          })
                  ])),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  var result = await Authentication.emailSignIn(email: emailControlier.text, pass: passController.text);
                  if (result is UserCredential){
                    var _result = await UserFirestore.getUser(result.user!.uid);
                    if (_result == true){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screen()));
                    }

                  }
                },
                child: Text('emailでログイン'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
