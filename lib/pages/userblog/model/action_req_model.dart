// ignore_for_file: non_constant_identifier_names

class ActionReqModel {
  final String p_id;
  final String d_id;
  final String action;

  ActionReqModel({
    required this.p_id,
    required this.d_id,
    required this.action,
  });

  Future<Map<String, dynamic>> tomap() async {
    return <String, dynamic>{
      'p_id': p_id,
      'd_id': d_id,
      'action': action,
    };
  }
}
