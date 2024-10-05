import 'package:anothertodo/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/bottom_bar/bottom_bar_cubit.dart';
import 'widgets/bottom_bar_item.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: _AppViewBody(),
    );
  }
}

class _AppViewBody extends StatelessWidget {
  const _AppViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBarCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: context.read<BottomBarCubit>().state,
            children: [
              const HomeScreen(),
              const Center(
                child: Text("Search"),
              ),
              const Center(
                child: Text("Profile"),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomAppBar(
        padding: EdgeInsets.only(),
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomBarItem(
              title: "Home",
              index: 0,
              icon: CupertinoIcons.home,
            ),
            BottomBarItem(
              title: "Search",
              index: 1,
              icon: CupertinoIcons.search,
            ),
            BottomBarItem(
              title: "Profile",
              index: 2,
              icon: CupertinoIcons.person_circle,
            )
          ],
        ),
      ),
    );
  }
}
