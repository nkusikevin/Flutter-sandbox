import 'package:flutter/material.dart';
import 'package:food_order/components/description_box.dart';
import 'package:food_order/components/drawer.dart';
import 'package:food_order/components/location.dart';
import 'package:food_order/components/my_tab_bar.dart';
import 'package:food_order/components/silver_app_bar.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Home $index"),
                    );
                  }),
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Setting $index"),
                    );
                  }),
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Profile $index"),
                    );
                  }),
            ],
          ),
        ));
  }
}
