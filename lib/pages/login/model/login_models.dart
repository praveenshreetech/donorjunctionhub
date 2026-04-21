// ignore_for_file: non_constant_identifier_names

class MobileNumberModel {
  final String mobileNo;
  final String fcm_key;

  MobileNumberModel({
    required this.mobileNo,
    required this.fcm_key,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'mobile_no': mobileNo,
      'fcm_key': fcm_key
    };
  }
}

class OTPModel {
  final String mobileNo;
  final String otp;

  OTPModel({
    required this.mobileNo,
    required this.otp,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{'mobile_no': mobileNo, 'otp': otp};
  }
}
