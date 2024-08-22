import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/navigation_bar.dart';
import 'package:frontend/services/api_service.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../inherited/user_info.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.textingUser});

  final User textingUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ApiService _apiService;
  late final int _localUserId;
  late final int _textingUserId;
  late final int _chatId;
  late Future<void> _initialLoadFuture;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _apiService = ApiService();
    _localUserId = Userinfo.of(context)!.userID!;
    _textingUserId = widget.textingUser.id;
    _initialLoadFuture = _loadChatId();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.textingUser.name),
      body: _buildMainScreen(),
    );
  }

  Widget _buildMainScreen() {
    return FutureBuilder<void>(
        future: _initialLoadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Expanded(child: _buildMessagesStream()),
                _buildInputTextField()
              ],
            );
          }
        });
  }

  Widget _buildMessagesStream() {
    return StreamBuilder<List<Message>>(
        stream: _apiService.fetchAllMessagesFromChatIdAsStream(_chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: _buildMessagesArea(snapshot.data!),
            );
          } else {
            return _buildNoDataFound();
          }
        });
  }

  Widget _buildInputTextField() {
    return CupertinoTextField(
      controller: _messageController,
      placeholder: 'write a message here..',
      suffix: CupertinoButton(
          onPressed: _sendMessage,
          child: const Icon(CupertinoIcons.arrow_up_circle)),
    );
  }

  Widget _buildMessagesArea(List<Message> messages) {
    if (messages.isEmpty) {
      return _buildNoDataFound();
    } else {
      return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (_, index) {
            final bool isLocalUser = _localUserId == messages[index].sender;
            return _buildMessageBubble(
                messages[index].messageText, isLocalUser);
          });
    }
  }

  Widget _buildMessageBubble(String text, bool isLocalUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: isLocalUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB1CCC9),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(text),
        ),
      ),
    );
  }

  Widget _buildNoDataFound() {
    return const Center(child: Text('no data found'));
  }

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      final messageData = {
        "sender": '$_localUserId',
        "receiver": '$_textingUserId',
        "chatId": '$_chatId',
        "messageText": messageText,
      };
      try {
        await _apiService.postMessage(messageData);
        _messageController.clear();
      } catch (e) {
        print('Error posting message: $e');
      }
    }
  }

  Future<void> _loadChatId() async {
    try {
      final chat = await _apiService.fetchChatByPersonOneIdAndPersonTwoId(
          _localUserId, _textingUserId);
      _chatId = chat.id;
    } catch (e) {
      print('Error loading chat info: $e');
    }
  }
}
