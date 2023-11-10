import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: const Alignment(-1.3, 0),
              child: Text('     찜',
                  style: const TextStyle(color: Colors.black, fontSize: 18)),
            )
          ],
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [SliverList(delegate: SliverChildListDelegate([]))];
          },
          body: const Column(
            children: [
              Material(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 1,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text('찜한 코디'),
                    ),
                    Tab(
                      child: Text('찜한 옷'),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: TabBarView(
              //     children: [
              //       SingleChildScrollView(
              //           // child: Column(
              //           //   children: [
              //           //     ListView.builder(
              //           //       shrinkWrap: true,
              //           //       physics: NeverScrollableScrollPhysics(),
              //           //       itemCount: 1,
              //           //       itemBuilder: (
              //           //         BuildContext context,
              //           //         int i,
              //           //       ) {
              //           //         return allItemView(
              //           //             timeShopItemList, ypController);
              //           //       },
              //           //     ),
              //           //   ],
              //           // ),
              //           ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
