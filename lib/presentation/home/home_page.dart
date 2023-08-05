import 'package:bloctesting/application/home/home_bloc.dart';
import 'package:bloctesting/presentation/like/like_page.dart';
import 'package:bloctesting/presentation/post/post_page.dart';
import 'package:bloctesting/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> _listBody = [
      ProfilePage(),
      PostPage(),
      LikePage(),
    ];
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.index == 0
                  ? 'Users'
                  : state.index == 1
                      ? 'Post'
                      : 'Like',
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: _listBody[state.index],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 30,
            backgroundColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: state.index,
            onTap: (val) {
              context.read<HomeBloc>().add(HomeEvent.indexChanged(val));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.label),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
