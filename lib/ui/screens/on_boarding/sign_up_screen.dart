import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameTextEditingController;
  late TextEditingController _phoneNumberTextEditingController;
  late TextEditingController _emailAddressTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;

  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _phoneNumberTextEditingController = TextEditingController();
    _emailAddressTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _emailAddressTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteBackground,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 35,
          right: 35,
          bottom: appBarHeight,
        ),
        children: [
          Row(
            children: [
              Image.asset(
                AppAssetImages.appLogo,
                height: 29,
              ),
            ],
          ),
          const SizedBox(height: 56),
          Text(
            AppString.signUp,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 41),
          // Name
          CustomTextField(
            controller: _nameTextEditingController,
            textInputAction: TextInputAction.next,
            isObscure: false,
            readOnly: false,
            placeholder: AppString.name,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: _phoneNumberTextEditingController,
            textInputAction: TextInputAction.next,
            isObscure: false,
            readOnly: false,
            placeholder: AppString.phoneNumber,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: _emailAddressTextEditingController,
            textInputAction: TextInputAction.next,
            isObscure: false,
            readOnly: false,
            placeholder: AppString.emailAddress,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: _passwordTextEditingController,
            textInputAction: TextInputAction.next,
            isObscure: true,
            readOnly: false,
            placeholder: AppString.password,
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: _confirmPasswordTextEditingController,
            textInputAction: TextInputAction.next,
            isObscure: true,
            readOnly: false,
            placeholder: AppString.confirmPassword,
          ),
          const SizedBox(height: 21),
          // Get OTP button
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.enterOtpScreen);
            },
            elevation: 0,
            borderColor: AppColors.transparent,
            buttonColor: AppColors.navyBlue,
            buttonSize: Size(size.width, 52),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 17.0),
                child: Text(
                  AppString.signUp,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 21),
          //Sign In
          Center(
            child: RichText(
              text: TextSpan(
                text: AppString.alreadyHaveAnAccount,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.darkGrey,
                ),
                children: [
                  TextSpan(
                    text: AppString.signIn,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.navyBlue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
