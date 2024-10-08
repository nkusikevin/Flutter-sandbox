import 'package:flutter/material.dart';
import 'package:food_order/components/description_box.dart';
import 'package:food_order/components/drawer.dart';
import 'package:food_order/components/food_tile.dart';
import 'package:food_order/components/location.dart';
import 'package:food_order/components/my_tab_bar.dart';
import 'package:food_order/components/silver_app_bar.dart';
import 'package:food_order/model/food.dart';
import 'package:food_order/model/restaurant.dart';
import 'package:food_order/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> _menu) {
    return _menu.where((food) => food.category == category).toList();
  }

  List<Widget> _getFoodThisCategory(List<Food> _menu) {
    return FoodCategory.values.map((category) {
      List<Food> foods = _filterMenuByCategory(category, _menu);
      return ListView.builder(
          itemCount: foods.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return FoodTile(
              food: foods[index],
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FoodPage(food: foods[index]);
                }));
              },
            );
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            MySilverAppBar(
              title: MyTabBar(tabController: _tabController),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const CurrentLocation(),
                  const MyDescriptionBox()
                ],
              ),
            )
          ],
          body: Consumer<Restaurant>(
            builder: (context, restaurant, child) {
              return TabBarView(
                controller: _tabController,
                children: _getFoodThisCategory(restaurant.menu),
              );
            },
          ),
        ));
  }
}
