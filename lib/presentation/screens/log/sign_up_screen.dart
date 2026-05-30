import 'dart:developer';
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/data/models/city_model.dart';
import 'package:myFevTempV1/data/models/country_model.dart';
import 'package:myFevTempV1/data/models/gender_model.dart';
import 'package:myFevTempV1/data/models/state_model.dart';
import 'package:myFevTempV1/data/models/user_model.dart';
import 'package:myFevTempV1/domain/repo/auth_repo.dart';
import 'package:myFevTempV1/domain/use_cases/extrta_methods.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/city/city_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/city/city_event.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/city/city_state.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/country/country_state.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/gender/gender_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/states/statas_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/states/states_event.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/states/states_state.dart';
import 'package:myFevTempV1/presentation/bloc/log/log_in/bloc_event.dart';
import 'package:myFevTempV1/presentation/widgets/custom_button.dart';
import 'package:myFevTempV1/presentation/widgets/custom_datetime_picker.dart';
import 'package:myFevTempV1/presentation/widgets/custom_decoration.dart';
import 'package:myFevTempV1/presentation/widgets/generic_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/constant/api_constant.dart';
import '../../bloc/dropdown/country/country_bloc.dart';
import '../../bloc/dropdown/country/country_event.dart';
import '../../bloc/log/log_in/bloc_log.dart';
import '../../bloc/log/log_in/bloc_state.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/custom_image_viwer.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String? mobileNumber;
  final UserModel? userMOdel;
  const SignUpScreen({super.key, this.mobileNumber, this.userMOdel});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ─── Page Controller ──────────────────────────────────────────────────────
  PageController pageController = PageController();
  int currentPage = 0;
  // ─── Form Keys ────────────────────────────────────────────────────────────
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _addressInfoFormKey = GlobalKey<FormState>();

  // ─── Basic Info Controllers ───────────────────────────────────────────────
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  XFile? xFile;
  String documentUrl = "";

  // ─── Address Info Controllers ─────────────────────────────────────────────
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  // ─── Dropdown Data ────────────────────────────────────────────────────────
  CountryModel? _selectedCountry;
  StateModel? _selectedState;
  CityModel? _selectedCity;
  GenderModel? _gender;

  //
  var countryList = <CountryModel>[];
  var stateList = <StateModel>[];
  var cityList = <CityModel>[];
  var genderList = <GenderModel>[];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _mobileController.text = widget.mobileNumber ?? '';
      });
      context.read<CountryBloc>().add(FetchCountry());
      context.read<GenderBloc>().add(GetGender());
    });
  }

  bool isSupportedFormat(XFile file) {
    // Extract the extension from the file name and convert to lowercase
    final String extension = file.name.split('.').last.toLowerCase();

    // Define your allowed formats
    const List<String> supportedExtensions = ['png', 'jpg', 'jpeg'];

    // Return true if the extension is in the list
    return supportedExtensions.contains(extension);
  }

  @override
  void dispose() {
    pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [_basicInfo(context), _addressInfo(context)],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                if ((pageController.hasClients
                        ? (pageController.page?.round() ?? 0)
                        : 0) ==
                    1) ...[
                  CustomButton(
                    // text: "Login",
                    backgroundColor: context.textPrimaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.arrow_left,
                          color: AppColor.lightBackground,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Back",
                          style: context.subtitle.copyWith(
                            color: AppColor.lightBackground,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                  ),
                  SizedBox(width: 12),
                ],

                Expanded(
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) async {
                      if (state is UserSignUpSuccess) {
                        Fluttertoast.showToast(msg: state.message);
                        if (widget.mobileNumber?.isNotEmpty ?? false) {
                          await AuthRepo().saveToken(token: state.userToken!);
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(),
                          //   ),
                          //   (context) => false,
                          // );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (context) => false,
                          );
                        }
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
                              (pageController.hasClients
                                          ? (pageController.page?.round() ?? 0)
                                          : 0) ==
                                      0
                                  ? "Next"
                                  : "Create Account",
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
                        onTap: () async {
                          if ((pageController.hasClients
                                  ? (pageController.page?.round() ?? 0)
                                  : 0) ==
                              0) {
                            if (_basicInfoFormKey.currentState?.validate() ??
                                false) {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear,
                              );
                            }
                          } else {
                            log("dfkjdsbfvjkdsv");
                            if (_addressInfoFormKey.currentState?.validate() ??
                                false) {
                              /// order success
                              context.read<LoginBloc>().add(
                                UserSignUp(
                                  body: {
                                    "OPERATION_TYPE": "ADD",
                                    // "CUSTOMERID":
                                    //     "241426FF-BB25-4474-A17B-16BC2905DF59",
                                    "FULLNAME":
                                        "${_firstNameController.text} ${_lastNameController.text}",
                                    "DOB": _dobController.text,
                                    "GENDERID": _gender?.genderId ?? '',
                                    "EMAIL": _emailController.text,
                                    "MOBILENUMBER": _mobileController.text,
                                    "ADDRESS": _addressController.text,
                                    "PINCODE": _pincodeController.text,
                                    "COUNTRYID":
                                        _selectedCountry?.countryid ?? "",
                                    "STATEID": _selectedState?.stateid ?? "",
                                    "CITYID": _selectedCity?.cityid ?? "",
                                    "ISACTIVE": true,
                                    "DeviceId":
                                        await AuthRepo.generateDeviceId(),
                                  },
                                  profilePictureData: xFile,
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ShaderMask _shaderMask() {
    return ShaderMask(
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
    );
  }

  Widget _basicInfo(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _shaderMask(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _basicInfoFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Create Account",
                    style: context.heading.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Enter your basic details. We will send you a confirmation code there",
                    textAlign: TextAlign.start,
                    style: context.sublabel.copyWith(
                      fontSize: 14,
                      height: 1.4,
                      color: context.textLabelolor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "First Name".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex. your name",
                      prefixIcon: Icon(LucideIcons.folder_pen, size: 20),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "Last Name".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex. abcd",
                      prefixIcon: Icon(LucideIcons.at_sign, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Email Address".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email address";
                      } else if (!value.isValidEmail) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex. abcd@axample.com",
                      prefixIcon: Icon(LucideIcons.mail_open, size: 20),
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
                      if (value.isNullOrEmpty) {
                        return "Please enter your mobile number";
                      }
                      return null;
                    },
                    controller: _mobileController,
                    readOnly: widget.mobileNumber != null,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex.9876....3210",
                      prefixIcon: Icon(LucideIcons.notebook_tabs, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "DOB".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                    controller: _dobController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex.DD MMM YYYY",
                      prefixIcon: Icon(LucideIcons.cake, size: 20),
                      suffixIcon: CustomDateAndTime(
                        lastDate: DateTime.now().add(
                          Duration(days: -(16 * 356)),
                        ),
                        onSelected: (dateTime, dateString) {
                          setState(() {
                            _dobController.text = dateString!;
                          });
                        },
                        child: Icon(LucideIcons.calendar_days, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Gender".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<GenderBloc, GenderState>(
                    builder: (context, state) {
                      if (state is GenderSuccess) {
                        genderList = state.genderModel;
                      }
                      return TextFormField(
                        onTap: () {
                          // context.read<GenderBloc>().add(GetGender());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenericSearchScreen(
                                screenTitle: "Search Gender",
                                items: genderList,
                                searchFields: (gender) => [
                                  gender.genderName ?? '',
                                ],
                                itemTitle: (gender) => gender.genderName ?? '',
                                onItemSelected: (p1) {
                                  setState(() {
                                    _gender = p1;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        validator: (value) {
                          if (value.isNullOrEmpty) {
                            return "Please enter your gender";
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _gender?.genderName,
                        ),
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Ex.Male, Female",
                          prefixIcon: Icon(LucideIcons.flag, size: 20),
                          suffixIcon: Icon(LucideIcons.chevron_down, size: 20),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "PROFILE IMAGE".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CustomImagePicker(
                    fieldEnable:
                        xFile == null &&
                        (documentUrl == "" || documentUrl.isEmpty),
                    onSingleFile: (value) {
                      setState(() {
                        if (isSupportedFormat(value)) {
                          xFile = value;
                        } else {
                          Fluttertoast.showToast(
                            msg: "Unsupported file format. ❌",
                          );
                        }
                      });
                    },
                    child: IgnorePointer(
                      ignoring:
                          xFile == null &&
                          (documentUrl == "" || documentUrl.isEmpty),
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text:
                              xFile?.path.split("/").last ??
                              documentUrl.split("/").last,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Upload supporting document",
                          suffixIcon: _buildProfilePictureIcon(),
                          prefixIcon: Icon(LucideIcons.image_plus, size: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePictureIcon() {
    if (xFile == null && (documentUrl == "" || documentUrl.isEmpty)) {
      return Transform.translate(
        offset: const Offset(0, 0),
        child: Transform.scale(scale: 0.7, child: Icon(LucideIcons.paperclip)),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomImageViewer(
                  singleImageFile: xFile,
                  networkImgUrl: "${ApiConstant.baseUrl}$documentUrl",
                  enableZoom: true,
                ),
              ),
            );
          },
          child: Transform.scale(scale: 0.8, child: Icon(LucideIcons.eye)),
        ),
        const SizedBox(width: 14),
        GestureDetector(
          onTap: () {
            setState(() {
              xFile = null;
              documentUrl = "";
            });
          },
          child: Transform.scale(scale: 0.8, child: Icon(LucideIcons.x)),
        ),
        const SizedBox(width: 13),
      ],
    );
  }

  Widget _addressInfo(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _shaderMask(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _addressInfoFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Address Info",
                    style: context.heading.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Enter your Address details. We will send you a confirmation code there",
                    textAlign: TextAlign.start,
                    style: context.sublabel.copyWith(
                      fontSize: 14,
                      height: 1.4,
                      color: context.textLabelolor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "ADDRESS".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value.isNullOrEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex. Your current address",
                      prefixIcon: Icon(LucideIcons.map_pin_house, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "PINCODE".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    validator: (value) {
                      if (value.isNullOrEmpty) {
                        return "Please enter your pincode";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: CustomDecoration.input(
                      context: context,
                      hintText: "Ex. 98X-XX9",
                      prefixIcon: Icon(
                        LucideIcons.flag_triangle_right,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "COUNTRY".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<CountryBloc, CountryState>(
                    builder: (context, state) {
                      if (state is CountrySuccess) {
                        countryList = state.countryModel;
                      }
                      return TextFormField(
                        enabled: countryList.isNotEmpty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenericSearchScreen(
                                screenTitle: "Search Country",
                                items: countryList,
                                searchFields: (c) => [c.countryname ?? ''],
                                itemTitle: (c) => c.countryname ?? '',
                                onItemSelected: (p1) {
                                  setState(() {
                                    _selectedCountry = p1;
                                    _selectedState = null;
                                    _selectedCity = null;
                                    stateList.clear();
                                    cityList.clear();
                                  });
                                  context.read<StatesBloc>().add(
                                    FetchState(id: p1.countryid),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        validator: (value) {
                          if (value.isNullOrEmpty) {
                            return "Please enter your country";
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _selectedCountry?.countryname,
                        ),
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Ex.India, Uk",
                          prefixIcon: Icon(LucideIcons.flag, size: 20),
                          suffixIcon: Icon(LucideIcons.chevron_down, size: 20),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "STATE".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<StatesBloc, StatesState>(
                    builder: (context, state) {
                      if (state is StateSuccess) {
                        stateList = state.stateModel;
                      }
                      return TextFormField(
                        enabled: stateList.isNotEmpty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenericSearchScreen(
                                screenTitle: "Search State",
                                searchHint: "Search State",
                                items: stateList,
                                searchFields: (state) => [
                                  state.statename ?? '',
                                ],
                                itemTitle: (state) => state.statename ?? '',
                                onItemSelected: (state) {
                                  setState(() {
                                    _selectedState = state;
                                    _selectedCity = null;
                                    cityList.clear();
                                  });
                                  context.read<CitysBloc>().add(
                                    FetchCitys(id: state.stateid),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        validator: (value) {
                          if (value.isNullOrEmpty) {
                            return "Please enter your state";
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _selectedState?.statename,
                        ),
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Ex.Maharashtra, Gujarat or more",
                          prefixIcon: Icon(LucideIcons.map, size: 20),
                          suffixIcon: Icon(LucideIcons.chevron_down, size: 20),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "CITY".toUpperCase(),
                    style: context.label.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<CitysBloc, CitysState>(
                    builder: (context, state) {
                      if (state is CitySuccess) {
                        cityList = state.cityModel;
                      }
                      return TextFormField(
                        enabled: cityList.isNotEmpty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenericSearchScreen(
                                screenTitle: "Search City",
                                items: cityList,
                                searchFields: (city) => [city.cityname ?? ''],
                                itemTitle: (city) => city.cityname ?? '',
                                onItemSelected: (city) {
                                  setState(() {
                                    _selectedCity = city;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        validator: (value) {
                          if (value.isNullOrEmpty) {
                            return "Please enter your city";
                          }
                          return null;
                        },
                        controller: TextEditingController(
                          text: _selectedCity?.cityname,
                        ),
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        decoration: CustomDecoration.input(
                          context: context,
                          hintText: "Ex. City Name",
                          prefixIcon: Icon(LucideIcons.map_pin, size: 20),
                          suffixIcon: Icon(LucideIcons.chevron_down, size: 20),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
