import 'package:flutter/material.dart';
import '../../images.dart';
import '../../theme.dart';
import 'card_sort.dart';
import 'cards/sleep_card.dart';
import 'cards/pai_card.dart';
import 'cards/sport_card.dart';
import 'cards/sport_status_card.dart';
import 'cards/spo2_card.dart';
import 'cards/aura_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final _cards = const [
    SleepCard(),
    PAICard(),
    AuraCard(),
    SportCard(),
    SportStatusCard(),
    PressureSpo2Card(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.s10,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(HomeImages.bg, alignment: Alignment.topCenter, fit: BoxFit.fitWidth)),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppbar(context),
            body: CustomScrollView(
              slivers: [
                _buildCardList(context),
                SliverToBoxAdapter(child: _buildSortEntryButton(context)),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      title: Image.asset(HomeImages.logo),
      actions: [
        IconButton(
          onPressed: () => _goCardSortPage(context),
          icon: const Icon(Icons.sort),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.all_inclusive),
        )
      ],
    );
  }

  Widget _buildCardList(BuildContext context) {
    return SliverList.separated(
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: ThemeColor.s38,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 100,
          child: _cards[index],
        );
      },
      separatorBuilder: (_, __) {
        return Container(height: 10);
      },
    );
  }

  Widget _buildSortEntryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 30),
      child: TextButton.icon(
          icon: const Icon(Icons.sort),
          label: Text('编辑卡片数据', style: Theme.of(context).textTheme.bodyLarge),
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
            backgroundColor: const MaterialStatePropertyAll(ThemeColor.s38),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
          onPressed: () => _goCardSortPage(context)),
    );
  }

  void _goCardSortPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const HomeCardSortPage();
        },
      ),
    );
  }
}
