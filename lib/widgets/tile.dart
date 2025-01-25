import 'package:flutter/material.dart';

import 'txt.dart';

class Tile extends StatelessWidget {
  final Txt? label;
  final TextStyle? labelStyle;
  final Widget? child;
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final bool ignoring;
  final double? opacity;
  final Color? maskColor;
  final Color? splashColor;
  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxShape shape;
  final bool clip;
  //
  //
  Tile({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.alignment,
    BoxConstraints? constraints,
    this.color,
    this.gradient,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
    this.onTap,
    this.ignoring = false,
    this.opacity,
    this.maskColor,
    this.splashColor,
    this.clip = false,
    this.label,
    this.labelStyle,
    this.child,
  }) : constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints;

  @override
  Widget build(BuildContext context) {
    //
    // assert(child != null || label != null, "Please provide child or label");
    if (gradient != null) {
      assert(gradient!.colors.length > 1,
          "add minimum two color properties in gradient");
    }
    //
    Widget? widget;

    if (child != null) {
      widget = opacity == null
          ? child!
          : Opacity(opacity: opacity ?? 1, child: child);
    } else if (label != null) {
      widget = label;
    }
    //
    //
    if (alignment != null) {
      widget = Align(alignment: alignment!, child: widget);
    }
    //
    if (padding != null) {
      widget = Padding(padding: padding!, child: widget);
    }

    if (constraints == null) {
      widget = SizedBox(child: widget);
    } else {
      widget = ConstrainedBox(constraints: constraints!, child: widget);
    }
    //

    //
    //
    if (onTap != null && !ignoring && splashColor != null) {
      widget = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          overlayColor: WidgetStatePropertyAll(splashColor),
          child: widget,
        ),
      );
    }
    // apply background decoration
    //
    widget = DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null
            ? onTap != null && color == null
                ? Colors.transparent
                : opacity != null
                    ? color?.withOpacity(opacity ?? 1)
                    : color
            : null,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: widget,
    );

    //apply foreground decoration
    if (maskColor != null && opacity == null) {
      widget = DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          color: maskColor,
          borderRadius: borderRadius,
        ),
        child: widget,
      );
    }
    //
    //
    if (onTap != null && !ignoring) {
      widget = GestureDetector(
        onTap: onTap,
        child: widget,
      );
    }

    if (clip && borderRadius != null) {
      widget = ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius?.topLeft ?? Radius.zero,
          topRight: borderRadius?.topRight ?? Radius.zero,
          bottomRight: borderRadius?.bottomRight ?? Radius.zero,
          bottomLeft: borderRadius?.bottomLeft ?? Radius.zero,
        ),
        child: widget,
      );
    }
    return widget;
  }
}
