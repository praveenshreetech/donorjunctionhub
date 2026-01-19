// ignore_for_file: non_constant_identifier_names

class MobileNumberModel {
  final String mobile_number;
  final String fcm_key;

  MobileNumberModel({
    required this.mobile_number,
    required this.fcm_key,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'mobile_number': mobile_number,
      'fcm_key': fcm_key
    };
  }
}

class OTPModel {
  final String mobile_number;
  final String otp;

  OTPModel({
    required this.mobile_number,
    required this.otp,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{'mobile_number': mobile_number, 'otp': otp};
  }
}
