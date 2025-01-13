import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find<ChatController>();

  final UserRepository userRepository = Get.find<UserRepository>();

  List<UserModel> userData = [];

  Future<void> getUserData() async {
    try {
      final data = await userRepository.getAllUsersData();
      userData = data
          .map((value) => UserModel.fromSnapshot(
              value as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      // print(u0+serData);
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
