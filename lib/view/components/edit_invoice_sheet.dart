import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment_manager/models/invoice_model.dart';

class EditInvoiceBottomSheet extends StatefulWidget {
  final int initialRadioValue;
  final InvoiceModel invoice;

  const EditInvoiceBottomSheet(
      {super.key, this.initialRadioValue = 1, required this.invoice});

  @override
  State<EditInvoiceBottomSheet> createState() => _EditInvoiceBottomSheetState();
}

class _EditInvoiceBottomSheetState extends State<EditInvoiceBottomSheet> {
  final _nameController = TextEditingController();
  final _paymentController = TextEditingController();
  DateTime? invoiceDate;
  DateTime? paymentDate;
  int? _selectedStatus;
  int? _selectedMethod;
  String? _selectedMethodName;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialRadioValue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPaid = _selectedStatus == 1;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Custmer Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _paymentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Payment Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(
            indent: 40,
            endIndent: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            'Select Invioce Status:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          RadioListTile<int>(
            title: const Text('UnPaid'),
            value: 0,
            groupValue: _selectedStatus,
            onChanged: (val) {
              setState(() => _selectedStatus = val);
              if (val == 0) {
                _selectedMethod = null;
                _selectedMethodName = null;
              }
            },
          ),
          RadioListTile<int>(
            title: const Text('Paid'),
            value: 1,
            groupValue: _selectedStatus,
            onChanged: (val) => setState(() => _selectedStatus = val),
          ),
          if (_selectedStatus == 1)
            Column(
              children: [
                const Divider(
                  indent: 40,
                  endIndent: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Select Payment Method:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RadioListTile<int>(
                  title: const Text('Cash'),
                  value: 0,
                  groupValue: _selectedMethod,
                  enableFeedback: isPaid,
                  onChanged: (val) {
                    isPaid
                        ? setState(() {
                            _selectedMethodName = 'Cash';
                            _selectedMethod = val;
                          })
                        : null;
                  },
                ),
                RadioListTile<int>(
                  title: const Text('Crdit'),
                  value: 1,
                  enableFeedback: isPaid,
                  groupValue: _selectedMethod,
                  onChanged: (val) {
                    isPaid
                        ? setState(() {
                            _selectedMethod = val;
                            _selectedMethodName = 'Crdit';
                          })
                        : null;
                  },
                ),
                const Divider(
                  indent: 40,
                  endIndent: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Select Payment Date:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(now.year - 1, now.month, now.day),
                        initialDate: now,
                        lastDate: DateTime(now.year + 1, now.month, now.day));
                    setState(() {
                      paymentDate = pickedDate;
                    });
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    size: 30,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // You can return data here using Navigator.pop
              Navigator.pop(context, {
                'name': _nameController.text,
                'payment': double.tryParse(_paymentController.text) ??
                    widget.invoice.paymentAmount,
                'status': _selectedStatus ?? widget.invoice.status,
                'method': _selectedMethodName ?? widget.invoice.paymentMethod,
                'paymentDate': paymentDate ?? widget.invoice.dateOfPayment,
              });
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
