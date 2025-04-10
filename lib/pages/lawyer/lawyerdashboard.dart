import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veritasapp/Widgets/Dabba.dart';
import 'package:veritasapp/Widgets/bottomnavigation.dart';
import 'package:veritasapp/Widgets/search.dart';
import 'package:veritasapp/Widgets/topclients.dart';
import 'package:veritasapp/Widgets/toplawyers.dart';
import 'package:veritasapp/hero_dialog_route.dart';

class lawyerdashboard extends StatelessWidget {
  const lawyerdashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double varHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(132, 189, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: varHeight * 0.05),
            SearchButton(),
            SizedBox(
              height: varHeight * 0.05,
            ),
            AutoScrollDashboardLaw(),
            SizedBox(height: varHeight * 0.05),
            GestureDetector(
              child: DashboardBox(
                textSize: 24,
                boxColor: Colors.white,
                imagePath: "assets/images/Judge-rafiki 1.svg",
                textColor: Colors.black,
                text: "New Case",
                height: varHeight * 0.2,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/regcase");
              },
            ),
            SizedBox(height: varHeight * 0.05),
            DashboardBox(
              textSize: 24,
              boxColor: Colors.white,
              imagePath: "assets/images/Judge-rafiki 1.svg",
              textColor: Colors.black,
              text: "Case\nStatus",
              height: varHeight * 0.2,
            ),
            SizedBox(height: varHeight * 0.05),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/chat");
              },
              child: DashboardBox(
                textSize: 24,
                boxColor: Colors.white,
                imagePath: "assets/images/Judge-rafiki 1.svg",
                textColor: Colors.black,
                text: "AI help",
                height: varHeight * 0.2,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationDabba(
        index: 0,
        onTap: (index) {
          print("Selected Index: $index");
        },
        backgroundColor: Colors.grey[200]!,
        buttonColor: Colors.black,
        icons: [Icons.home, Icons.file_copy, Icons.payment],
      ),
    );
  }
}
