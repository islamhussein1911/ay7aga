import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;

  const FoodCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 193,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: 109,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
           SizedBox(height: 5),
           

        Padding(
  padding:  EdgeInsets.symmetric(horizontal: 8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              
            ),
          ),
          SizedBox(width: 37,
          ),
          Container(
           width: 16,
           height: 16,
          decoration: BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
          shape: BoxShape.circle,
          border: Border.all(color: Color.fromRGBO(217, 217, 217, 1), width: 2),
          ),
          child:Icon(Icons.edit, size: 10),
           ),
           SizedBox(width: 5,
           ),
              Container(
           width: 16,
           height: 16,
          decoration: BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
          shape: BoxShape.circle,
          border: Border.all(color: Color.fromRGBO(217, 217, 217, 1), width: 2),
          ),
          child:Icon(Icons.remove_red_eye, size: 10),
           ),

        ],
      ),
      SizedBox(height: 8,),
      Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.w500,
        ),
      ),
     SizedBox(height: 11),
      Text(
        price,
        style: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(252, 189, 21, 1),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
)

        ],
      ),
    );
  }
}
