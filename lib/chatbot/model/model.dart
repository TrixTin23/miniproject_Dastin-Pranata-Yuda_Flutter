class chatbot {
  String message;
  String response;
  String time;
  String type;

  chatbot({required this.message, required this.response, required this.time, required this.type});

  chatbot.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    response = json['response'];
    time = json['time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['response'] = this.response;
    data['time'] = this.time;
    data['type'] = this.type;
    return data;
  }
}