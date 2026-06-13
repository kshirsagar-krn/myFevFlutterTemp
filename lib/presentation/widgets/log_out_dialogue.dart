// ignore_for_file: unused_local_variable
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/presentation/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/constant/app_color.dart';
import '../../domain/repo/auth_repo.dart';
import '../../generated/assets.dart';
import '../bloc/log/log_in/bloc_log.dart';
import '../bloc/log/log_in/bloc_state.dart';
import '../screens/splash_screen.dart';
import 'custom_button.dart';

class LogOutDialogue {
  static Future<dynamic> dialogue(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                  ),
                  child: SvgPicture.asset(
                    Assets.svgsTriangleAlert,
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                ),
                SizedBox(height: 10),
                Text(context.translate("sign_out_moment"), style: context.heading),
                Text(
                  context.translate("logout_confirm"),
                  style: context.label.copyWith(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: context.translate("cancel"),
                        onTap: () => Navigator.pop(context),

                        backgroundColor: AppColor.darkBorder,
                      ),
                    ),
                    SizedBox(width: 16),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        // if (state is LogOutProfileSuccess) {
                        //   await AuthRepo().clearStoredCredentials();
                        //   Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SplashScreen(),
                        //     ),
                        //     (context) => false,
                        //   );
                        // }
                      },
                      builder: (context, state) {
                        return Expanded(
                          child: CustomButton(
                            backgroundColor: Colors.red,
                            text: context.translate("yes_signout"),
                            onTap: () async {
                              // String token = await AuthRepo().getToken() ?? "";
                              // if (token.isNotEmpty) {
                              //   if (!context.mounted) return;
                              //   context.read<LoginBloc>().add(LogOutProfile());
                              // }
                              final navigator = Navigator.of(context);
                              await AuthRepo().clearStoredCredentials();
                              navigator.pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const SplashScreen(),
                                ),
                                (context) => false,
                              );
                            },
                            // enabledColor: AppColor.error.darken(0.03),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
