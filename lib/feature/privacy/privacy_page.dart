import 'package:flutter/material.dart';

import '../../core/theme/gu_direct.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: const Text('隱私權政策'));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: GuDirect.space20,
            horizontal: GuDirect.space20,
          ),
          child: Text(
            'Gulu Water（以下簡稱「本 App」）重視您的個人資料與隱私安全。本政策將說明本 App 如何收集、使用與儲存資料，並說明移除 App 對資料的影響。\n'
            '  1. 資料收集與使用本 App 為單機使用型應用程式，所有資料（如：飲水紀錄、日期、時間、備註等）僅儲存在使用者的裝置本機中，不會上傳至雲端或伺服器，也不會與第三方分享任何資料。\n'
            '  2. 權限使用本 App 不會主動存取您的聯絡人、位置、相簿等個人資訊。使用者僅需允許基本功能所需的權限（如：資料儲存權限）。\n'
            '  3. 資料保存與刪除所有飲水紀錄資料皆儲存在您的手機本地資料庫中，當您執行以下操作時，資料將無法復原：\n  •	解除安裝 App\n  • 清除 App 資料（透過系統設定）\n建議您在移除本 App 前，先自行備份所需資料。\n'
            '  4. 資料安全雖然本 App 僅儲存基本健康記錄，但我們仍致力於在應用程式層級妥善處理與保護資料，避免非預期的遺失或存取。\n'
            '  5. 聯絡我們若您對本隱私政策有任何疑問或建議，歡迎透過電子郵件與我們聯繫：📧 ray15982003@gmail.com\n\n'
            '本政策自 2025 年 7 月 6 日起生效 \n未來若有修改，我們將在 App 中另行公告。',
            style: TextStyle(fontSize: GuDirect.fontSize16),
          ),
        ),
      ),
    );
  }
}
