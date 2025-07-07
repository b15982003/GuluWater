import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gulu_water/feature/setting/widget/setting_item_content.dart';
import 'package:gulu_water/feature/setting/widget/setting_item_title.dart';

import '../../core/provider/target_water_provider.dart';
import '../../core/routes/routes.dart';
import '../../core/theme/gu_direct.dart';
import '../home/provider/week_water_record_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingsPage> {
  late final WeekWaterDataProvider _weekWaterDataProvider;
  late final List<double> _weekTotalWater;
  late final double _targetWater;

  final List<String> _imgTrophy = [
    'assets/images/ic_trophy0.png',
    'assets/images/ic_trophy15.png',
    'assets/images/ic_trophy28.png',
    'assets/images/ic_trophy42.png',
    'assets/images/ic_trophy50.png',
    'assets/images/ic_trophy70.png',
    'assets/images/ic_trophy85.png',
    'assets/images/ic_trophy100.png',
  ];

  @override
  void initState() {
    _weekWaterDataProvider = ref.read(weekWaterRecordProvider.notifier);
    _weekTotalWater = ref.read(weekWaterRecordProvider);
    _targetWater = ref.read(targetWaterProvider);
    super.initState();
  }

  @override
  void dispose() {
    _weekWaterDataProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Container(
        color: GuDirect.backgroundLightGray,
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _trophyCard(
                  context,
                  _checkTargetWeek(
                    target: _targetWater,
                    daysTotal: _weekTotalWater,
                  ),
                ),
                _settingCard(context),
                _privacyCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _trophyCard(BuildContext context, String imgTrophy) {
    return Container(
      margin: EdgeInsets.only(top: GuDirect.space20),
      decoration: BoxDecoration(
        color: GuDirect.backgroundLightOrange,
        borderRadius: BorderRadius.circular(GuDirect.radius16),
      ),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 5,
      child: Image.asset(imgTrophy),
    );
  }

  String _checkTargetWeek({
    required double target,
    required List<double> daysTotal,
  }) {
    var targetComplete = 0;
    for (var i = 0; i < daysTotal.length; i++) {
      if (daysTotal[i] >= target) {
        targetComplete++;
      }
    }
    return _imgTrophy[targetComplete];
  }

  Widget _settingCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(GuDirect.space16),
      margin: EdgeInsets.only(top: GuDirect.space20),
      decoration: BoxDecoration(
        color: GuDirect.backgroundWhite,
        borderRadius: BorderRadius.circular(GuDirect.radius16),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          settingItemTitle(context: context, title: '使用者設定'),
          SizedBox(height: GuDirect.space12),
          settingItemContent(context: context, title: '主題設定', press: () {
            _navigateToThemeSettingPage(context);
          }),
          settingItemContent(
            context: context,
            title: '目標設定',
            press: () => _navigateToTargetSettingPage(context),
            showUnderLine: false,
          ),
        ],
      ),
    );
  }

  Widget _privacyCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(GuDirect.space16),
      margin: EdgeInsets.only(top: GuDirect.space20),
      decoration: BoxDecoration(
        color: GuDirect.backgroundWhite,
        borderRadius: BorderRadius.circular(GuDirect.radius16),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          settingItemTitle(context: context, title: 'App 資訊'),
          SizedBox(height: GuDirect.space12),
          settingItemContent(
            context: context,
            title: '隱私權政策',
            press: () => _navigateToPrivacyPage(context),
          ),
          settingItemContent(
            context: context,
            title: '版本',
            content: '1.0.0',
            press: () {},
            showUnderLine: false,
          ),
        ],
      ),
    );
  }

  void _navigateToPrivacyPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.PRIVACY_PAGE}');
  }

  void _navigateToTargetSettingPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.TARGET_SETTING_PAGE}');
  }

  void _navigateToThemeSettingPage(BuildContext context) {
    Navigator.pushNamed(context, '/${GuRoutes.THEME_SETTING_PAGE}');
  }
}
