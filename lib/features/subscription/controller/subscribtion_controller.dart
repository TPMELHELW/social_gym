import 'package:get/get.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/persentation/signup/verify_screen.dart';
import 'package:gym_app/features/subscription/model/page_model.dart';

class SubscribtionController extends GetxController {
  static SubscribtionController get instance =>
      Get.find<SubscribtionController>();

  final List<PageModel> pageData = [
    PageModel(
        months: '1 Months',
        date: '1/1/2024 -> 1/3/2024',
        price: '250 EG',
        imagePath: 'assets/images/poke1.png'),
    PageModel(
        months: '3 Months',
        date: '1/1/2024 -> 1/3/2024',
        price: '600 EG',
        imagePath: 'assets/images/poke2.png'),
    PageModel(
        months: '6 Months',
        date: '1/1/2024 -> 1/3/2024',
        price: '1000 EG',
        imagePath: 'assets/images/poke3.png')
  ];

  void onPress(int index) async {
    try {
      Map<String, dynamic> data = {
        'Plan': pageData[index].price,
      };
      await UserRepository().updateSingleUserInf(data);

      Get.off(() => const SubscribtionVerifyScreen());
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }
}
