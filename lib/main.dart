import 'package:directus/directus.dart';
import 'package:directus_core/directus_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/screen/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controllers/screenscontroller.dart';
import 'resource/app_colors.dart';

void main()async {
await WidgetsFlutterBinding.ensureInitialized();
try {
     await DirectusCoreSingleton.init("http://futurix-easyticket.ktiz47.easypanel.host" , storage: SharedPreferencesStorage());

   await Supabase.initialize(
    url: "https://mhqgyomuhppogybhqkfa.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ocWd5b211aHBwb2d5Ymhxa2ZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA3NDAwNzUsImV4cCI6MjAxNjMxNjA3NX0.-ln0Z8t45XRXB60rYbTWL0t4CCcHr8qA3578LDlNPYM",
  );
  // final sdk = await Directus('http://localhost:8055').init();
  // final results = await sdk.items('posts').readMany();

  runApp(const MyApp());
} catch (e) {
  print("Erreur sdk");
  print(e);
  
}

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
          Get.put(AuthController());
  Get.put(CoreController());
  Get.put(DataController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Bus link',
      builder: EasyLoading.init(),
      theme: ThemeData(
        useMaterial3: true,
          scaffoldBackgroundColor: AppColors.purpleDark,
          primarySwatch: Colors.blue,
          canvasColor: AppColors.purpleLight),
      home: Center(
        child: LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 50)
      ),
    );
  }
}
