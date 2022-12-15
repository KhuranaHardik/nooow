import 'package:flutter/material.dart';

class AdMarkerWidget extends StatelessWidget {
  final Color color;

  const AdMarkerWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 5,
      margin: const EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7.0),
      ),
    );
  }
}
