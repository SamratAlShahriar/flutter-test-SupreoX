import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfoody/core/config/providers/providers.dart';
import 'package:flutterfoody/core/config/routes/routes.dart';
import 'package:flutterfoody/core/utils/di.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 746),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: AppProvider.providers,
        child: MaterialApp(
          title: 'Flutter Foody',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouter.cartPage,
          onGenerateRoute: AppRouter.onGenerateRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
