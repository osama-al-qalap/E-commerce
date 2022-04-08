import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final Color borderColor;
  final String label;
  final Function ontap;
  final IconData iconData;

  const ProfileMenuItem(
      {required this.borderColor,
      required this.label,
      required this.ontap,
      required this.iconData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap(),
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width - 20,
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(
                  color: borderColor, width: 5, style: BorderStyle.solid)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
            ),
            Icon(
              iconData,
              size: 30,
              color: borderColor,
            )
          ],
        ),
      ),
    );
  }
}
