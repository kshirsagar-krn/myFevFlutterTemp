import 'dart:developer';
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_event.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_log.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_state.dart';
import 'package:myFevTempV1/presentation/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../domain/repo/auth_repo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image.dart';
import 'sign_up_screen.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String reqId;
  const OtpScreen({super.key, required this.mobileNumber, required this.reqId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpController otpController = OtpController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white.withValues(alpha: 0.01),
      ),
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white, // Opacity 1 at top
                  Colors.white.withOpacity(0.0), // Opacity 0 at bottom
                ],
                stops: [0.0, 1.0], // Adjust stops as needed
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn, // Keeps image opacity based on gradient
            child: CustomImage(
              imageUrl:
                  "https://img.magnific.com/free-vector/abstract-geometric-design_1048-12109.jpg?semt=ais_hybrid&w=740&q=80",
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 110),
                Text(
                  "6-Digit Code",
                  style: context.heading.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Code sent to +91 9876543210 unless you\nalredy have a account",
                  textAlign: TextAlign.start,
                  style: context.sublabel.copyWith(
                    fontSize: 14,
                    height: 1.4,
                    color: context.textLabelolor,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: OtpInput(
                    autoFocus: true,
                    controller: otpController,
                    onCompleted: (otp) {
                      log('OTP entered: $otp');
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Resend Otp? 1.23 Sec.",
                  style: context.label.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is VerifyOtpSuccess) {
                  Fluttertoast.showToast(msg: state.message);
                  if (state.userToken?.isNotEmpty ?? false) {
                    await AuthRepo().saveToken(token: state.userToken!);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    //   (cnxt) => false,
                    // );
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SignUpScreen(mobileNumber: widget.mobileNumber),
                      ),
                      (cnxt) => false,
                    );
                  }
                } else if (state is LoginFailed) {
                  Fluttertoast.showToast(msg: state.errorMEssage);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  isLoading: state is LoginLoading,
                  isEnabled: otpController.value.length == 6,
                  // text: "Login",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Verify OTP",
                        style: context.subtitle.copyWith(
                          color: AppColor.lightBackground,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        LucideIcons.arrow_right,
                        color: AppColor.lightBackground,
                      ),
                    ],
                  ),
                  onTap: () {
                    context.read<LoginBloc>().add(
                      VerifyOtp(otp: otpController.value, reqId: widget.reqId),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
