import 'package:flutter/material.dart';
import 'package:flutter_zepp/images.dart';
import 'package:riverpod/riverpod.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final _myDevices = [
    "Amazfit Bip 5",
    "Amazfit Bip 6",
  ];

  final _moreItems = [
    "会员管理",
    "Zepp运动教练",
    "我的目标",
    "亲友",
    "第三方接入",
    "用户反馈",
    "智能分析",
    "设置",
  ];

  final s10 = const Color.fromARGB(255, 0xE7, 0xE9, 0xED);

  Widget _buildMineInfoWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ZXM",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                "ID: 3085709272",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.white),
                child: const Row(
                  children: [
                    Icon(Icons.star),
                    Text("达标567天"),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          ClipOval(
            child: Container(
              color: Colors.white,
              child: Image.asset(MineImages.avatar),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMyDevicesWidget(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          ListTile(
            title: const Text("我的设备"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Text("+添加"),
              padding: EdgeInsets.zero,
            ),
          ),
          ..._myDevices.map((e) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(e),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  Widget _buildMoreWidget(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          const ListTile(title: Text("更多")),
          ..._moreItems.map((e) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(e),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Image.asset(MineImages.background_image, fit: BoxFit.cover)),
        Scaffold(
          backgroundColor: s10,
          appBar: AppBar(
            title: const Text('我的'),
            backgroundColor: Colors.transparent,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.mail_outline))],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildMineInfoWidget(context),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: _buildMyDevicesWidget(context),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: _buildMoreWidget(context),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
