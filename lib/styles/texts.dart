import 'package:flutter/material.dart';

import 'colors.dart';

// esempio:

//    static const TextStyle name = TextStyle(
//
//      );

class MemoText {
  static const TextStyle titleScreen = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w900,
    color: MemoColors.black,

  );
  static const TextStyle titleCard = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: MemoColors.black
  );
  static const TextStyle alcoolCard = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w100,
      color: MemoColors.black
  );
  static const TextStyle titleDetail = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle alcoolDetail = TextStyle(
    fontSize: 20,
    color: MemoColors.brownie,
  );

  static const TextStyle subtitleDetail = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle conversionNumbers = TextStyle(
    fontSize: 16,
  );
}
