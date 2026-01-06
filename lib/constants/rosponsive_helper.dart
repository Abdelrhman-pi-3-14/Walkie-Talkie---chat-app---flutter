
import 'package:flutter/cupertino.dart';

class Responsive {
  final Size size;
  final Orientation orientation;

  Responsive(BuildContext context)
      : size = MediaQuery.of(context).size,
        orientation = MediaQuery.of(context).orientation;

  bool get isSmallPhone => size.width < 360;
  bool get isPhone => size.width < 600;
  bool get isTablet => size.width >= 600;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  double w(double percent) => size.width * percent;
  double h(double percent) => size.height * percent;

  double faceHeight() {
    if (isLandscape) return h(0.6);
    if (isTablet) return h(0.35);
    return h(0.45);
  }

  double mainButtonSize() {
    if (isTablet) return w(0.18);
    return w(0.28);
  }

  double get paddingSmall => w(0.03);
  double get paddingMedium => w(0.05);
  double get paddingLarge => w(0.08);

  double clampWidth(double value) {
    return value > 600 ? 600 : value;
  }
}
