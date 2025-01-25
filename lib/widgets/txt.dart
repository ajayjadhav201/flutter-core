import 'package:flutter/widgets.dart';

class Txt extends StatelessWidget {
  //
  final String data;
  final TxtStyle? style;

  //
  const Txt(
    this.data, {
    super.key,
    this.style,
  });
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    return Text(
      data,
      style: TextStyle(
        fontSize: style?.fontSize,
        fontWeight: style?.fontWeight,
        height: 1,
        // color: style?.color,
        // color: Colors.pink,
        fontFamily: style?.fontFamity,
        // fontFamily: "QuickSand",
        // fontFamily: "Roboto",
        wordSpacing: style?.wordSpacing,
        letterSpacing: style?.wordSpacing,
      ),
      textAlign: style?.textAlign,
      overflow: style?.overflow,
      maxLines: style?.maxLines,
      textScaler: TextScaler.noScaling,
    );
  }
}
//
//

class TxtStyle {
  TxtStyle({
    this.fontSize,
    this.fontWeight,
    this.fontFamity,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing = 0,
    this.wordSpacing = 1,
  });

  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamity;
  Color? color;
  TextAlign? textAlign;
  TextOverflow? overflow;
  int? maxLines;
  double? letterSpacing;
  double? wordSpacing;
  //
  //
  //
}

/// Fontsize
typedef TxtStyleFn = TxtStyle Function(double fontSize);

// TxtStyleFn extraLight =
//     (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w200);

TxtStyleFn light =
    (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w300);

TxtStyleFn regular =
    (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.normal);

TxtStyleFn medium =
    (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w500);

TxtStyleFn semiBold =
    (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w600);

TxtStyleFn bold =
    (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w700);

// TxtStyleFn extraBold =
//     (double size) => TxtStyle(fontSize: size, fontWeight: FontWeight.w800);

//
//
extension TxtStyleExtension on TxtStyle {
  //
  //
  TxtStyle get alignCenter => this..textAlign = TextAlign.center;
  TxtStyle get alignStart => this..textAlign = TextAlign.start;
  TxtStyle get alignEnd => this..textAlign = TextAlign.end;
  TxtStyle get alignLeft => this..textAlign = TextAlign.left;
  TxtStyle get alignRight => this..textAlign = TextAlign.right;
  //
  //
  TxtStyle get clip => this..overflow = TextOverflow.clip;
  TxtStyle get ellipsis => this..overflow = TextOverflow.ellipsis;
  TxtStyle maxlines(int maxLines) => this..maxLines = maxLines;
  TxtStyle lsp(double sp) => this..letterSpacing = sp;
  TxtStyle wsp(double sp) => this..wordSpacing;
  TxtStyle paint(Color color) => this..color = color;
  // TxtStyle get quickSand => this..fontFamity = "QuickSand";

  //
}
