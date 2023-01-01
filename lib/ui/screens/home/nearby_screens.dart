import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/ui/components/custom_text_form_field.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_strings.dart';

class NearByScreens extends StatefulWidget {
  const NearByScreens({super.key});

  @override
  State<NearByScreens> createState() => _NearByScreensState();
}

class _NearByScreensState extends State<NearByScreens> {
  late TextEditingController _searchTextEditingController;
  late FocusNode _searchFocus;

  @override
  void initState() {
    super.initState();

    _searchTextEditingController = TextEditingController();
    _searchFocus = FocusNode();
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        elevation: 0.0,
        title: Text(
          'Nearby',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: AppColors.white,
          ),
        ),

        // TODO: Notifications, favorites & search
        actions: const [],
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 18, bottom: 30, left: 21, right: 19),
        children: [
          CustomTextField(
            controller: _searchTextEditingController,
            focusNode: _searchFocus,
            isObscure: false,
            readOnly: false,
            textInputAction: TextInputAction.done,
            placeholder: AppString.searchForItems,
          ),
          const SizedBox(height: 17),
          Container(
            height: 395,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('Map'),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Selected Location",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Bhangel, Greater Noida, 201306",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
