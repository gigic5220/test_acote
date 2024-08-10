import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const LoadingSpinnerWidget({super.key, this.color, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: color ?? Colors.black12,
        radius: width != null ? width! - 5 : 20,
      );
    } else {
      return SizedBox(
        width: width ?? 20,
        height: height ?? 20,
        child: CircularProgressIndicator(
          color: color ?? Colors.black12,
          strokeAlign: 0,
          strokeWidth: 2,
        ),
      );
    }
  }
}
