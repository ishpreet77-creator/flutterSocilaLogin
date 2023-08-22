import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_create_pod/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'googleAuthModel.dart';

class Googleauth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUSer() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context, navigateScreen) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleAuthModel? userData;
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken, accessToken: googleSignInAuthentication?.accessToken);
      UserCredential result = await firebaseAuth.signInWithCredential(credential);
      User? userdetails = result.user;

      if (result != null) {
        userData = googleAuthModel(
          displayName: userdetails?.displayName,
          email: userdetails?.email,
          isEmailVerified: userdetails?.emailVerified,
          isAnonymous: userdetails?.isAnonymous,
          metadata: Metadata(creationTime: userdetails?.metadata.creationTime.toString(), lastSignInTime: userdetails?.metadata.lastSignInTime.toString()),
          phoneNumber: userdetails?.phoneNumber,
          photoURL: userdetails?.photoURL,
          providerData: userdetails?.providerData
              .map((info) => Info(
                    displayName: info.displayName,
                    email: info.email,
                    phoneNumber: info.phoneNumber,
                    photoURL: info.photoURL,
                    providerId: info.providerId,
                    uid: info.uid,
                  ))
              .toList(),
          refreshToken: googleSignInAuthentication?.accessToken,
        );

        // Now you can use the `userData` instance wherever needed

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: navigateScreen,
              );
            },
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      } else {
        print("Something wrong in result == $result");
      }
    } catch (err) {
      print("Google Authentication Error: $err");
    }
  }

  signOut(BuildContext context, LoginScreen) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, .0),
                end: Offset.zero,
              ).animate(animation),
              child: LoginScreen,
            );
          },
          transitionDuration: Duration(milliseconds: 300),
        ), // Replace LoginScreen with your actual login screen widget
      );
    } catch (err) {
      print("goolesigntout errror :- $err");
    }
  }

  signInWithApple() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // webAuthenticationOptions: WebAuthenticationOptions(
        //   clientId: 'your_client_id', // Replace with your client ID
        //   redirectUri: Uri.parse('your_redirect_uri'), // Replace with your redirect URI
        // ),
      );

      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = authResult.user;
      print(authResult.user);
      // Handle user details as needed
    } catch (error) {
      print("Apple Sign-In Error: $error");
    }
  }
}


        //MARK:-  if strore data in  in data base cloud  storage
        // Map<String, dynamic> userInfoMap = {
        //   "email": userdetails!.email,
        //   "name": userdetails.displayName,
        //   "imgUrl": userdetails.photoURL,
        //   "id": userdetails.uid,
        // };
        // DatabaseMethods().addUser(userdetails.uid, userInfoMap).then((value) {

        // });