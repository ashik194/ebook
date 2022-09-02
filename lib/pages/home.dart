import 'dart:convert';

import 'package:ebook/pages/app_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:ebook/audio/app_colors.dart' as AppColors;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late List latestBooks;
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/latestBooks.json").then((s)=>{
      setState(() {
        latestBooks = json.decode(s);
      })
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s)=>{
      setState(() {
        books = json.decode(s);
      })
    });
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10,),
                          Icon(Icons.notifications),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("Popular Data Showing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                          top:0,
                          left: -20,
                          right: 0,
                          child:Container(
                  height: 180,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        itemCount: latestBooks == null ? 0 : latestBooks.length,
                        itemBuilder: (_, i){
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(latestBooks[i]["img"]),
                                  fit: BoxFit.fill,
                                )
                            ),
                          );
                        }),
                  )
                )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool isScroll) {
                        return [
                          SliverAppBar(
                            pinned: true,
                            backgroundColor: AppColors.sliverBackground,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 20),
                                child: TabBar(
                                  indicatorPadding: const EdgeInsets.all(0),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelPadding: const EdgeInsets.only(right: 10),
                                  controller: _tabController,
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]
                                  ),
                                  tabs: [
                                    AppTabs(color: AppColors.firstMenuColor, text: "New"),
                                    AppTabs(color: AppColors.secondMenuColor, text: "Popular"),
                                    AppTabs(color: AppColors.thirdMenuColor, text: "Tranding"),

                                  ],
                                ),
                              ),
                            ),
                          )
                        ];
                      },
                      body: TabBarView(

                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: latestBooks==null?0:latestBooks.length,
                              itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVerViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset: Offset(0,0),
                                    ),
                                  ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(latestBooks[i]["img"]),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star, size: 24, color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(latestBooks[i]["rating"], style: TextStyle(color: AppColors.secondMenuColor),),
                                            ],
                                          ),
                                          Text(latestBooks[i]["title"], style: TextStyle(fontSize: 16, fontFamily: "Avenic", fontWeight: FontWeight.bold),),
                                          Text(latestBooks[i]["text"], style: TextStyle(fontSize: 16, fontFamily: "Avenic", color: AppColors.subTitleText),),
                                          Container(
                                            height: 15,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text("Love", style: TextStyle(fontSize: 12, fontFamily: "Avenic", color: Colors.white),),
                                            alignment: Alignment.center,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          Material(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text("Content"),
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text("Content"),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),


              ],
            ),
      ),
    ),
    );
  }
}
