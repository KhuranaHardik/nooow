import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SelectIntrestScreen extends StatefulWidget {
  const SelectIntrestScreen({super.key});

  @override
  State<SelectIntrestScreen> createState() => _SelectIntrestScreenState();
}

class _SelectIntrestScreenState extends State<SelectIntrestScreen> {
  final ApiServiceProvider _apiServiceProvider = ApiServiceProvider();
  final UIProvider _uiProvider = UIProvider();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      _uiProvider.loaderTrue();
      await _apiServiceProvider.categoryList(context);
      _uiProvider.loaderFalse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: AppColors.navyBlue,
        centerTitle: false,
        titleSpacing: -35,
        title: Text(
          'Select Category',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            children: [
              Text(
                'Choose Categories',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Select Your Intrested Categories and Get Exciting Offers',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                    fontSize: 14,
                    height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: List.generate(
                  _apiServiceProvider.categorylist?.length ?? 0,
                  (index) => Container(
                    // width: 20,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.lightGrey,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      (_apiServiceProvider.categorylist ==
                                                  null ||
                                              _apiServiceProvider
                                                      .categorylist ==
                                                  null ||
                                              _apiServiceProvider
                                                  .categorylist!.isEmpty)
                                          ? const AssetImage(
                                                  AppAssetImages.fashion)
                                              as ImageProvider
                                          : NetworkImage(_apiServiceProvider
                                                  .categorylist?[index]
                                              ?['slider']))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomElevatedButton(
                onPressed: () {},
                buttonColor: AppColors.navyBlue,
                borderColor: AppColors.navyBlue,
                child: Text(
                  'Save & Continue',
                  style: GoogleFonts.montserrat(color: AppColors.white),
                ),
              )
            ],
          ),
          Consumer<UIProvider>(
            builder: (context, uiProvider, child) => uiProvider.loading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.white.withOpacity(0.8),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.navyBlue,
                    )),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
