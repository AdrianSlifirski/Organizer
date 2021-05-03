import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organizer/ScreenHome.dart';
import 'package:organizer/controllers/authentications.dart';
import 'package:organizer/pages/loginScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenHome(uid: value.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Image(
                image: new AssetImage("assets/logo2.png"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Signup Here",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                          validator: MultiValidator([RequiredValidator(errorText: "This Field Is Required."), MinLengthValidator(6, errorText: "Minimum 6 Characters Required.")]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      RaisedButton(
                        onPressed: handleSignup,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          "Sign Up",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () => googleSignIn().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  if (user.uid != null) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ScreenHome(uid: user.uid)));
                }),
                child: Image(
                  image: AssetImage('assets/signin.png'),
                  width: 200.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Login Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
