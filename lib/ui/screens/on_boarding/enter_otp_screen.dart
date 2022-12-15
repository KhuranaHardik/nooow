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

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({Key? key}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  late TextEditingController _otpTextEditingController;

  @override
  void initState() {
    super.initState();
    _otpTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteBackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.whiteBackground,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
      ),
      body: Padding(
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
                // TODO:Display Users mobile Number
                children: [
                  TextSpan(
                    text: "Mobile Number",
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
                        // Navigator.pushNamed(context, AppRoutes.signUpScreen);
                      },
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            CustomTextField(
              controller: _otpTextEditingController,
              textInputAction: TextInputAction.done,
              isObscure: false,
              readOnly: false,
            ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.homeScreen, (route) => false);
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
            )
          ],
        ),
      ),
    );
  }
}
