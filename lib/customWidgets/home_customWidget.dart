import 'package:flutter/material.dart';

class HomeCustomwidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;

  HomeCustomwidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 620,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 408,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
  padding: EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),

      SizedBox(height: 8),

      Text(
        subtitle,
        style:TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),

      SizedBox(height: 16),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          price,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  ),
)

          ],
        ),
      ),
    );
  }
}
