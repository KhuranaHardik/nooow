import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/theme_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/services/local_db.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DrawerListTile extends StatefulWidget {
  final String iconPath;
  final String tileTitle;
  final bool isLogoutButton;
  final Function()? onTap;
  final bool isDarkmode;
  const DrawerListTile({
    super.key,
    required this.iconPath,
    required this.tileTitle,
    required this.isLogoutButton,
    required this.onTap,
    this.isDarkmode = false,
  });

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? theme = await AppSharedPrefrence().getTheme();
      isSwitchOn = (theme == 'light' || theme == null) ? false : true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UIProvider, ThemeProvider>(
      builder: (context, uiProvider, themeProvider, child) {
        return ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          tileColor: AppColors.drawerListItemColor,
          title: Row(
            children: [
              Image.asset(
                widget.iconPath,
                height: 16,
                width: 16,
                color: widget.isLogoutButton
                    ? AppColors.notificationsColor
                    : AppColors.navyBlue,
              ),
              const SizedBox(width: 7),
              Text(
                widget.tileTitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: widget.isDarkmode
              ? Switch.adaptive(
                  activeColor: AppColors.navyBlue,
                  value: isSwitchOn,
                  onChanged: (val) {
                    uiProvider.loaderTrue();
                    isSwitchOn = uiProvider.updateSwitch(isSwitchOn);
                    isSwitchOn
                        ? themeProvider.setDarkMode()
                        : themeProvider.setLightMode();
                    uiProvider.loaderFalse();
                  },
                )
              : null,
          onTap: widget.onTap,
        );
      },
    );
  }
}
