import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/domain/use_cases/extrta_methods.dart';
import 'package:myFevTempV1/presentation/screens/log/login_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/repo/auth_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _checkAuthAndNavigation();
    });
  }

  void _checkAuthAndNavigation() async {
    var token = await AuthRepo().getToken();
    if (mounted) {
      if (token != null) {
        // await Future.delayed(Duration(seconds: 3));
        // Navigator.pushAndRemoveUntil(
        //   // ignore: use_build_context_synchronously
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        //   (con) => false,
        // );
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (con) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.primaryColor.lighten(0.3),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                text: "My",
                style: context.heading.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(
                    text: "Fev",
                    style: context.heading.copyWith(
                      fontSize: 30,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: "Template",
                    style: context.heading.copyWith(
                      fontSize: 30,
                      // color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Follow me krn-kshirsagar@github",
              style: context.label.copyWith(
                color: context.textLabelolor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 80,
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: AppColor.primaryColor.darken(0.1),
            ),
          ),
        ),
      ),
    );
  }
}
