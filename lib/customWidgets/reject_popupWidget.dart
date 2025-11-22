import 'package:flutter/material.dart';

class RejectPopupwidget extends StatelessWidget {
  final String? selectedReason;
  final TextEditingController otherController;

  const RejectPopupwidget({
    super.key,
    this.selectedReason,
    required this.otherController,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تم رفض الطلب بسبب :",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              SizedBox(height: 20),

              _radioTile("لا يوجد صمون"),
              _radioTile("لا يوجد خردل"),
              _radioTile("لا يوجد دجاج"),

              SizedBox(height: 10),


              Container(
  padding:  EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color.fromRGBO(146, 146, 146, 1)),
  ),
  child: TextField(
    controller: otherController,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: "آخر :",
      hintStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    ),
  ),
),
             SizedBox(height: 25),

              SizedBox(
                width: 220,
                height: 71,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(237, 57, 2, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "موافق",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioTile(String text) {
    return Row(
      children: [
        Radio(
          value: text,
          groupValue: null, // Stateless, cannot track selected
          onChanged: (val) {},
          activeColor: Colors.green,
        ),
        Text(text),
      ],
    );
  }
}
