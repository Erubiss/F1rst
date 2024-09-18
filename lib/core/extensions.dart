import 'package:flutter/material.dart';

extension ExpandedExtension on Widget {
  Expanded expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }
}

extension AlignExtension on Widget {
  Align align({
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }
}

extension PaddingExtensions on Widget {
  Padding symmetricPadding({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical,
        horizontal: horizontal,
      ),
      child: this,
    );
  }

  GestureDetector withGesture({
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  Padding allPadding(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Padding onlyPadding({
    double l = 0.0,
    double t = 0.0,
    double r = 0.0,
    double b = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: l,
        top: t,
        right: r,
        bottom: b,
      ),
      child: this,
    );
  }

  Padding paddingLTRB([
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  ]) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  Opacity opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }
}