enum MessageRole { user, ai }

class Message {
  final MessageRole role;
  final String text;
  final bool award;

  const Message({
    required this.role,
    required this.text,
    this.award = false,
  });
}
