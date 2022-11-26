import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nailstudy_app_flutter/constants.dart';
import 'package:nailstudy_app_flutter/logic/chat/chat_model.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_dao.dart';
import 'package:nailstudy_app_flutter/logic/user/user_store.dart';
import 'package:nailstudy_app_flutter/screens/chat/widgets/chat_item.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  var _items = [];
  final messageDao = MessageDao();

  @override
  void initState() {
    super.initState();
    getAllChats(false);
  }

  void getAllChats(bool onRefresh) async {
    if (onRefresh) {
      await Provider.of<UserStore>(context, listen: false).fetchSelf();
    }
    final myChats =
        Provider.of<UserStore>(context, listen: false).user?.chats ?? [];

    setState(() {
      _items = myChats;
    });
  }

  Future<ChatModel?> getChat(int index) async {
    if (_items.isEmpty) {
      return null;
    } else {
      var chatId = _items[index];
      var ref = messageDao.getChatObject(chatId);
      var chat = await ref.get().then((snap) {
        var object = snap.value as Map;

        var chat = ChatModel.fromJson({
          "id": snap.key,
          "userOne": object["userOne"],
          "userTwo": object["userTwo"],
          "messages": object["messages"].values.toList()
        });

        var formatter = DateFormat("d-M-yyyy HH:mm:ss");
        chat.messages.sort((a, b) => formatter
            .parse(a.timeStamp)
            .compareTo(formatter.parse(b.timeStamp)));

        return chat;
      }, onError: (err) {
        print(err);
        return null;
      });

      return chat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDefaultBackgroundColor,
        centerTitle: true,
        title: const Text('Chats',
            style: TextStyle(fontSize: kHeader2, color: kSecondaryColor)),
      ),
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () async {
                return getAllChats(true);
              },
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _items.isEmpty ? 1 : _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder<ChatModel?>(
                        future: getChat(index),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ChatItem(
                              chat: snapshot.data!,
                            );
                          } else {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(kDefaultPadding),
                                child: Text(
                                  'Geen chats gevonden.\n\n Er wordt automatisch een chat aangemaakt na de afronding van je eerste praktijk les.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: kSubtitle1,
                                      color: kSecondaryColor),
                                ),
                              ),
                            );
                          }
                        });
                  }))),
    );
  }
}
