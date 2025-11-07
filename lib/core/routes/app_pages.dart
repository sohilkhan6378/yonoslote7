import 'package:get/get.dart';

import '../../presentation/views/splash_view.dart';
import '../../presentation/views/onboarding_view.dart';
import '../../presentation/views/auth/login_view.dart';
import '../../presentation/views/auth/register_view.dart';
import '../../presentation/views/auth/verify_phone_view.dart';
import '../../presentation/views/kyc/kyc_upload_view.dart';
import '../../presentation/views/kyc/kyc_status_view.dart';
import '../../presentation/views/wallet/wallet_view.dart';
import '../../presentation/views/wallet/deposit_view.dart';
import '../../presentation/views/wallet/withdraw_view.dart';
import '../../presentation/views/wallet/transactions_view.dart';
import '../../presentation/views/lobby/lobby_view.dart';
import '../../presentation/views/table/table_list_view.dart';
import '../../presentation/views/table/table_detail_view.dart';
import '../../presentation/views/game/rummy_table_view.dart';
import '../../presentation/views/game/rummy_result_view.dart';
import '../../presentation/views/profile/profile_view.dart';
import '../../presentation/views/settings/settings_view.dart';
import '../../presentation/views/admin/admin_dashboard_view.dart';
import '../../presentation/views/admin/admin_users_view.dart';
import '../../presentation/views/admin/admin_kyc_review_view.dart';
import '../../presentation/views/admin/admin_wallet_adjust_view.dart';
import '../../presentation/views/admin/admin_tables_view.dart';
import '../../presentation/views/admin/admin_reports_view.dart';
import '../bindings/app_bindings.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: AppBindings(),
    ),
    GetPage<dynamic>(
      name: AppRoutes.onboarding,
      page: OnboardingView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: LoginView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.register,
      page: RegisterView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.verifyPhone,
      page: VerifyPhoneView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.kycUpload,
      page: KycUploadView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.kycStatus,
      page: KycStatusView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.wallet,
      page: WalletView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.deposit,
      page: DepositView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.withdraw,
      page: WithdrawView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.transactions,
      page: TransactionsView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.lobby,
      page: LobbyView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.tableList,
      page: TableListView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.tableDetail,
      page: TableDetailView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.rummyTable,
      page: RummyTableView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.rummyResult,
      page: RummyResultView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.profile,
      page: ProfileView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.settings,
      page: SettingsView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminDashboard,
      page: AdminDashboardView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminUsers,
      page: AdminUsersView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminKycReview,
      page: AdminKycReviewView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminWalletAdjust,
      page: AdminWalletAdjustView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminTables,
      page: AdminTablesView.new,
    ),
    GetPage<dynamic>(
      name: AppRoutes.adminReports,
      page: AdminReportsView.new,
    ),
  ];
}
