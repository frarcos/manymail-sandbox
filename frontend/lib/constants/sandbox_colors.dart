import 'package:flutter/material.dart';

/// Imported with "Very good Flutter styles" Figma

abstract class SandboxColors {
  /// gradient figma properties
  /// start,stop hex: (#0047ff,#0075ff)
  /// start,stop opacity: (1,1)
  static const List<Color> gradient = <Color>[
    Color(0xff0047ff),
    Color(0xff0075ff),
  ];

  /// white figma properties
  /// hex: #fffbfb
  /// opacity: 1
  static const Color white = Color(0xffffffff);

  /// blue figma properties
  /// hex: #0047ff
  /// opacity: 1
  static const Color blue = Color(0xff0047ff);

  /// darkBlue figma properties
  /// hex: #00237d
  /// opacity: 1
  static const Color darkBlue = Color(0xff00237d);

  /// grey1 figma properties
  /// hex: #edf2ff
  /// opacity: 1
  static const Color grey1 = Color(0xffe5e5e5);

  /// grey2 figma properties
  /// hex: #cbd0df
  /// opacity: 1
  static const Color grey2 = Color(0xffe4e5ea);

  /// grey3 figma properties
  /// hex: #81889a
  /// opacity: 1
  static const Color grey3 = Color(0xff7d7d7d);

  /// black figma properties
  /// hex: #060607
  /// opacity: 1
  static const Color black = Color(0xff0d0d0d);

  /// green figma properties
  /// hex: #00c27c
  /// opacity: 1
  static const Color green = Color(0xff00c27c);

  /// red figma properties
  /// hex: #ff1b1b
  /// opacity: 1
  static const Color red = Color(0xffff1b1b);

  /// yellow figma properties
  /// hex: #ffd600
  /// opacity: 1
  static const Color yellow = Color(0xffffd600);
}
