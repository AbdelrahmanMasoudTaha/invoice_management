import 'package:uuid/uuid.dart';

const uuid = Uuid();

class InvoiceModel {
  final String id;
  double paymentAmount;
  String? paymentMethod;
  int status; //[0,1] 0 => not paid      1 => paid
  String custmerName;
  final DateTime dateOfInvoice;
  DateTime? dateOfPayment;

  InvoiceModel({
    required this.paymentAmount,
    this.paymentMethod,
    required this.status,
    required this.custmerName,
    required this.dateOfInvoice,
    this.dateOfPayment,
  }) : id = uuid.v4().substring(0, 7);

  void setName(String name) => custmerName = name;
  void setMethod(String method) => paymentMethod = method;
  void setAmount(double amount) => paymentAmount = amount;
  void setStatus(int newStatus) => status = newStatus;
  void setPaymetDate(DateTime paymentDate) => dateOfPayment = paymentDate;
}

List<InvoiceModel> invoices = [

  InvoiceModel(
    paymentAmount: 4000,
    paymentMethod: 'cash',
    status: 1,
    custmerName: 'Usama Saad',
    dateOfInvoice: DateTime.now(),
    dateOfPayment: DateTime.now(),
  ),
  InvoiceModel(
    paymentAmount: 2000,
    paymentMethod: 'cash',
    status: 0,
    custmerName: 'Ahmed Masoud ',
    dateOfInvoice: DateTime.now(),
    dateOfPayment: DateTime.now(),
  ),
  InvoiceModel(
    paymentAmount: 3000,
    paymentMethod: 'cash',
    status: 1,
    custmerName: 'Adam Mohamed',
    dateOfInvoice: DateTime.now(),
    dateOfPayment: DateTime.now(),
  ),
  InvoiceModel(
    paymentAmount: 4000,
    paymentMethod: 'cash',
    status: 1,
    custmerName: 'Usama Saad',
    dateOfInvoice: DateTime.now(),
    dateOfPayment: DateTime.now(),
  ),
];
