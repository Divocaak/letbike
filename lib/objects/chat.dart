class Chat {
  String buyId;
  String buyName;
  String buyMail;

  Chat(this.buyId, this.buyName, this.buyMail);

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(json["id"], json["name"], json["mail"]);
}
