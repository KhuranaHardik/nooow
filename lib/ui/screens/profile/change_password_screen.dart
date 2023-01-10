import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/validator/password_validator.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _currentPasswordTextController;
  late FocusNode _currentPasswordFocusNode;
  late TextEditingController _newPasswordTextController;
  late FocusNode _newPasswordFocusNode;
  late TextEditingController _confirmNewPasswordTextController;
  late FocusNode _confirmNewPasswordFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFieldsEmpty = true;
  late List<TextEditingController> _controllerList;

  @override
  void initState() {
    super.initState();
    _currentPasswordTextController = TextEditingController();
    _currentPasswordFocusNode = FocusNode();
    _newPasswordTextController = TextEditingController();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordTextController = TextEditingController();
    _confirmNewPasswordFocusNode = FocusNode();
    _controllerList = [
      _currentPasswordTextController,
      _newPasswordTextController,
      _confirmNewPasswordTextController,
    ];
  }

  @override
  void dispose() {
    _currentPasswordTextController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordTextController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordTextController.dispose();
    _confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Change Password',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        // actions: [
        //   // Favorites
        //   InkWell(
        //     radius: 10,
        //     onTap: () {
        //       !isSignIn
        //           ? Navigator.pushNamed(context, AppRoutes.signInScreen)
        //           : Navigator.pushNamed(context, AppRoutes.myListScreen);
        //     },
        //     child: SizedBox(
        //       width: 26,
        //       child: Stack(
        //         alignment: Alignment.topRight,
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.only(top: 17, right: 6),
        //             child: Icon(
        //               Icons.favorite_border_outlined,
        //               color: AppColors.white,
        //               size: 22,
        //             ),
        //           ),
        //           Positioned(
        //             top: 12,
        //             // right: 2,
        //             left: 12,
        //             child: CircleAvatar(
        //               radius: 7,
        //               backgroundColor: Colors.red,
        //               child: Center(
        //                 child: Text(
        //                   '0',
        //                   style: GoogleFonts.montserrat(
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 9,
        //                     color: AppColors.white,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   // Notifications
        //   InkWell(
        //     onTap: () {
        //       !isSignIn
        //           ? Navigator.pushNamed(context, AppRoutes.signInScreen)
        //           : log('Notifications');
        //     },
        //     child: SizedBox(
        //       width: 26,
        //       child: Stack(
        //         alignment: Alignment.topRight,
        //         children: [
        //           const Padding(
        //             padding: EdgeInsets.only(top: 17, right: 6),
        //             child: Icon(
        //               Icons.notifications_none,
        //               color: AppColors.white,
        //               size: 22,
        //             ),
        //           ),
        //           Positioned(
        //             top: 12,
        //             left: 12,
        //             child: CircleAvatar(
        //               radius: 7,
        //               backgroundColor: Colors.red,
        //               child: Center(
        //                 child: Text(
        //                   '0',
        //                   style: GoogleFonts.montserrat(
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 9,
        //                     color: AppColors.white,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   const SizedBox(width: 2)
        // ],
      ),
      body: Consumer<UIProvider>(builder: (context, uiProvider, child) {
        return Form(
          key: _formKey,
          onChanged: () {
            _isFieldsEmpty = uiProvider.buttonColorChange(_controllerList);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            children: [
              CustomTextField(
                controller: _currentPasswordTextController,
                focusNode: _currentPasswordFocusNode,
                placeholder: "Current Password",
                textInputAction: TextInputAction.next,
                readOnly: false,
                isObscure: true,
                isPasswordField: true,
                borderColor: AppColors.lightGrey,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _newPasswordTextController,
                focusNode: _newPasswordFocusNode,
                placeholder: "New Password",
                textInputAction: TextInputAction.next,
                readOnly: false,
                isObscure: true,
                isPasswordField: true,
                borderColor: AppColors.lightGrey,
                validator: PasswordValidator().validatePassword,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _confirmNewPasswordTextController,
                focusNode: _confirmNewPasswordFocusNode,
                placeholder: "Confirm Password",
                textInputAction: TextInputAction.done,
                readOnly: false,
                isObscure: true,
                isPasswordField: true,
                borderColor: AppColors.lightGrey,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Password Required*";
                  } else if (val != _newPasswordTextController.text) {
                    return "Password do not match.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                isAnimate: uiProvider.loading,
                onPressed: _isFieldsEmpty
                    ? () {}
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          // uiProvider.loaderTrue();

                          // uiProvider.loaderFalse();
                        }
                      },
                elevation: 0,
                borderColor: AppColors.transparent,
                buttonColor: AppColors.navyBlue,
                buttonSize: Size(size.width, 52),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17.0),
                    child: Text(
                      "Change Password",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
