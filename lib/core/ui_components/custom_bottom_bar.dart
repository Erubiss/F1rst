// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f1rst/core/ui_components/bottom_bar_items.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  final UserCubit cubit;

  const CustomBottomBar({
    super.key,
    required this.cubit,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBaarState();
}

class _CustomBottomBaarState extends State<CustomBottomBar> {
  List<Widget> tabs = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.account_circle_rounded),
    const Icon(Icons.settings),
  ];

  List<String> labels = [
    'Home',
    'Profile',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            tabs.length,
            (index) => BottomBarItems(
              onTap: () {
                widget.cubit.changeTabIndex(index);
              },
              isSelected: widget.cubit.state.selectedIndex == index,
              icon: tabs[index],
              label: labels[index],
            ),
          ),
        ],
      ),
    );
  }
}

//Sarqel BottomBarItem widget
