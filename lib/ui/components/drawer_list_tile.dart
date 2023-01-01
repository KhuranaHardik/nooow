import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/utils/app_colors.dart';

class DrawerListTile extends StatelessWidget {
  final String iconPath;
  final String tileTitle;
  final bool isDropDown;
  final Function()? onTap;
  const DrawerListTile({
    super.key,
    required this.iconPath,
    required this.tileTitle,
    required this.isDropDown,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      tileColor: AppColors.drawerListItemColor,
      title: Row(
        children: [
          Image.asset(
            iconPath,
            height: 16,
            width: 16,
          ),
          const SizedBox(width: 7),
          Text(
            tileTitle,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          isDropDown
              ? DropdownButton(
                  iconDisabledColor: AppColors.black,
                  iconEnabledColor: AppColors.black,
                  items: const [],
                  onChanged: (val) {},
                )
              : const SizedBox.shrink(),
        ],
      ),
      onTap: onTap,
    );
  }
}
