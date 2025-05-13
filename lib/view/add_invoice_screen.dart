import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/invoice_model.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _paymentController = TextEditingController();

  DateTime? invoiceDate;

  DateTime? paymentDate;

  int? _selectedStatus;

  int? _selectedMethod;

  String? _selectedMethodName;

  @override
  void initState() {
    super.initState();
    //_selectedStatus = widget.initialRadioValue;
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add New Invoic',
          style: TextStyle(
            //fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_alt_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Custmer Name:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(
                  indent: 40,
                  endIndent: 40,
                ),
                const Text(
                  'Payment Amount:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _paymentController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'payment is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Invoice Date:',
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
                            firstDate:
                                DateTime(now.year - 1, now.month, now.day),
                            initialDate: now,
                            lastDate:
                                DateTime(now.year + 1, now.month, now.day));
                        setState(() {
                          invoiceDate = pickedDate;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  firstDate: DateTime(
                                      now.year - 1, now.month, now.day),
                                  initialDate: now,
                                  lastDate: DateTime(
                                      now.year + 1, now.month, now.day));
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
                    ],
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            invoiceDate != null &&
                            _selectedStatus != null) {
                          if (isPaid &&
                              (_selectedMethod == null ||
                                  paymentDate == null)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please Fill All Feilds and Choose The Status and Date'),
                              ),
                            );
                            return;
                          }

                          InvoiceModel newInvoce = InvoiceModel(
                            paymentAmount:
                                double.tryParse(_paymentController.text) ?? 0,
                            paymentMethod: _selectedMethodName,
                            status: _selectedStatus!,
                            custmerName: _nameController.text,
                            dateOfInvoice: invoiceDate!,
                            dateOfPayment: paymentDate,
                          );
                          //invoices.add();
                          Navigator.pop(context, newInvoce);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please Fill All Feilds and Choose The Status and Date'),
                            ),
                          );
                        }
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cansel',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
