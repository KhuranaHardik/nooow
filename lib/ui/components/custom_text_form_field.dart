// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

//CustomTextField to use text form field wherever needed.
class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    this.textInputType = TextInputType.name,
    this.placeholder = "",
    this.validator,
    this.inputFormatter,
    required this.textInputAction,
    required this.isObscure,
    required this.readOnly,
    this.isPasswordField = false,
    this.suffixIcon,
    this.focusNode,
    required this.borderColor,
    // this.textStyle,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final String placeholder;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  bool isObscure;
  final bool readOnly;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Color borderColor;
  // final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Consumer<UIProvider>(
      builder: (context, passwordProvider, child) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly,
          controller: controller,
          cursorColor: AppColors.navyBlue,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          validator: validator,
          inputFormatters: inputFormatter,
          obscureText: isObscure,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: placeholder,
            labelStyle: GoogleFonts.montserrat(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            hintText: placeholder,
            hintStyle: GoogleFonts.montserrat(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            suffixIcon: isPasswordField
                ? TextButton(
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
                    child: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.navyBlue,
                    ),
                    onPressed: () {
                      isObscure = passwordProvider.showPassword(isObscure);
                    },
                  )
                : suffixIcon,
          ),
        );
      },
    );
  }
}
