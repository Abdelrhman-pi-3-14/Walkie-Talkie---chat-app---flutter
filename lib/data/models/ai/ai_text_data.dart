class AiTextReply {

  String emotion = "";

  String reply = "";

  AiTextReply({
    required this.emotion,
    required this.reply
  });

  factory AiTextReply.fromjson ( Map<String,dynamic> json){
    return AiTextReply(
       emotion :  json['emotion'],
      reply : json['reply']
    );
  }


}