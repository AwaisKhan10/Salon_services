import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/account/customer_account_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/home_customer.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_orders/orders_view.dart';

class CustomerRootScreen extends StatefulWidget {
  const CustomerRootScreen({Key? key}) : super(key: key);

  @override
  State<CustomerRootScreen> createState() => _CustomerRootScreenState();
}

class _CustomerRootScreenState extends State<CustomerRootScreen> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    // Container(),
    HomeCustomerScreen(),
     OrdersView(),
     CustomerAccountScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
