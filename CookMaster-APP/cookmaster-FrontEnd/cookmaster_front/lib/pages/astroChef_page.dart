// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../atoms/chat_atom.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_field.dart';

class PageAstro extends StatefulWidget {
  const PageAstro({super.key, this.message});
  final String? message;

  @override
  State<PageAstro> createState() => _PageAstroState();
}

class _PageAstroState extends State<PageAstro> {
  void _sendMessage(String message) {
    sendMessageAction.value = message;
  }

  String? get _message => widget.message;

  @override
  void initState() {
    super.initState();
    if (_message != null) {
      _sendMessage(_message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [chatsState.length, chatLoading.value]);
    final isLoading = chatLoading.value;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Image.asset('assets/images/iconChefAstro.png'),
        title: const Text('Chef Astro'),
        titleTextStyle: const TextStyle(
          fontFamily: 'JacquesFrancois',
          fontSize: 15,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.30,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Opacity(
                  opacity: 0.30,
                  child: Text(
                    'Cook Master',
                    style:
                        TextStyle(fontFamily: 'JacquesFrancois', fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chatsState.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(model: chatsState[index]);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ChatField(
                  sendEnabled: !isLoading,
                  onMessage: _sendMessage,
                ),
              ),
            ],
          ),
          if (isLoading)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
