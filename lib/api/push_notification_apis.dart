import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as serviceControl;
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationAPI {
  static Future<String> getAccessToken() async {
    try{
      final serviceAccount = {
        "type": dotenv.env['TYPE'],
        "project_id": dotenv.env['PROJECT_ID'],
        "private_key_id": dotenv.env['PRIVATE_KEY_ID'],
        "private_key": dotenv.env['PRIVATE_KEY'],
        "client_email": dotenv.env['CLIENT_EMAIL'],
        "client_id": dotenv.env['CLIENT_ID'],
        "auth_uri":dotenv.env['AUTH_URI'],
        "token_uri": dotenv.env['TOKEN_URI'],
        "auth_provider_x509_cert_url":dotenv.env['AUTH_PROVIDER_URL'],
        "client_x509_cert_url": dotenv.env['CLIENT_URL'],
        "universe_domain": dotenv.env['UNIVERSE_DOMAIN']
      };
      List<String> scopes = [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/firebase.database",
        "https://www.googleapis.com/auth/firebase.messaging",
      ];
      print("llllllllllllll");
      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccount),
        scopes,
      );
      auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccount),
          scopes,
          client);
      client.close();
      return credentials.accessToken.data;
    }catch(e, stackTrace){
      print("Error in getAccessToken: $e");
      print("Stack trace: $stackTrace");
      rethrow;
    }

  }

  Future<bool> sendNotification({
    required String title,
    required String body,
    required List<String> tokens,
    required String tag
  }) async {
    try{
      final serverKey = await getAccessToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      };

      bool allSuccessful = true;

      for (String token in tokens) {
        final data = {
          "message": {
            "token": token,
            "notification": {
              "body": body,
              "title": title
            },
            "data": {
              "userRole": tag
            }
          }
        };
        final response = await http.post(
          Uri.parse('https://fcm.googleapis.com/v1/projects/knm-masjid-app/messages:send'),
          headers: headers,
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          print('Notification sent successfully to token: $token');
        } else {
          print('Failed to send notification to token $token: ${response.body}');
          allSuccessful = false;
        }
      }
      await FirebaseFirestore.instance.collection('notifications').doc().set({
        'title':title,
        'body':body,
        'userRole':  tag
      });
      return allSuccessful;
    }catch(e){
      return false;
    }
  }

  Future<QuerySnapshot<Object?>> searchFCMAPI() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot;
  }
}
