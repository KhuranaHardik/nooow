// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/ui/components/drawer.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  late TextEditingController _nameTextController;
  late FocusNode _nameFocusNode;
  late TextEditingController _mobileTextController;
  late FocusNode _mobileFocusNode;
  late TextEditingController _emailTextController;
  late FocusNode _emailFocusNode;
  late TextEditingController _locationTextController;
  late FocusNode _locationFocusNode;
  late AppSharedPrefrence _appSharedPrefrence;
  bool? isUserSignedIn = false;
  bool signedIn = false;
  int sliderIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UIProvider>(context, listen: false).loaderTrue();
      isUserSignedIn = await _appSharedPrefrence.getUserSignedIn();
      setState(() {});
      log(isUserSignedIn.toString());
      Provider.of<UIProvider>(context, listen: false).loaderFalse();
    });
    _appSharedPrefrence = AppSharedPrefrence();
    _nameTextController = TextEditingController();
    _mobileTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _locationTextController = TextEditingController();
    _nameFocusNode = FocusNode();
    _mobileFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _locationFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _mobileTextController.dispose();
    _emailTextController.dispose();
    _locationTextController.dispose();
    _nameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _emailFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  bool get isSignIn => isUserSignedIn ?? false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawer(
        context: context,
        isUserSignedIn: isUserSignedIn,
        backgroundHeight: size.height * 0.18,
      ),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
        actions: [
          // Favorites
          InkWell(
            radius: 10,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.myListScreen);
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    // right: 2,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Text(
                          '0',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Notifications
          InkWell(
            onTap: () {
              log('Notifications');
            },
            child: SizedBox(
              width: 26,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 17, right: 6),
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Text(
                          '0',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2)
        ],
      ),
      body: Consumer2<UIProvider, ApiServiceProvider>(
        builder: (context, uiProvider, apiServiceProvider, child) {
          return Stack(
            children: [
              ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 33),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(219, 219, 219, 1)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile and Menu
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: const Color.fromRGBO(210, 210, 210, 1),
                              child: const CircleAvatar(radius: 32),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert),
                            )
                          ],
                        ),
                        const SizedBox(height: 19),
                        CustomTextField(
                          controller: _nameTextController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          readOnly: false,
                          placeholder: "Name",
                          borderColor: const Color.fromRGBO(219, 219, 219, 1),
                        ),
                        const SizedBox(height: 17),
                        CustomTextField(
                          controller: _mobileTextController,
                          focusNode: _mobileFocusNode,
                          textInputAction: TextInputAction.next,
                          readOnly: false,
                          placeholder: "Mobile",
                          borderColor: const Color.fromRGBO(219, 219, 219, 1),
                        ),
                        const SizedBox(height: 17),
                        CustomTextField(
                          controller: _emailTextController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          readOnly: false,
                          placeholder: "Email",
                          borderColor: const Color.fromRGBO(219, 219, 219, 1),
                        ),
                        const SizedBox(height: 17),
                        CustomTextField(
                          controller: _locationTextController,
                          focusNode: _locationFocusNode,
                          textInputAction: TextInputAction.next,
                          readOnly: false,
                          placeholder: "Location",
                          borderColor: const Color.fromRGBO(219, 219, 219, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(219, 219, 219, 1)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [
                        Text(
                          'Offers & Coupons',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 13.0),
                              child: DottedBorder(
                                radius: const Radius.circular(7),
                                color: const Color.fromRGBO(210, 210, 210, 1),
                                padding: EdgeInsets.only(
                                  top: 6,
                                  bottom: 9,
                                  left: 9,
                                  right: size.width * 0.30,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Christmas Coupon offer',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    Text(
                                      'Coupon Code : MTK1278',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color:
                                            AppColors.black.withOpacity(0.75),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
          );
        },
      ),
    );
  }
}
