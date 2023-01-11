import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nooow/provider/api_services_provider.dart';
import 'package:nooow/provider/ui_provider.dart';
import 'package:nooow/ui/components/custom_elevated_button.dart';
import 'package:nooow/utils/app_asset_images.dart';
import 'package:nooow/utils/app_colors.dart';
import 'package:nooow/utils/app_routes.dart';
import 'package:provider/provider.dart';

class SelectIntrestScreen extends StatefulWidget {
  const SelectIntrestScreen({super.key});

  @override
  State<SelectIntrestScreen> createState() => _SelectIntrestScreenState();
}

class _SelectIntrestScreenState extends State<SelectIntrestScreen> {
  late final ApiServiceProvider _apiServiceProvider;
  late final UIProvider _uiProvider;
  final List<String> _selectCategory = [];
  @override
  void initState() {
    super.initState();
    _apiServiceProvider =
        Provider.of<ApiServiceProvider>(context, listen: false);
    _uiProvider = Provider.of<UIProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.homeScreen);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 18),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer<ApiServiceProvider>(
                      builder: (context, apiServiceConsumer, child) {
                        return Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 15,
                            runSpacing: 20,
                            children: List.generate(
                              apiServiceConsumer.categorylist?.length ?? 0,
                              (index) => Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_selectCategory.contains(
                                          apiServiceConsumer
                                              .categorylist?[index]?['id'])) {
                                        setState(() {
                                          _selectCategory.remove(
                                              apiServiceConsumer
                                                  .categorylist?[index]?['id']);
                                        });
                                      } else {
                                        setState(() {
                                          _selectCategory.add(apiServiceConsumer
                                              .categorylist?[index]?['id']);
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 10, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.lighterGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.lightGrey,
                                              ),
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image:
                                                      (apiServiceConsumer
                                                                      .categorylist ==
                                                                  null ||
                                                              apiServiceConsumer
                                                                      .categorylist ==
                                                                  null ||
                                                              apiServiceConsumer
                                                                  .categorylist!
                                                                  .isEmpty)
                                                          ? const AssetImage(
                                                                  AppAssetImages
                                                                      .fashion)
                                                              as ImageProvider
                                                          : NetworkImage(
                                                              apiServiceConsumer
                                                                      .categorylist?[
                                                                  index]?['image'],
                                                            ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 9.47),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  apiServiceConsumer
                                                          .categorylist?[index]
                                                      ?['title'],
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _selectCategory.contains(apiServiceConsumer
                                          .categorylist?[index]?['id'])
                                      ? const Positioned(
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.done,
                                              color: AppColors.white,
                                              size: 17,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // const Spacer(),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.homeScreen, (route) => false);
                  },
                  buttonColor: AppColors.navyBlue,
                  borderColor: AppColors.navyBlue,
                  child: Text(
                    'Save & Continue',
                    style: GoogleFonts.montserrat(color: AppColors.white),
                  ),
                ),
              ],
            ),
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
