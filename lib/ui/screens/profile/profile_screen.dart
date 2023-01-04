import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/utils/app_colors.dart';

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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Favourites Pressed');
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.white,
                    size: 21,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
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
          IconButton(
            onPressed: () {
              log('Search Pressed');
            },
            icon: const Icon(Icons.search, size: 21),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: IconButton(
                  onPressed: () {
                    log('Notifications Pressed');
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 21,
                    color: AppColors.white,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: CircleAvatar(
                  radius: 10,
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 33),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(219, 219, 219, 1)),
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
                  isObscure: false,
                  readOnly: false,
                  placeholder: "Name",
                  borderColor: const Color.fromRGBO(219, 219, 219, 1),
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  controller: _mobileTextController,
                  focusNode: _mobileFocusNode,
                  textInputAction: TextInputAction.next,
                  isObscure: false,
                  readOnly: false,
                  placeholder: "Mobile",
                  borderColor: const Color.fromRGBO(219, 219, 219, 1),
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  controller: _emailTextController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  isObscure: false,
                  readOnly: false,
                  placeholder: "Email",
                  borderColor: const Color.fromRGBO(219, 219, 219, 1),
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  controller: _locationTextController,
                  focusNode: _locationFocusNode,
                  textInputAction: TextInputAction.next,
                  isObscure: false,
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
              border: Border.all(color: const Color.fromRGBO(219, 219, 219, 1)),
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
                                color: AppColors.black.withOpacity(0.75),
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
    );
  }
}
