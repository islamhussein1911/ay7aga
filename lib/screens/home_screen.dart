import 'package:flutter/material.dart';
import 'package:mostaqel1/customWidgets/home_customWidget.dart';
import 'package:mostaqel1/customWidgets/reject_popupWidget.dart';
import 'dart:ui';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: HomeCustomwidget(
                  image: "assets/images/chicken-photo.jpg",
                  title: "طلبات كريسبي مود :",
                  subtitle: "وجبة كريسبي عائلية 7 قطع مع كاتشب وصلصات.",
                  price: "LS32.000",
                ),
              ),
              Padding(
  padding: EdgeInsets.symmetric(horizontal: 48),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          InkWell(
            onTap: () {
showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(),
              ),
            ),
            RejectPopupwidget(
              otherController: TextEditingController(),
            ),
          ],
        ),
      );
      },
    );
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor:Color.fromRGBO(153, 0, 51, 1),
              child: Icon(Icons.close_rounded, 
              color: Colors.white,
               size: 35,
              fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            "رفض",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 24,
               fontWeight: FontWeight.w400
               ),
          ),
        ],
      ),
      Row(
        children: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color.fromRGBO(105, 159, 76, 1),
              child: Icon(Icons.check_rounded,
               color: Colors.white,
               size: 45,
              fontWeight: FontWeight.w900
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            "قبول",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 24,
             fontWeight: FontWeight.w400
             ),
          ),
        ],
      ),
    ],
  ),
),


            SizedBox(height: 60),
            ],
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/Corner.png",
              width: 160,
            ),
          ),
        ],
      ),
    );
  }
}
