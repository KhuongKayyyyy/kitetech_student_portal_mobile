class ChatRequest {
  String? id;
  String? sentUSerId;
  String? receiveUserId;
  Enum? requestStatus;

  ChatRequest(
      {this.id, this.sentUSerId, this.receiveUserId, this.requestStatus});
}
