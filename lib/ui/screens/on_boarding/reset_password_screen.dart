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
import 'package:nooow/utils/validator/password_validator.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
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
      body: Consumer2<UIProvider, ApiServiceProvider>(
          builder: (context, uiProvider, apiServiceProvider, child) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssetImages.appLogo,
                        height: 29,
                      ),
                      const SizedBox(height: 56),
                      Text(
                        AppString.resetPassword,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 41),
                      CustomTextField(
                        validator: PasswordValidator().validatePassword,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        readOnly: false,
                        isPasswordField: true,
                        focusNode: _passwordFocus,
                        placeholder: AppString.password,
                        borderColor: AppColors.navyBlue,
                        isObscure: true,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        validator: PasswordValidator().validatePassword,
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        readOnly: false,
                        isPasswordField: true,
                        focusNode: _confirmPasswordFocus,
                        placeholder: AppString.confirmPassword,
                        borderColor: AppColors.navyBlue,
                        isObscure: true,
                      ),
                      const SizedBox(height: 18),
                      // Reset Password Button
                      Consumer<UIProvider>(
                        builder: (context, consumer, child) =>
                            CustomElevatedButton(
                          isAnimate: consumer.loading,
                          onPressed: consumer.loading
                              ? () {}
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    consumer.loaderTrue();
                                    await ApiServiceProvider()
                                        .resetPasswordProvider(
                                            context: context,
                                            body: {
                                          'email': widget.email,
                                          'password': _passwordController.text,
                                          'confirm_password':
                                              _confirmPasswordController.text,
                                        });
                                    consumer.loaderFalse();
                                  }
                                },
                          elevation: 0,
                          borderColor: AppColors.transparent,
                          buttonColor: AppColors.navyBlue,
                          buttonSize: Size(size.width, 52),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            child: Text(
                              AppString.resetMyPassword,
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
              ),
              // Loading Screen
              uiProvider.loading
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
          ),
        );
      }),
    );
  }
}
