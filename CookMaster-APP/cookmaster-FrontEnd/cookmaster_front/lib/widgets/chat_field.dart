import 'package:flutter/material.dart';

class ChatField extends StatefulWidget {
  final bool sendEnabled;
  final void Function(String message) onMessage;

  const ChatField(
      {super.key, required this.onMessage, this.sendEnabled = true});

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  _senderMessage() {
    if (widget.sendEnabled) {
      final message = textController.text;
      if (message.isNotEmpty) {
        widget.onMessage(message);
        textController.text = '';
      }
    }

    focusNode.requestFocus();
  }

  bool get isButtonEnabled =>
      textController.text.isNotEmpty && widget.sendEnabled;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, left: 8.0, right: 8.0),
      child: TextField(
        focusNode: focusNode,
        controller: textController,
        onSubmitted: (value) {
          _senderMessage();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Pergunte a receita que deseja...',
          suffixIcon: AnimatedBuilder(
            animation: textController,
            builder: (context, _) {
              return IconButton(
                onPressed: !isButtonEnabled ? null : _senderMessage,
                icon: const Icon(Icons.send),
              );
            },
          ),
        ),
      ),
    );
  }
}
