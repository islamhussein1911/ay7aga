import 'package:flutter/material.dart';
import 'package:mostaqel1/customWidgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:ListView(
            children:[ Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 98,),
                Image.asset('assets/images/Logo-BoxIt.png',width: 200,height: 200,),
                SizedBox(height: 48,),
               CustomTextField(hintText: "البريد الالكتروني", icon: Icons.email),
                SizedBox(height: 15,),
                CustomTextField(hintText: "كلمة المرور", icon: Icons.lock_outlined, isPassword: true),
                SizedBox(height: 16,),
                Row(
                  children: [
                    SizedBox(width: 35,
                    ),
                    Icon(
                          Icons.check_box_outline_blank,
                          size: 22,
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                        SizedBox(width: 12,),
                        Text(
                          "تذكرني",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                        SizedBox(width: 110,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "هل نسيت كلمة المرور؟",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(237, 57, 2, 1),
                            ),
                          ),
                        ),
            
                  ],
                ),
                SizedBox(height: 53,),
                Container(
                  height: 71,
                  width: 332,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(237, 57, 2, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ],
          ) ,),
      ),
    );
  }
}