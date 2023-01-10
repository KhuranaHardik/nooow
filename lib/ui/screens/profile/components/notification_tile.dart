import 'package:flutter/material.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UIProvider>(
      builder: (context, uiProvider, child) {
        return InkWell(
          onTap: () {},
          child: Card(
            color: AppColors.drawerListItemColor,
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.navyBlue,
                child: Image.asset(
                  AppAssetImages.notification,
                  color: AppColors.white,
                  width: 15,
                  height: 15,
                ),
              ),
              title: const Text('title'),
              subtitle: const Text('subtitle'),
            ),
          ),
        );
      },
    );
  }
}
