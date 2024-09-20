import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/account/account_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/root/root_view_model.dart';
import 'package:styld_stylist/ui/screens/stylist_side/home_stylist/home_screen.dart';
import 'package:styld_stylist/ui/screens/stylist_side/orders_stylist/orders_stylist_screen.dart';

class StylistRootScreen extends StatefulWidget {
  const StylistRootScreen({Key? key}) : super(key: key);

  @override
  State<StylistRootScreen> createState() => _StylistRootScreenState();
}

class _StylistRootScreenState extends State<StylistRootScreen> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    // Container(),
    StylistHomeScreen(),
    const StylistOrderScreen(),
    AccountScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootViewModel(),
      child: Consumer<RootViewModel>(
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () => model.onWillPop(),
            child: Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: StyldColors.blue,
                  unselectedItemColor: StyldColors.white,
                  currentIndex: _selectedIndex,
                  selectedItemColor: StyldColors.brightGold,
                  onTap: _onItemTapped,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StyldImages.homeIcon,
                        color: _selectedIndex == 0
                            ? StyldColors.brightGold
                            : StyldColors.white,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StyldImages.calendarIcon,
                        color: _selectedIndex == 1
                            ? StyldColors.brightGold
                            : StyldColors.white,
                      ),
                      label: 'Appts',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        StyldImages.accountSettingsIcon,
                        color: _selectedIndex == 2
                            ? StyldColors.brightGold
                            : StyldColors.white,
                      ),
                      label: 'Account',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
