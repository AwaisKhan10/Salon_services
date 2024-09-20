import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/beauty_saloon_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/icon_textfield.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/beautySaloonSearch/search_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/all_stylist/all_stylist_screen.dart';

class BeautySaloonSearchScreen extends StatelessWidget {
  BeautySaloonSearchScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      child: Consumer<SearchViewModel>(builder: (contex, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: StyldColors.black,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(StyldImages.backIcon),
            ),
            title: Text(
              'Beauty Saloons',
              style: GoogleFonts.roboto(textStyle: r_22),
            ),
            centerTitle: true,
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IconTextField(
                    onChange: (value) {
                      model.searchStylists(value);
                    },
                    action: () => Get.to(() => BeautySaloonSearchScreen()),
                    controller: _searchController,
                    title: 'Search results for \'Saloon\'',
                    iconPath: StyldImages.searchIcon),
              ),
              Expanded(
                child: model.isSearching
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Get.to(() => AllStylistsScreen(
                                model.searchServices[index].name)),
                            child:
                                BeautySaloonTile(model.searchServices[index]),
                          );
                        },
                        itemCount: model.searchServices.length,
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Get.to(() =>
                                AllStylistsScreen(model.services[index].name)),
                            child: BeautySaloonTile(model.services[index]),
                          );
                        },
                        itemCount: model.services.length,
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
