



import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';

showLoader(){
  EasyLoading.show(indicator: LoadingAnimationWidget.fourRotatingDots(color: primaryColor, size: 25 ),dismissOnTap: true,maskType: EasyLoadingMaskType.black,);
}
stopLoader(){
  EasyLoading.dismiss();
}