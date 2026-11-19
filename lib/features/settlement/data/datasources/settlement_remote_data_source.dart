import '../models/regular_dues_list_model.dart';
import '../models/regular_due_create_model.dart';
import '../models/regular_due_update_model.dart';
import '../models/regular_due_delete_model.dart';
import '../models/regular_due_create_request.dart';
import '../models/regular_due_update_request.dart';
import '../models/settlement_create_request.dart';
import '../models/settlement_create_model.dart';
import '../models/settlement_list_model.dart';
import '../models/settlement_detail_model.dart';
import '../models/settlement_payment_request.dart';
import '../models/payment_action_model.dart';

abstract interface class SettlementRemoteDataSource {
  Future<SettlementCreateModel> create(SettlementCreateRequest request);
  Future<SettlementListModel> list(int meetingId);
  Future<SettlementDetailModel> detail(int meetingId, int settlementId);
  Future<PaymentActionModel> submitPayment(SettlementPaymentRequest request);
  Future<PaymentActionModel> approvePayment(SettlementPaymentRequest request);
  Future<PaymentActionModel> rejectPayment(SettlementPaymentRequest request);
  Future<RegularDuesListModel> listRegularDues(int meetingId);
  Future<RegularDueCreateModel> createRegularDue(
    RegularDueCreateRequest request,
  );
  Future<RegularDueUpdateModel> updateRegularDue(
    RegularDueUpdateRequest request,
  );
  Future<RegularDueDeleteModel> deleteRegularDue(
    int meetingId,
    int regularDuesId,
  );
}
