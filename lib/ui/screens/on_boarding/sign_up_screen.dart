import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:nooow/utils/validator/email_validator.dart';
import 'package:nooow/utils/validator/password_validator.dart';
import 'package:nooow/utils/validator/phoneno_validator.dart';
import 'package:nooow/utils/validator/user_name_validator.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameTextEditingController;
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;
  late FocusNode _nameFocus;
  late FocusNode _phoneFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _nameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      body: Consumer2<UIProvider, ApiServiceProvider>(
        builder: (context, uiProvider, apiServiceProvider, child) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _nameFocus.unfocus();
                  _phoneFocus.unfocus();
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();
                  _confirmPasswordFocus.unfocus();
                },
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: 35,
                      right: 35,
                      bottom: appBarHeight,
                    ),
                    children: [
                      SizedBox(height: appBarHeight),
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
                      CustomTextField(
                        controller: _nameTextEditingController,
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: false,
                        readOnly: false,
                        placeholder: AppString.name,
                        validator: UserNameValidator().validateUserName,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _phoneTextEditingController,
                        focusNode: _phoneFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: false,
                        readOnly: false,
                        placeholder: AppString.phoneNumber,
                        validator: PhoneNoValidator().phoneNoValidation,
                        inputFormatter: [LengthLimitingTextInputFormatter(10)],
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _emailTextEditingController,
                        focusNode: _emailFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: false,
                        readOnly: false,
                        placeholder: AppString.emailAddress,
                        validator: EmailValidator().validateEmail,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _passwordTextEditingController,
                        focusNode: _passwordFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: true,
                        readOnly: false,
                        placeholder: AppString.password,
                        validator: PasswordValidator().validatePassword,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _confirmPasswordTextEditingController,
                        focusNode: _confirmPasswordFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: true,
                        readOnly: false,
                        placeholder: AppString.confirmPassword,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Password Required*";
                          } else if (val !=
                              _passwordTextEditingController.text) {
                            return "Password do not match.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 21),
                      // Get OTP button
                      Consumer<UIProvider>(
                        builder: (context, consumer, child) =>
                            CustomElevatedButton(
                          isAnimate: consumer.loader,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              consumer.loaderTrue();
                              await ApiServiceProvider()
                                  .signupProvider(context: context, body: {
                                "name": _nameTextEditingController.text,
                                "contact": _phoneTextEditingController.text,
                                "email": _emailTextEditingController.text,
                                "password": _passwordTextEditingController.text,
                                "confirm_password":
                                    _confirmPasswordTextEditingController.text,
                              });

                              consumer.loaderFalse();
                            }
                          },
                          elevation: 0,
                          borderColor: AppColors.transparent,
                          buttonColor: AppColors.navyBlue,
                          buttonSize: Size(size.width, 52),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 17.0),
                              child: Text(
                                AppString.getOtp,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
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
                ),
              ),
              // Loading Screen
              uiProvider.loader == true
                  ? Container(
                      height: size.height,
                      color: AppColors.whiteBackground.withOpacity(0.4),
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.navyBlue),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}
