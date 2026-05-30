import 'dart:convert';
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_log.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_state.dart';
import 'package:myFevTempV1/presentation/screens/log/otp_screen.dart';
import 'package:myFevTempV1/presentation/widgets/custom_button.dart';
import 'package:myFevTempV1/presentation/widgets/custom_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/models/country_flag_model.dart';
import '../../bloc/log/log_in/bloc_event.dart';
import '../../widgets/custom_image.dart';
// import 'country_search.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CountryFlagModel? selectedCountry;
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Load default country (India)
    _loadDefaultCountry();
  }

  void _loadDefaultCountry() {
    Map<String, dynamic> jsonMap = json.decode(CountriesData.jsonString);
    List<dynamic> countriesList = jsonMap['countries'];
    List<CountryFlagModel> countries = countriesList
        .map((country) => CountryFlagModel.fromJson(country))
        .toList();
    setState(() {
      selectedCountry = countries.firstWhere(
        (country) => country.countryCode == '+91',
        orElse: () => countries.first,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Container(
            height: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              // color: context.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Login to your\nAccount",
                        style: context.heading.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Enter your phone number. We will send\nyou a confirmation code there",
                        textAlign: TextAlign.start,
                        style: context.sublabel.copyWith(
                          fontSize: 14,
                          height: 1.4,
                          color: context.textLabelolor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Select Country".toUpperCase(),
                        style: context.label.copyWith(
                          color: context.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        enabled: false,
                        readOnly: true,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => CountrySearchScreen(
                        //         selectedCountry: selectedCountry,
                        //         onCountrySelected: (CountryModel p1) {
                        //           setState(() {
                        //             selectedCountry = p1;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //   );
                        // },
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                          text:
                              "(${selectedCountry?.countryCode}) ${selectedCountry?.countryName}",
                        ),
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Ex. 9876....3210",
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 16),
                              Text(
                                selectedCountry?.flag ?? '',
                                style: context.heading.copyWith(fontSize: 20),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          suffixIcon: Icon(LucideIcons.chevron_down, size: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Mobile Number".toUpperCase(),
                        style: context.label.copyWith(
                          color: context.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length < selectedCountry!.minDigit) {
                            return 'Please enter a valid phone number';
                          } else if (value.length > selectedCountry!.maxDigit) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            selectedCountry?.maxDigit,
                          ),
                        ],
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: selectedCountry?.eg ?? 'Eg. 9876543210',
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 16),
                              Icon(LucideIcons.book_user, size: 20),
                              SizedBox(width: 4),
                              Text(
                                '${selectedCountry?.countryCode} ',
                                style: context.label,
                              ),
                              SizedBox(width: 6),
                              SizedBox(
                                height: 20,
                                child: VerticalDivider(width: 1),
                              ),
                              SizedBox(width: 6),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Do not have an account? Sign up",
                        style: context.label.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Fluttertoast.showToast(msg: state.message);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        mobileNumber: phoneController.text,
                        reqId: state.requestId,
                      ),
                    ),
                  );
                } else if (state is LoginFailed) {
                  Fluttertoast.showToast(msg: state.errorMEssage);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  isLoading: state is LoginLoading,
                  // text: "Login",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Send OTP",
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
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<LoginBloc>().add(
                        SendOtp(mobileNumber: phoneController.text),
                      );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "By creating a account, I agree to eSmart Queue ",
                style: context.label.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.textSecondaryColor,
                ),
                children: [
                  TextSpan(
                    text: "Terms & Services ",
                    style: context.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: "and ",
                    style: context.label.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: context.label.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
