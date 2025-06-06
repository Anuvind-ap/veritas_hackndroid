import 'package:flutter/material.dart';
import 'package:veritasapp/pages/client/casestatus.dart';
import 'package:veritasapp/pages/client/selectlawyer.dart';
import 'package:veritasapp/pages/login_signup/signupdetails_client.dart';
import 'package:veritasapp/pages/login_signup/signupdetails_lawyer.dart';
import 'package:veritasapp/pages/splash.dart';
import 'package:veritasapp/pages/imlawyer.dart';
import 'package:veritasapp/pages/client/clientfeature.dart';
import 'package:veritasapp/pages/login_signup/loginpage.dart';
import 'package:veritasapp/pages/client/clientdashboard.dart';
import 'package:veritasapp/pages/chatscreen.dart';

import "package:firebase_core/firebase_core.dart";
import 'package:veritasapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veritasapp/pages/client/registercase.dart';
import "package:veritasapp/pages/lawyer/lawyerfeat.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veritasapp/pages/lawyer/lawyerdashboard.dart';
import 'package:veritasapp/pages/lawyer/findcase.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final Future<String> _initialRoute;

  MyApp({super.key}) {
    _initialRoute = _determineInitialRoute();
  }

  Future<String> _determineInitialRoute() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '/first';
    } else {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("client")
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          return '/cldashboard';
        } else {
          return '/lawyerdashboard';
        }
      } catch (error) {
        print("Error fetching user document: $error");
        return '/first'; // Handle error condition
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initialRoute,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator or splash screen while determining initial route
          return MaterialApp(); // splash screen
        } else {
          if (snapshot.hasError) {
            // Handle error if any
            return Text('Error: ${snapshot.error}');
          } else {
            return MaterialApp(
              initialRoute: snapshot.data ??
                  '/first', // Use initialRoute when available, otherwise fallback to '/first'
              routes: {
                "/": (context) => splash(),
                "/first": (context) => firstpg(),
                "/lawyerfeat": (context) => lawfeat(),
                "/clientfeature": (context) => clfeat(),
                "/loginclient": (context) => login(usertype: "client"),
                "/loginlawyer": (context) => login(usertype: "lawyer"),
                "/cldashboard": (context) => cldashboard(),
                "/lawyerdashboard": (context) => lawyerdashboard(),
                "/signupdetails_client": (context) => signInDetails_client(),
                "/signupdetails_lawyer": (context) => signInDetails_lawyer(),
                "/chat": (context) => chatsection(
                      receivertype: "chatbot",
                    ),
                "/regcase": (context) => regcase(),
                "/findcase": (context) => findcase(),
                "/selectlawyer": (context) => Selectlawyer(),
                "/casestatus": (context) => Casestatus(),
              },
            );
          }
        }
      },
    );
  }
}
