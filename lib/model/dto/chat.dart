enum ChatType {
  RAG._("rag"),
  SIMPLE._("simple");

  final String type;

  const ChatType._(this.type);

  @override
  String toString() => 'ChatType.$type';
}

class ChatOptions {
  String model;
  int maxHistoryLength;
  ChatType chatType;
  double temperature;

  ChatOptions(
      this.model, this.maxHistoryLength, this.chatType, this.temperature);

  @override
  String toString() {
    return 'ChatOptions{model: $model, maxHistoryLength: $maxHistoryLength, chatType: $chatType, temperature: $temperature}';
  }
}

