import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nooow/utils/app_colors.dart';

//Custom Elevated Button.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.buttonColor,
    this.buttonSize,
    required this.onPressed,
    this.child,
    this.elevation,
    required this.borderColor,
    this.borderRadius = 5.0,
    this.isAnimate = false,
  }) : super(key: key);

  final Color? buttonColor;
  final Size? buttonSize;
  final void Function()? onPressed;
  final Widget? child;
  final bool? isAnimate;
  final double? elevation;
  final Color borderColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: buttonColor,
        fixedSize: buttonSize,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAnimate ?? false
              ? const CupertinoActivityIndicator(
                  color: AppColors.white,
                  radius: 10,
                  animating: true,
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: isAnimate ?? false ? 5 : 0,
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
