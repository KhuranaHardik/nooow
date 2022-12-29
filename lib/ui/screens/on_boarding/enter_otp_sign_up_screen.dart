import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';
import 'package:provider/provider.dart';

class EnterOtpSignUpScreen extends StatefulWidget {
  final String email;
  final String otp;

  const EnterOtpSignUpScreen({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  State<EnterOtpSignUpScreen> createState() => _EnterOtpSignUpScreenState();
}

class _EnterOtpSignUpScreenState extends State<EnterOtpSignUpScreen> {
  late TextEditingController _otpTextEditingController;
  late FocusNode _otpFocus;

  @override
  void initState() {
    super.initState();
    _otpTextEditingController = TextEditingController(text: widget.otp);
    _otpFocus = FocusNode();
  }

  @override
  void dispose() {
    _otpTextEditingController.dispose();
    _otpFocus.dispose();
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
          _otpFocus.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo
              Image.asset(
                AppAssetImages.appLogo,
                height: 29,
              ),
              const SizedBox(height: 56),
              // Enter OTP
              Text(
                AppString.enterOtpCode,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 11),
              RichText(
                text: TextSpan(
                  text: AppString.codeSentTo,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.lightGrey,
                  ),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.navyBlue,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  text: AppString.notReceivedOtp,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.lightGrey,
                  ),
                  children: [
                    TextSpan(
                      text: AppString.resendHere,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.navyBlue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Resend OTP Function call
                        },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _otpTextEditingController,
                focusNode: _otpFocus,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                textAlign: TextAlign.center,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "******",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navyBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navyBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<UIProvider>(
                builder: (context, consumer, child) => CustomElevatedButton(
                  isAnimate: consumer.loader,
                  onPressed: () async {
                    consumer.loaderTrue();
                    await ApiServiceProvider()
                        .signupOtpVerification(context: context, body: {
                      "email": widget.email,
                      "otp": _otpTextEditingController.text,
                    });
                    consumer.loaderFalse();
                  },
                  elevation: 0,
                  borderColor: AppColors.transparent,
                  buttonColor: AppColors.navyBlue,
                  buttonSize: Size(size.width, 52),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: Text(
                        AppString.verify,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
