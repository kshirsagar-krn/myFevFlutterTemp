import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: AppColor.primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.house, size: 26),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.history, size: 26),
            label: "Attendance",
          ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     padding: EdgeInsets.all(14),
          //     decoration: BoxDecoration(
          //       color: AppColor.primaryColor,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(LucideIcons.qr_code, size: 22, color: Colors.white),
          //   ),
          //   label: "dailycontent",
          // ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.tickets_plane, size: 26),
            label: "Calender",
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.circle_user, size: 26),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
