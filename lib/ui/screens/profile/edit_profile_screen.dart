import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/ui/components/user_not_found_error.dart';
import 'package:nooow/ui/screens/profile/components/tile_card.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameTextController;
  late FocusNode _nameFocusNode;
  late TextEditingController _mobileTextController;
  late FocusNode _mobileFocusNode;
  late TextEditingController _emailTextController;
  late FocusNode _emailFocusNode;

  bool? isUserSignedIn;
  bool signedIn = false;
  int sliderIndex = 0;
  bool _isEdit = false;
  bool _uploadImage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UIProvider>(context, listen: false).loaderTrue();

      Provider.of<UIProvider>(context, listen: false).loaderFalse();
    });
//  required String userId,
//       required String userName,
//       required String userProfile,
//       required String userAddress,
//       required String mobileNumber,
//       required String email
// [userId, userName, userProfile, mobileNumber, email]
    _nameTextController = TextEditingController()
      ..text = (AppSharedPrefrence().userData == null ||
              AppSharedPrefrence().userData?[1] == 'null')
          ? ''
          : AppSharedPrefrence().userData?[1] ?? '';
    _mobileTextController = TextEditingController()
      ..text = (AppSharedPrefrence().userData == null ||
              AppSharedPrefrence().userData?[3] == 'null')
          ? ''
          : AppSharedPrefrence().userData?[3] ?? '';
    _emailTextController = TextEditingController()
      ..text = (AppSharedPrefrence().userData == null ||
              AppSharedPrefrence().userData?[4] == 'null')
          ? ''
          : AppSharedPrefrence().userData?[4] ?? '';

    _nameFocusNode = FocusNode();
    _mobileFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _mobileTextController.dispose();
    _emailTextController.dispose();

    _nameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  bool get isSignIn => (AppSharedPrefrence().userData == null ||
          AppSharedPrefrence().userData!.isEmpty)
      ? false
      : true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          // drawer: AppDrawer(
          //   isUserSignedIn: isSignIn,
          //   backgroundHeight: size.height * 0.18,
          // ),

          // TODO:Colour change hoga is darkmode ke basis pr
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.navyBlue,
            elevation: 0.0,
            title: Text(
              'Edit Profile',
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
                  !isSignIn
                      ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                      : Navigator.pushNamed(context, AppRoutes.myListScreen);
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
                  !isSignIn
                      ? Navigator.pushNamed(context, AppRoutes.signInScreen)
                      : Navigator.pushNamed(
                          context, AppRoutes.notificationScreen);
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
              return (isSignIn == false)
                  ? const UserNotFoundErrorWidget()
                  : Stack(
                      children: [
                        ListView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 21, vertical: 33),
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(219, 219, 219, 1)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Profile Pic & Edit
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 6),
                                                  blurRadius: 9,
                                                  color: AppColors.black
                                                      .withOpacity(0.19),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: (AppSharedPrefrence()
                                                                .userData ==
                                                            null ||
                                                        AppSharedPrefrence()
                                                            .userData!
                                                            .isEmpty ||
                                                        AppSharedPrefrence()
                                                                .userData?[2] ==
                                                            'null')
                                                    ? const AssetImage(
                                                            AppAssetImages
                                                                .defaultProfile)
                                                        as ImageProvider
                                                    : NetworkImage(
                                                        AppSharedPrefrence()
                                                            .userData![2]),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          (_isEdit || _uploadImage)
                                              ? GestureDetector(
                                                  onTap: () {},
                                                  child: Text('Change Image',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .navyBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                      const Spacer(),
                                      (_isEdit || _uploadImage)
                                          ? CustomElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isEdit = false;
                                                  _uploadImage = false;
                                                });
                                                Map<String, dynamic> body = {};
                                                body['user_id'] =
                                                    AppSharedPrefrence()
                                                        .userData?[0];
                                                body['name'] =
                                                    _nameTextController.text
                                                        .trim();
                                                body['contact'] =
                                                    _mobileTextController.text
                                                        .trim();
                                                body['email'] =
                                                    _emailTextController.text
                                                        .trim();
                                                // body['address'] =
                                                //     _locationTextController.text
                                                //         .trim();
                                                // body['pincode'] = '000000';
                                                // body['profile_image'] = '';
                                                uiProvider.loaderTrue();
                                                await ApiServiceProvider()
                                                    .updateUser(context, body);
                                                uiProvider.loaderFalse();
                                              },
                                              buttonColor: AppColors.navyBlue,
                                              borderColor: AppColors.navyBlue,
                                              child: const Text('Update'))
                                          : PopupMenuButton(
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _uploadImage = true;
                                                        });
                                                      },
                                                      child: const Center(
                                                          child: Text(
                                                              'Add Photo'))),
                                                ),
                                                PopupMenuItem(
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _isEdit = true;
                                                        });
                                                      },
                                                      child: const Center(
                                                          child: Text('Edit'))),
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  CustomTextField(
                                    controller: _nameTextController,
                                    focusNode: _nameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    readOnly: !_isEdit,
                                    placeholder: "Name",
                                    borderColor:
                                        const Color.fromRGBO(219, 219, 219, 1),
                                    isObscure: false,
                                  ),
                                  const SizedBox(height: 17),
                                  CustomTextField(
                                    controller: _mobileTextController,
                                    focusNode: _mobileFocusNode,
                                    textInputAction: TextInputAction.next,
                                    readOnly: !_isEdit,
                                    placeholder: "Mobile",
                                    borderColor:
                                        const Color.fromRGBO(219, 219, 219, 1),
                                    isObscure: false,
                                  ),
                                  const SizedBox(height: 17),
                                  CustomTextField(
                                    controller: _emailTextController,
                                    focusNode: _emailFocusNode,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    placeholder: "Email",
                                    borderColor:
                                        const Color.fromRGBO(219, 219, 219, 1),
                                    isObscure: false,
                                  ),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              "Privacy & Security",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TileCardWidget(
                              isThemeButton: false,
                              onTap: () {},
                              name: "Change Password",
                              icon: AppAssetImages.password,
                              isLogOutButton: false,
                            )
                          ],
                        ),
                        // Loading Screen
                        uiProvider.loading
                            ? Container(
                                height: size.height,
                                color:
                                    AppColors.whiteBackground.withOpacity(0.4),
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
      },
    );
  }
}
