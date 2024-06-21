import 'dart:async';

import 'package:fitness/models/user_model.dart';
import 'package:fitness/request/chat_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/chat_model.dart';
import '../request/user_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _users;
  late Future<List<Chat>> _chats;

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
    _chats = fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          const SizedBox(
            height: 40,
          ),
          _categoriesSection(),
          _chatsOverview()

        ],
      ),
    );
  }

  Column _chatsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Chats',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(
          height: 450,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 8, // Change this to the number of items you want
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 70,
                        minWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8), // Spacer between texts
                            Text(
                              'Hi, do you want to meet today?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }



  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'People',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder<List<User>>(
              future: _users,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center( child: CircularProgressIndicator(),);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('no user found'));
                } else {

                  List<User> users = snapshot.data!;
                  return ListView.separated(
                    itemCount: users.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(users[index].name),
                              ),
                            ),
                            Text(
                              users[index].password,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14
                              ),
                            )
                          ],
                        ),

                      );
                    }, separatorBuilder: (context, index) => const SizedBox(width: 25),
                  );
                }



              },
          ),
        )

      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
            )
          ]
      ),

      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search',
            hintStyle: const TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14
            ),
            prefixIcon: const Icon(Icons.saved_search_rounded),
            suffixIcon: const SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 4, right: 16, bottom: 8),
                      child: Icon(Icons.construction_rounded),
                    )
                  ],
                ),
              ),
            ),

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
            )
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
    title: const Text(
    'KonyChat',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold
    ),
    ),
    backgroundColor: Colors.white,
    centerTitle: true,

    leading: GestureDetector(
    onTap: () {

    },

    child: Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: const Color(0xffF7F8F8),
    borderRadius: BorderRadius.circular(10)
    ),
    child: const Icon(Icons.arrow_back_rounded),
    ),
    ),

    actions: [
    GestureDetector(
    onTap: () {

    },

    child: Container(
    margin: const EdgeInsets.all(10),
    width: 37,
    height: 37,
    decoration: BoxDecoration(
    color: const Color(0xffF7F8F8),
    borderRadius: BorderRadius.circular(10)
    ),
    child: const Icon(Icons.add_chart_rounded),
    ),
    )
    ],
    );
  }
}
