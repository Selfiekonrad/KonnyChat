import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/navigation_bar.dart';
import 'package:frontend/services/api_service.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../inherited/user_info.dart';
import '../../../models/chat.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key, required this.textingUser});

  final User textingUser;

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  late final ApiService apiService;
  late final int localUserId;
  late final int textingUserId;
  late Future<List<Message>> _listMessagesFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    apiService = ApiService();
    localUserId = Userinfo.of(context)?.userID ?? -1;
    if (localUserId == -1) {
      // TODO: Handle the case where the userID was not properly set
      print('Error: localUserId is not set.');
    } else {
      _listMessagesFuture = _loadUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.textingUser.name),
      body: FutureBuilder(
        future: _listMessagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator( color: AppColors.primary,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildMessagesArea(snapshot.data);
          } else {
            return _buildNoDataFound();
          }
        }
      ),
    );
  }

  Widget singleBubbleMessage(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0xFFB1CCC9),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(text),
          )),
    );
  }

  Widget _buildMessagesArea(List<Message>? messages) {
    if (messages == null || messages.isEmpty) {
      return _buildNoDataFound();
    } else {
      return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (_, index) => singleBubbleMessage(messages[index].messageText)
      );
    }
  }

  Widget _buildNoDataFound() {
    return const Center(
      child: Text('no data found'),
    );
  }

  Future<List<Message>> _loadUserInfo() async {
    try {
      Chat chat = await apiService.fetchChatByPersonOneIdAndPersonTwoId(localUserId, widget.textingUser.id);
      return await apiService.fetchAllMessagesFromChatId(chat.id);
    } catch (e) {
      print('Error loading user info: $e');
      return [];
    }
  }
}
