import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';

class PopularCategoriesScreen extends StatefulWidget {
  const PopularCategoriesScreen({super.key});

  @override
  State<PopularCategoriesScreen> createState() =>
      _PopularCategoriesScreenState();
}

class _PopularCategoriesScreenState extends State<PopularCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
        ),
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Popular Categories',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),
      ),
      //  appBar: AppBar(
      //     automaticallyImplyLeading: true,
      //     foregroundColor: AppColors.black,
      //     systemOverlayStyle: const SystemUiOverlayStyle(
      //       statusBarColor: Colors.transparent,
      //       systemStatusBarContrastEnforced: true,
      //     ),
      //     centerTitle: true,
      //     title: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Image.asset(
      //           AppAssetImages.homePlace,
      //           color: AppColors.black,
      //           height: 17,
      //           width: 17,
      //         ),
      //         const SizedBox(width: 3),
      //         DropdownButton(
      //           value: dropDownValue,
      //           onChanged: (val) {
      //             setState(() {
      //               dropDownValue = val;
      //             });
      //           },
      //           items: const [
      //             DropdownMenuItem(
      //               value: 0,
      //               child: Text('Delhi'),
      //             ),
      //             DropdownMenuItem(
      //               value: 1,
      //               child: Text('Noida'),
      //             ),
      //             DropdownMenuItem(
      //               value: 2,
      //               child: Text('Bareilly'),
      //             ),
      //             DropdownMenuItem(
      //               value: 3,
      //               child: Text('Chandigarh'),
      //             ),
      //             DropdownMenuItem(
      //               value: 4,
      //               child: Text('Jalandhar'),
      //             ),
      //             DropdownMenuItem(
      //               value: 5,
      //               child: Text(
      //                 'Shahjahanpur',
      //               ),
      //             ),
      //           ],
      //           underline: const SizedBox(height: 0),
      //         ),
      //       ],
      //     ),
      //     actions: [
      //       // Favorites
      //       InkWell(
      //         onTap: () {
      //           !isSignIn
      //               ? Navigator.pushNamed(context, AppRoutes.signInScreen)
      //               : Navigator.pushNamed(context, AppRoutes.myListScreen);
      //         },
      //         child: SizedBox(
      //           width: 26,
      //           child: Stack(
      //             alignment: Alignment.topRight,
      //             children: [
      //               const Padding(
      //                 padding: EdgeInsets.only(top: 17, right: 6),
      //                 child: Icon(
      //                   Icons.favorite_border_outlined,
      //                   color: AppColors.black,
      //                   size: 22,
      //                 ),
      //               ),
      //               Positioned(
      //                 top: 12,
      //                 // right: 2,
      //                 left: 12,
      //                 child: CircleAvatar(
      //                   radius: 7,
      //                   backgroundColor: Colors.red,
      //                   child: Center(
      //                     child: Text(
      //                       '0',
      //                       style: GoogleFonts.montserrat(
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 9,
      //                         color: AppColors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       // Notifications
      //       InkWell(
      //         onTap: () {
      //           !isSignIn
      //               ? Navigator.pushNamed(context, AppRoutes.signInScreen)
      //               : log('Notifications');
      //         },
      //         child: SizedBox(
      //           width: 26,
      //           child: Stack(
      //             alignment: Alignment.topRight,
      //             children: [
      //               const Padding(
      //                 padding: EdgeInsets.only(top: 17, right: 6),
      //                 child: Icon(
      //                   Icons.notifications_none,
      //                   color: AppColors.black,
      //                   size: 22,
      //                 ),
      //               ),
      //               Positioned(
      //                 top: 12,
      //                 left: 12,
      //                 child: CircleAvatar(
      //                   radius: 7,
      //                   backgroundColor: Colors.red,
      //                   child: Center(
      //                     child: Text(
      //                       '0',
      //                       style: GoogleFonts.montserrat(
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 9,
      //                         color: AppColors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       const SizedBox(width: 10)
      //     ],
      //     elevation: 0.0,
      //     backgroundColor: AppColors.whiteBackground,
      //   ),
    );
  }
}
