part of '_extensions.dart';

extension WidgetExtension on Widget {
  //
  Center get center => Center(child: this);
  //
  Align get alignCenter => Align(alignment: Alignment.center, child: this);
  Align get alignCenterLeft =>
      Align(alignment: Alignment.centerLeft, child: this);
  Align get alignCenterRight =>
      Align(alignment: Alignment.centerRight, child: this);
  //
  Align get alignTopLeft => Align(alignment: Alignment.topLeft, child: this);
  Align get alignTopCenter =>
      Align(alignment: Alignment.topCenter, child: this);
  Align get alignTopRight => Align(alignment: Alignment.topRight, child: this);
  //
  Align get alignBottomLeft =>
      Align(alignment: Alignment.bottomLeft, child: this);
  Align get alignBottomCenter =>
      Align(alignment: Alignment.bottomCenter, child: this);
  Align get alignBottomRight =>
      Align(alignment: Alignment.bottomRight, child: this);
  //
  //
  // PADDING EXTENSION ON WIDGETS
  Padding pall(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Padding pleft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  Padding pright(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  Padding ptop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  Padding pbottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  Padding phorizontal(double horizontal) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal), child: this);
  }

  Padding pvertical(double vertical) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: vertical), child: this);
  }

  //
  //
}

//
//
EdgeInsets get pzero => EdgeInsets.zero;
EdgeInsets pall(double value) {
  return EdgeInsets.all(value);
}

EdgeInsets pleft(double left) {
  return EdgeInsets.only(left: left);
}

EdgeInsets pright(double right) {
  return EdgeInsets.only(right: right);
}

EdgeInsets ptop(double top) {
  return EdgeInsets.only(top: top);
}

EdgeInsets pbottom(double bottom) {
  return EdgeInsets.only(bottom: bottom);
}

EdgeInsets phorizontal(double horizontal) {
  return EdgeInsets.symmetric(horizontal: horizontal);
}

EdgeInsets pvertical(double vertical) {
  return EdgeInsets.symmetric(vertical: vertical);
}

//
//
extension PaddingExtension on EdgeInsets {
  //
  EdgeInsets pleft(double left) {
    return copyWith(left: left);
  }

  EdgeInsets pright(double right) {
    return copyWith(right: right);
  }

  EdgeInsets ptop(double top) {
    return copyWith(top: top);
  }

  EdgeInsets pbottom(double bottom) {
    return copyWith(bottom: bottom);
  }

  EdgeInsets phorizontal(double horizontal) {
    return copyWith(left: horizontal, right: horizontal);
  }

  EdgeInsets pvertical(double vertical) {
    return copyWith(top: vertical, bottom: vertical);
  }
  //
  //
}
