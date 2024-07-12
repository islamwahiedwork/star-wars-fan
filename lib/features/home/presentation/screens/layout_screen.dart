import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/utils/app_string.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_state.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class LayOutScreen extends StatelessWidget {
  const LayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return SafeArea(
          bottom: false,
          child: DefaultTabController(
            initialIndex: HomeCubit.get(context).currentTabIndex,
            length: 6, // Number of tabs
            child: Scaffold(
              extendBody: true,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: const Text(AppString.appName),
                automaticallyImplyLeading: false,
                // Disable leading icon
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    // Adjust as needed
                    child: TabBar(
                      onTap: (int index) {
                        HomeCubit.get(context).changeTabIndex(index);
                      },
                      isScrollable: true,
                      tabs: const [
                        Tab(text: AppString.character),
                        Tab(text: AppString.planets),
                        Tab(text: AppString.films),
                        Tab(text: AppString.species),
                        Tab(text: AppString.vehicles),
                        Tab(text: AppString.starships),
                      ],
                    ),
                  ),
                ),
              ),
              body: homeCubit.currentNavIndex == 0
                  ? const HomeScreen()
                  : const FavouriteScreen(),
              bottomNavigationBar: BottomNavigationBar(
                // backgroundColor: Colors.black.withOpacity(0.2),
                selectedItemColor: Colors.deepOrange,
                currentIndex: HomeCubit.get(context).currentNavIndex,
                onTap: (index) {
                  HomeCubit.get(context).changeNavIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: AppString.home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: AppString.favoritesNavBar,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
