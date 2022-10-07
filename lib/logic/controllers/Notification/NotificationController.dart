
import 'dart:convert';
import 'package:customers/models/Boshra/notification/NotificationModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../main.dart';

class NotificationController extends GetxController{

  final storage = const FlutterSecureStorage();
  var user_id  , isLoading = false.obs  , token;
  List<Notification>notifications = <Notification>[].obs ;

  Future<void> fetch_notification() async {
    print(user_id);
    final response = await http
        .get(Uri.parse('${MyApp.api}/api/notification/getCustomer/$user_id'),
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json', 'Authorization': 'Bearer $token'}
    );

    if (response.statusCode == 200) {
      NotificationModel notificationModel =
      NotificationModel.fromJson(jsonDecode(response.body));

      notifications.assignAll(notificationModel.data) ;

      print("success") ;

      }
    isLoading.value = true ;

  }

  @override
  void onInit()async {
    user_id = await storage.read(key: 'id');
    token = await storage.read(key: 'token');

    await fetch_notification();
    super.onInit();
  }



}