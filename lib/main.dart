import 'package:myFevTempV1/domain/repo/dropdown_repo.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/city/city_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/country/country_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/gender/gender_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/dropdown/states/statas_bloc.dart';
import 'package:myFevTempV1/presentation/bloc/theme/theme_cubit.dart';
import 'package:myFevTempV1/presentation/bloc/language/language_cubit.dart';
import 'package:myFevTempV1/presentation/localization/app_localizations.dart';
import 'package:myFevTempV1/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/app_theme/app_theme.dart';
import 'data/local_db/local_storage.dart';
import 'domain/repo/auth_repo.dart';
import 'presentation/bloc/log/log_in/bloc_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(AuthRepo())),
        BlocProvider<CountryBloc>(
          create: (context) => CountryBloc(DropdownRepo()),
        ),
        BlocProvider<StatesBloc>(
          create: (context) => StatesBloc(DropdownRepo()),
        ),
        BlocProvider<CitysBloc>(create: (context) => CitysBloc(DropdownRepo())),
        BlocProvider<GenderBloc>(
          create: (context) => GenderBloc(DropdownRepo()),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'MyFev Template',
                themeMode: themeMode,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
