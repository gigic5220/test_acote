import 'package:flutter/material.dart';
import 'package:test_acote/widget/common/loading_spinner_widget.dart';

class CommonPagingLoadingWidget extends StatelessWidget {

  const CommonPagingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.3),
      ),
      width: 50,
      height: 50,
      child: const Center(
        child: LoadingSpinnerWidget(color: Colors.white),
      )
    );
  }
}
