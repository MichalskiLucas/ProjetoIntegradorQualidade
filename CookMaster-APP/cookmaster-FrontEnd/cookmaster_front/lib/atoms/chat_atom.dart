import 'package:cookmaster_front/app/data/models/chatgpt_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

final chatsState = RxList<ChatModel>([]);
final chatLoading = RxNotifier(false);

final sendMessageAction = RxNotifier<String>('');

void updateChatsState(List<ChatModel> newChats) {
  chatsState.clear();
  chatsState.addAll(newChats);
}
