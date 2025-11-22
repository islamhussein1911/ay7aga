import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {final String hintText;final IconData icon; final bool isPassword; final TextEditingController? controller;

  const CustomTextField({Key? key,required this.hintText,required this.icon,this.isPassword = false,this.controller, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    height: 48,
    width: 353,
    padding:  EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color.fromRGBO(147, 146, 149, 1)),
    ),
    child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color.fromRGBO(161, 165, 193, 1)),
          border: InputBorder.none,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
