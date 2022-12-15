import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nooow/provider/password_provider.dart';
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
    this.textStyle,
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
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordProvider>(
      builder: (context, passwordProvider, child) {
        return TextFormField(
          readOnly: readOnly,
          controller: controller,
          cursorColor: Colors.black,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          validator: validator,
          inputFormatters: inputFormatter,
          obscureText: isObscure,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintStyle: textStyle,
            hintText: placeholder,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.navyBlue,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.navyBlue,
              ),
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
