import 'package:firstapp/Authentication/goole_sign_in.dart';
import 'package:firstapp/bloc/network_cubit.dart';
import 'package:firstapp/bloc/network_services.dart';
import 'package:firstapp/controller/locale_provider.dart';
import 'package:firstapp/controller/random_provider.dart';
import 'package:firstapp/l10n/localization.dart';
import 'package:firstapp/resources/route_manager.dart';
import 'package:firstapp/ui/screens/splash/splach_screen.dart';
import 'package:firstapp/user_preferences/user_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart' as prov;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  @override
  void initState() {
    super.initState();
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            LocaleProvider().setLocale(locale = Locale(value));
          })
        });
  }

  @override
  Widget build(BuildContext context) {

    var networkService = NetworkService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(
          create: (context) =>
              NetworkCubit(networkService: networkService, context: context),
        ),
      ],
    child:MultiProvider (
      providers: [
            ChangeNotifierProvider<RandomProvider>(create: (_) => RandomProvider()),
          ],
      child: prov.ChangeNotifierProvider(
          create: (_) => LocaleProvider(),
          child: prov.Consumer<LocaleProvider>(
            builder: (context, model, child) {
              return ScreenUtilInit(
                minTextAdapt: false,
                builder: (BuildContext context, Widget? child) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    onGenerateTitle: (context) =>
                        AppLocalizations.of(context)!.appName,
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    locale: model.locale ?? locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    supportedLocales: L10n.all,
                    home: SplashScreen(),
                    routes: routes,
                  );
                },
              );
            },
          ),),
    )
        );
  }
}
