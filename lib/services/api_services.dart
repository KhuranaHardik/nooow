// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooow/ui/components/app_common_snack_bar.dart';
import 'package:nooow/utils/app_constants.dart';

class ApiServices {
  ApiServices._internal();

  static final ApiServices _instance = ApiServices._internal();

  factory ApiServices() {
    return _instance;
  }

  // login with Email And Password
  Future<Map<String, dynamic>?> login(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.login),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(data.toString());

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // signup
  Future<Map<String, dynamic>?> signup(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.signup),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log("Sign Up  ${data.toString()}");

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // OTP for sign up
  Future<Map<String, dynamic>?> otpForSignUp(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.otpForSignup),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(" OTP for signup --> ${data.toString()}");

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // forgot password
  Future<Map<String, dynamic>?> forgotPassword(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.forgotPassword),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(data.toString());

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // OTP Verification
  Future<Map<String, dynamic>?> otpVerificationForgotPassword(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.forgotOtpVerificationUrl),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(data.toString());

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // Slider List
  Future<Map<String, dynamic>?> sliderList(BuildContext context) async {
    try {
      http.Response response = await http.get(
        Uri.parse(ApiEndPoints.sliderList),
        headers: {'fake-key': 'Nooow9876543210'},
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(data.runtimeType.toString());
      log(data.toString());

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }

  // // OTP Verification
  Future<Map<String, dynamic>?> resetPassword(
      {Map<String, dynamic>? body, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.resetPasswordUrl),
        headers: {'fake-key': 'Nooow9876543210'},
        body: body,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      log(data.toString());

      return data;
    } on TimeoutException {
      AppCommonSnackBar().appCommonSnackbar(context, "It Takes to  much time");
    } on SocketException catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Network Error");
      log(e.message.toString());
    } catch (e) {
      AppCommonSnackBar().appCommonSnackbar(context, "Server Error");
      log(e.toString());
    }
    return null;
  }
}
