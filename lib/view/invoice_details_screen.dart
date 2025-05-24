import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment_manager/models/invoice_model.dart';

import 'components/edit_invoice_sheet.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key, required this.invoice});
  final InvoiceModel invoice;

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  void _openEditSheet(
    BuildContext context,
  ) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditInvoiceBottomSheet(
        initialRadioValue: 2,
        invoice: widget.invoice,
      ),
    );
    if (result != null) {
      setState(() {
        widget.invoice.setName(result['name']);
        widget.invoice.setAmount(result['payment']);
        widget.invoice.setMethod(result['method']);
        widget.invoice.setStatus(result['status']);
        widget.invoice.setPaymetDate(result['paymentDate']);
      });
      log("User Input: $result");
      // You can handle the result here
      Navigator.of(context).pop(widget.invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedInvoiceDate =
        '${widget.invoice.dateOfInvoice.day}/${widget.invoice.dateOfInvoice.month}/${widget.invoice.dateOfInvoice.year}';
    String? formattedPaymentDate = widget.invoice.dateOfPayment != null
        ? '${widget.invoice.dateOfPayment!.day}/${widget.invoice.dateOfPayment!.month}/${widget.invoice.dateOfPayment!.year}'
        : null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Invoice Id : ${widget.invoice.id}',
          style: const TextStyle(
            //fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _openEditSheet(context);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Custmer Name :',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.invoice.custmerName,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  'Status : ',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: widget.invoice.status == 0
                        ? Colors.red
                        : Colors.blueAccent,
                  ),
                  widget.invoice.status == 0 ? 'UnPaid' : 'Paid',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  'Payment Amount :',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.invoice.paymentAmount.toString(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  'Invoice Date :',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  formattedInvoiceDate,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  'Payment Date :',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.invoice.status == 1
                      ? formattedPaymentDate ?? 'Not Detrmaind'
                      : 'Not Paid Yet',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.invoice.status == 1
                        ? Colors.black
                        : Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  'Payment Method :',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.invoice.status == 1
                      ? widget.invoice.paymentMethod ?? 'Not Determaind'
                      : 'Not Paid Yet',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.invoice.status == 1
                        ? Colors.black
                        : Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
