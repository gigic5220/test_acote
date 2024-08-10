import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_acote/widget/common/loading_spinner_widget.dart';

class CustomCachedNetworkImageWidget extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const CustomCachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  CustomCachedNetworkImageWidgetState createState() => CustomCachedNetworkImageWidgetState();
}

class CustomCachedNetworkImageWidgetState extends State<CustomCachedNetworkImageWidget> {

  int calculateDelay(int retryCount) {
    return pow(2, retryCount).toInt();
  }

  void _addRetryCount() async {
    await Future.delayed(Duration(seconds: calculateDelay(_retryCount)));
    setState(() {
      _retryCount += 1;
    });
  }

  int _retryCount = 0;
  CachedNetworkImageProvider? _cachedNetworkImageProvider;

  Widget _reloadImageWidget() {
    if (_retryCount < 3) {
      _addRetryCount();
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: const Center(child: LoadingSpinnerWidget()),
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _cachedNetworkImageProvider = CachedNetworkImageProvider(
      widget.imageUrl,
      errorListener: (error) {
        _addRetryCount();
      }
    );

    if (_cachedNetworkImageProvider != null) {
      await precacheImage(_cachedNetworkImageProvider!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedNetworkImageProvider != null) {
      return Image(
        width: widget.width,
        height: widget.height,
        image: _cachedNetworkImageProvider!,
        errorBuilder: (context, _, __) {
          return _reloadImageWidget();
        },
      );
    } else {
      return Container();
    }
  }
}