import 'package:flutter/material.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext context, DeviceType deviceType);

class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder builder;

  const ResponsiveBuilder({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        DeviceType deviceType = DeviceType.phone;

        if (constraints.maxWidth > 1400) {
          deviceType = DeviceType.desktop;
        } else if (constraints.maxWidth > 700) {
          deviceType = DeviceType.tablet;
        }

        return builder(context, deviceType);
      });
}

enum DeviceType {
  phone,
  tablet,
  desktop;

  bool operator <(DeviceType other) {
    return index < other.index;
  }

  bool operator <=(DeviceType other) {
    return index <= other.index;
  }

  bool operator >(DeviceType other) {
    return index > other.index;
  }

  bool operator >=(DeviceType other) {
    return index >= other.index;
  }
}
