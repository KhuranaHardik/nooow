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
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  late FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
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
      body: Consumer<ApiServiceProvider>(
        builder: (context, apiServiceProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssetImages.appLogo,
                      height: 29,
                    ),
                    const SizedBox(height: 56),
                    Text(
                      AppString.forgotPassword,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 41),
                    CustomTextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.done,
                      isObscure: false,
                      readOnly: false,
                      focusNode: _emailFocus,
                      placeholder: AppString.emailAddress,
                      borderColor: AppColors.navyBlue,
                    ),
                    const SizedBox(height: 18),
                    // Reset Password Button
                    Consumer<UIProvider>(
                      builder: (context, consumer, child) =>
                          CustomElevatedButton(
                        isAnimate: consumer.loading,
                        onPressed: () async {
                          consumer.loaderTrue();
                          await ApiServiceProvider().forgotPasswordProvider(
                            context: context,
                            body: {"email": _emailController.text},
                          );
                          consumer.loaderFalse();
                          // Navigator.pushNamed(
                          //   context,
                          //   AppRoutes.enterOtpForgotPasswordScreen,
                          //   arguments: {
                          //     "email": _emailController.text,
                          //     "otp": result["information"]["otp"].toString(),
                          //   },
                          // );
                        },
                        elevation: 0,
                        borderColor: AppColors.transparent,
                        buttonColor: AppColors.navyBlue,
                        buttonSize: Size(size.width, 52),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17.0),
                          child: Text(
                            AppString.getOtp,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // Loading Screen
              ],
            ),
          );
        },
      ),
    );
  }
}
