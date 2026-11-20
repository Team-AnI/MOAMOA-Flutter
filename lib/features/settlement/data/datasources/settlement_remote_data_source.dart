import '../models/payment_action_model.dart';
import '../models/regular_due_create_model.dart';
import '../models/regular_due_create_request.dart';
import '../models/regular_due_delete_model.dart';
import '../models/regular_due_delete_request.dart';
import '../models/regular_due_update_model.dart';
import '../models/regular_due_update_request.dart';
import '../models/regular_dues_list_model.dart';
import '../models/regular_dues_list_request.dart';
import '../models/settlement_create_model.dart';
import '../models/settlement_create_request.dart';
import '../models/settlement_detail_api_request.dart';
import '../models/settlement_detail_model.dart';
import '../models/settlement_list_model.dart';
import '../models/settlement_list_request.dart';
import '../models/settlement_payment_request.dart';
import '../models/settlement_response_model.dart';

abstract interface class SettlementRemoteDataSource {
  Future<SettlementResponseModel<SettlementCreateModel>> create(
    SettlementCreateRequest request,
  );
  Future<SettlementResponseModel<SettlementListModel>> list(
    SettlementListRequest request,
  );
  Future<SettlementResponseModel<SettlementDetailModel>> detail(
    SettlementDetailApiRequest request,
  );
  Future<SettlementResponseModel<PaymentActionModel>> submitPayment(
    SettlementPaymentRequest request,
  );
  Future<SettlementResponseModel<PaymentActionModel>> approvePayment(
    SettlementPaymentRequest request,
  );
  Future<SettlementResponseModel<PaymentActionModel>> rejectPayment(
    SettlementPaymentRequest request,
  );
  Future<SettlementResponseModel<RegularDuesListModel>> listRegularDues(
    RegularDuesListRequest request,
  );
  Future<SettlementResponseModel<RegularDueCreateModel>> createRegularDue(
    RegularDueCreateRequest request,
  );
  Future<SettlementResponseModel<RegularDueUpdateModel>> updateRegularDue(
    RegularDueUpdateRequest request,
  );
  Future<SettlementResponseModel<RegularDueDeleteModel>> deleteRegularDue(
    RegularDueDeleteRequest request,
  );
}
