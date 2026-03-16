class AiImageData {
  String image = "";
  String sender = "";
  String time = "";

  AiImageData({required this.sender, required this.image, required this.time});

  Map<String, dynamic> toJson() {
    return {'mode': 'text', "sender": sender, "image": image};
  }

  factory AiImageData.fromJson(Map<String, dynamic> json) {
    return AiImageData(
      sender: json['sender'],
      image: json['image'],
      time: json['time'],
    );
  }
}
