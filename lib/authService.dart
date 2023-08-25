import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'Appdefault.dart';

class socialLoginAuth extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUSer() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context, navigateScreen) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount;

    try {
      googleSignInAccount = await googleSignIn.signIn().catchError((onError) => null);
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken ?? "", accessToken: googleSignInAuthentication?.accessToken.toString() ?? "");
        UserCredential result = await firebaseAuth.signInWithCredential(credential);
        User? userdetails = result.user;

        if (userdetails != null) {
          await savestring().savename("${userdetails.displayName ?? ""}");

          print(userdetails);

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
      } else {
        print("Something wrong in result ==  google sign problem");
        return; 
      }
    } on PlatformException {
      return null;
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
        ),
      );
    } catch (err) {
      print("goolesigntout errror :- $err");
      log("goolesigntout errror :==>  $err");
    }
  }

  signInWithApple(BuildContext context, navigateScreen) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken ?? "",
        accessToken: result.authorizationCode ?? "",
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final userdetails = authResult.user;
      if (userdetails != null) {
        await savestring().savename("${userdetails.uid}");

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
      }
      // Handle user details as needed
    } on PlatformException {
      return null;
    } catch (error) {
      print("Apple Sign-In Error: $error");
    }
  }
}
// webAuthenticationOptions: WebAuthenticationOptions(
        //   clientId: 'your_client_id', // Replace with your client ID
        //   redirectUri: Uri.parse('your_redirect_uri'), // Replace with your redirect URI
        // ),

        //MARK:-  if strore data in  in data base cloud  storage
        // Map<String, dynamic> userInfoMap = {
        //   "email": userdetails!.email,
        //   "name": userdetails.displayName,
        //   "imgUrl": userdetails.photoURL,
        //   "id": userdetails.uid,
        // };
        // DatabaseMethods().addUser(userdetails.uid, userInfoMap).then((value) {

        // });