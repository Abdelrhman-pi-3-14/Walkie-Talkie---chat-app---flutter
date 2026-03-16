
class AiTextRowData {
  String type = "";
  String session_id = "";
  String output = "";

  AiTextRowData({required this.type, required this.session_id, required this.output});

  Map<String, dynamic> toJson() {
    return {'type': type , "session_id": session_id, "output": output};
  }

  factory AiTextRowData.fromJson(Map<String, dynamic> json) {
    return AiTextRowData(
      type: json['type'],
       session_id : json['session_id'],
        output: json['output'],
    );
  }
}
