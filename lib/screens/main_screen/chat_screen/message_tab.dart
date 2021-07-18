import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/screens/register_login_screen/register_and_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Controllers/fb_messaging.dart';
import 'Controllers/image_controller.dart';
import 'Controllers/utils.dart';
import 'chatroom.dart';
import 'subWidgets/common_widgets.dart';
import 'subWidgets/local_notification_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with LocalNotificationView{
  String _userImageUrlFromFB = '';

  bool _isLoading = true;
  User? _user;
  String? _userId;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return context.read<AccountBloc>().userId==0?BlocProvider.value(value: context.read<AccountBloc>(),child: RegisterAndLoginScreen(initialIndex: 1,),):Scaffold(backgroundColor: Colors.blue.withOpacity(0.2),
      appBar: AppBar(centerTitle: true,leading: Container(),backgroundColor: Colors.white,title: Center(child: Text("Chat",style: TextStyle(color: Colors.black),),),),
      body:  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
            if (!userSnapshot.hasData) return loadingCircleForFB();
            return countChatListUsers(context.read<AccountBloc>().user!.id.toString(), userSnapshot) > 0
                ? Stack(
              children: [
                ListView(
                    children: userSnapshot.data!.docs.map((userData) {

                      if (userData['userId'] == context.read<AccountBloc>().user!.id.toString()) {
                        return Container();
                      } else if(context.read<AccountBloc>().user!.id.toString() !='24071999')
                        {
                          if(userData['userId']!='24071999')
                            return Container();
                          else return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(context.read<AccountBloc>().user!.id!.toString())
                                  .collection('chatlist')
                                  .where('chatWith',
                                  isEqualTo: "24071999")
                                  .snapshots(),
                              builder: (context, chatListSnapshot) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: ImageController.instance
                                          .cachedImage(userData['userImageUrl']),
                                    ),
                                    title: Text(userData['name']),
                                    subtitle: Text((chatListSnapshot.hasData &&
                                        chatListSnapshot.data!.docs.length >
                                            0)
                                        ? chatListSnapshot.data!.docs[0]
                                    ['lastChat']
                                        : userData['intro']),
                                    trailing: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 8, 4, 4),
                                        child: (chatListSnapshot.hasData &&
                                            chatListSnapshot
                                                .data!.docs.length >
                                                0)
                                            ? Container(
                                          width: 60,
                                          height: 50,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                (chatListSnapshot.hasData &&
                                                    chatListSnapshot
                                                        .data!
                                                        .docs
                                                        .length >
                                                        0)
                                                    ? readTimestamp(
                                                    chatListSnapshot
                                                        .data!
                                                        .docs[0]
                                                    ['timestamp'])
                                                    : '',
                                                style: TextStyle(
                                                    fontSize:
                                                    size.width * 0.03),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(0, 5, 0, 0),
                                                  child: CircleAvatar(
                                                    radius: 9,
                                                    child: Text(
                                                      (chatListSnapshot.data!
                                                          .docs[0]
                                                          .data()
                                                      as Map<
                                                          String,
                                                          dynamic>)[
                                                      'badgeCount'] ==
                                                          null
                                                          ? ''
                                                          : (((chatListSnapshot
                                                          .data!
                                                          .docs[
                                                      0]
                                                          .data() as Map<String, dynamic>)['badgeCount'] !=
                                                          0
                                                          ? '${(chatListSnapshot.data!.docs[0].data() as Map<String, dynamic>)['badgeCount']}'
                                                          : '')),
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    backgroundColor: (chatListSnapshot
                                                        .data!
                                                        .docs[0]
                                                        .data()
                                                    as Map<
                                                        String,
                                                        dynamic>)[
                                                    'badgeCount'] ==
                                                        null
                                                        ? Colors.transparent
                                                        : (chatListSnapshot
                                                        .data!
                                                        .docs[0]
                                                    [
                                                    'badgeCount'] !=
                                                        0
                                                        ? Colors
                                                        .red[400]
                                                        : Colors
                                                        .transparent),
                                                    foregroundColor:
                                                    Colors.white,
                                                  )),
                                            ],
                                          ),
                                        )
                                            : Text('')),
                                    onTap: () => _moveTochatRoom(
                                        userData['FCMToken'],
                                        userData['userId'],
                                        userData['name'],
                                        userData['userImageUrl']),
                                  ),
                                );
                              });
                        }
                      else {
                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(context.read<AccountBloc>().user!.id.toString())
                                .collection('chatlist')
                                .where('chatWith',
                                isEqualTo: userData['userId'])
                                .snapshots(),
                            builder: (context, chatListSnapshot) {
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ImageController.instance
                                      .cachedImage(userData['userImageUrl']),
                                ),
                                title: Text(userData['name']),
                                subtitle: Text((chatListSnapshot.hasData &&
                                    chatListSnapshot.data!.docs.length >
                                        0)
                                    ? chatListSnapshot.data!.docs[0]
                                ['lastChat']
                                    : userData['intro']),
                                trailing: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 8, 4, 4),
                                    child: (chatListSnapshot.hasData &&
                                        chatListSnapshot
                                            .data!.docs.length >
                                            0)
                                        ? Container(
                                      width: 60,
                                      height: 50,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            (chatListSnapshot.hasData &&
                                                chatListSnapshot
                                                    .data!
                                                    .docs
                                                    .length >
                                                    0)
                                                ? readTimestamp(
                                                chatListSnapshot
                                                    .data!
                                                    .docs[0]
                                                ['timestamp'])
                                                : '',
                                            style: TextStyle(
                                                fontSize:
                                                size.width * 0.03),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(0, 5, 0, 0),
                                              child: CircleAvatar(
                                                radius: 9,
                                                child: Text(
                                                  (chatListSnapshot.data!
                                                      .docs[0]
                                                      .data()
                                                  as Map<
                                                      String,
                                                      dynamic>)[
                                                  'badgeCount'] ==
                                                      null
                                                      ? ''
                                                      : (((chatListSnapshot
                                                      .data!
                                                      .docs[
                                                  0]
                                                      .data() as Map<String, dynamic>)['badgeCount'] !=
                                                      0
                                                      ? '${(chatListSnapshot.data!.docs[0].data() as Map<String, dynamic>)['badgeCount']}'
                                                      : '')),
                                                  style: TextStyle(
                                                      fontSize: 10),
                                                ),
                                                backgroundColor: (chatListSnapshot
                                                    .data!
                                                    .docs[0]
                                                    .data()
                                                as Map<
                                                    String,
                                                    dynamic>)[
                                                'badgeCount'] ==
                                                    null
                                                    ? Colors.transparent
                                                    : (chatListSnapshot
                                                    .data!
                                                    .docs[0]
                                                [
                                                'badgeCount'] !=
                                                    0
                                                    ? Colors
                                                    .red[400]
                                                    : Colors
                                                    .transparent),
                                                foregroundColor:
                                                Colors.white,
                                              )),
                                        ],
                                      ),
                                    )
                                        : Text('')),
                                onTap: () => _moveTochatRoom(
                                    userData['FCMToken'],
                                    userData['userId'],
                                    userData['name'],
                                    userData['userImageUrl']),
                              );
                            });
                      }
                    }).toList()),
                localNotificationCard(size)
              ],
            )
                : Container(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.forum,
                        color: Colors.grey[700],
                        size: 64,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'There are no users except you.\nPlease use other devices to chat.',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  Future<void> _moveTochatRoom(selectedUserToken, selectedUserID,
      selectedUserName, selectedUserThumbnail) async {
    try {
      String chatID = makeChatId(context.read<AccountBloc>().user!.id.toString(), selectedUserID);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatRoom(
                  context.read<AccountBloc>().user!.id.toString(),
                  context.read<AccountBloc>().user!.name ?? "",
                  context.read<AccountBloc>().user!.imageUrl!,
                  selectedUserToken,
                  selectedUserID,
                  chatID,
                  selectedUserName,
                  selectedUserThumbnail)));
    } catch (e) {
      print(e);
    }
  }
}
