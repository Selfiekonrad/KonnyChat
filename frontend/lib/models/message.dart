class message {
  final int id;
  final int sender;
  final int receiver;
  final String message_text;
  final DateTime time_sent;

  message(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.message_text,
      required this.time_sent});
}
