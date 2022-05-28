import 'package:flutter/material.dart';
import 'package:user/helpers/constants.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Ôn Thi ',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        TextSpan(
            text: 'Giấy Phép Lái Xe Máy',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.teal)),
      ],
    ),
  );
}

Widget blueButton(BuildContext context, String label) {
  return Container(
    decoration: BoxDecoration(
        color: kBackgroundColor, borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.symmetric(vertical: 16),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget whiteButton(BuildContext context, String label) {
  return Container(
    decoration: BoxDecoration(
        color: const Color(0xFFDFE1E5),
        borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.symmetric(vertical: 16),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: const TextStyle(fontSize: 16),
    ),
  );
}

