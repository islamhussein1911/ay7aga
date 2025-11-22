import 'package:flutter/material.dart';
import 'package:mostaqel1/customWidgets/food_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding
            (padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 221,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 129, 129, 0.2),
                    borderRadius: BorderRadius.circular(100),
            ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 99,
                        height: 39,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(237, 57, 2, 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                    child: Text(
                      "مفتوح ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                      ),
                      SizedBox(width: 50,),
                      Text(
                        "مغلق",
                        style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 57,
            ),
            Text(
              "أصنافي :",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
            
              ),
            ),
            SizedBox(
              height: 16,
            ),
            
            GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.75,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
                             FoodCard(title: "وجبة كرسبي",
               subtitle: "وجبة عائلية",
                price: "ls32.000",
                 imagePath: "assets/images/card-photo.jpg"),
            ],
            ),
                  
            ],
            
                    ),),
          )),
      ),
    );
  }
}