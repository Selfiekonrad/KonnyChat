import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/navigation_bar.dart';
import 'package:frontend/core/configs/theme/app_colors.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/services/api_service.dart';
import '../../models/user.dart';
import 'single_chat_widget.dart';

class ChatsOverview extends StatefulWidget {
  const ChatsOverview({super.key});

  @override
  State<ChatsOverview> createState() => _ChatsOverviewState();
}

class _ChatsOverviewState extends State<ChatsOverview> {
  final ApiService apiService = ApiService();
  late Future<List<User>> _usersFuture;

  @override
  void didChangeDependencies() {
    _usersFuture = _loadAllUsersWithoutLocalUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar('Chats'), body: chatOverview());
  }

  Widget chatOverview() {
    return FutureBuilder(
        future: _usersFuture,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator( color: AppColors.primary,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildUserList(snapshot.data);
          } else {
            return _buildNoDataFound();
          }
        });
  }

  Widget _buildUserList(List<User>? users) {
    if (users == null || users.isEmpty) {
      return _buildNoDataFound();
    } else {
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return SingleChatWidget(
              user: user,
              lastMessage: 'Placeholder',
            );
          });
    }
  }

  Widget _buildNoDataFound() {
    return const Center(
      child: Text('no data found'),
    );
  }

  Future<List<User>> _loadAllUsersWithoutLocalUser() async {
    final userInfo = Userinfo.of(context);
    if (userInfo == null) {
      throw Exception('Userinfo not found in context');
    }
    final localUserId = userInfo.userID;
    return await apiService.fetchAllUsersWithoutPersonId(localUserId);
  }
}
