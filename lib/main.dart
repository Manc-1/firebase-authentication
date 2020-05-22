import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {

  // Twitter login
  var twitterLogin = new TwitterLogin(
      consumerKey: 'Mm8k4j95ANTtvzZ50HXXrcl2Y',
      consumerSecret: 'K0kXhE1VoWQhOxe5tWWUBwmT7R3dIREvQGG9SaBeBkOXoCyiIO');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login with Twitter'),
            color: Color(0xff00acee),
          onPressed: () {
            twitterLogin.authorize().then((result) {
              switch(result.status){
                case TwitterLoginStatus.loggedIn:
                  AuthCredential credential = TwitterAuthProvider.getCredential(authToken: result.session.token, authTokenSecret: result.session.secret);
                  
                  FirebaseAuth.instance.signInWithCredential(credential).then((signedInUser){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  });
              }
            }).catchError((e) {
              print(e);
            });

          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logged In"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
