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
import 'package:nooow/utils/app_routes.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:nooow/utils/validator/email_validator.dart';
import 'package:nooow/utils/validator/password_validator.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  bool _isFieldsEmpty = false;
  late List<TextEditingController> _controllerList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _controllerList = [
      _emailController,
      _passwordController,
    ];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        elevation: 0.0,
        backgroundColor: AppColors.whiteBackground,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _emailFocus.unfocus();
          _passwordFocus.unfocus();
        },
        child: Consumer<ApiServiceProvider>(
          builder: (context, apiServiceProvider, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                onChanged: () {
                  _isFieldsEmpty =
                      Provider.of<UIProvider>(context, listen: false)
                          .buttonColorChange(_controllerList);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssetImages.appLogo,
                        height: 29,
                      ),
                      const SizedBox(height: 56),
                      Text(
                        AppString.signIn,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 41),
                      // Email
                      CustomTextField(
                        validator: EmailValidator().validateEmail,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        textInputAction: TextInputAction.next,
                        isObscure: false,
                        readOnly: false,
                        placeholder: AppString.emailAddress,
                      ),
                      const SizedBox(height: 21),
                      // Password
                      CustomTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        validator: PasswordValidator().validatePassword,
                        textInputAction: TextInputAction.done,
                        isObscure: true,
                        readOnly: false,
                        placeholder: AppString.password,
                        isPasswordField: true,
                      ),
                      // const SizedBox(height: 21),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              AppString.forgotPassword,
                              style: GoogleFonts.montserrat(
                                  color: AppColors.navyBlue),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.forgotPasswordScreen);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 21),
                      // Get OTP button
                      Consumer<UIProvider>(
                        builder: (context, uiProvider, child) =>
                            CustomElevatedButton(
                          isAnimate: uiProvider.loader,
                          onPressed: _isFieldsEmpty
                              ? uiProvider.loader
                                  ? () {}
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        uiProvider.loaderTrue();
                                        await apiServiceProvider.loginProvider(
                                          context: context,
                                          body: {
                                            "email": _emailController.text,
                                            "password":
                                                _passwordController.text,
                                          },
                                        );
                                        uiProvider.loaderFalse();
                                      }
                                    }
                              : () {},
                          elevation: 0,
                          borderColor: AppColors.transparent,
                          buttonColor: _isFieldsEmpty
                              ? AppColors.navyBlue
                              : AppColors.navyBlue.withOpacity(0.4),
                          buttonSize: Size(size.width, 52),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 17.0),
                              child: Text(
                                AppString.signIn,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: _isFieldsEmpty
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      Center(
                        child: Text(
                          AppString.orSignInVia,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      // Social Login Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Facebook Sign In
                          CustomElevatedButton(
                            onPressed: () {},
                            elevation: 0,
                            borderColor: AppColors.lightGrey,
                            buttonColor: AppColors.whiteBackground,
                            buttonSize: Size(size.width * 0.38, 52),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(AppAssetImages.facebook),
                                    const SizedBox(width: 10.5),
                                    Text(
                                      AppString.facebook,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 19),
                          // Google Sign In
                          CustomElevatedButton(
                            onPressed: () {},
                            elevation: 0,
                            borderColor: AppColors.lightGrey,
                            buttonColor: AppColors.whiteBackground,
                            buttonSize: Size(size.width * 0.38, 52),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(AppAssetImages.google),
                                    const SizedBox(width: 10.5),
                                    Text(
                                      AppString.google,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Sign Up
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: AppString.dontHaveAnAccount,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.lightGrey,
                            ),
                            children: [
                              TextSpan(
                                text: AppString.signUp,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.navyBlue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.signUpScreen);
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
            );
          },
        ),
      ),
    );
  }
}
