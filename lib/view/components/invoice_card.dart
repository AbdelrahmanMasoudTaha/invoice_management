import 'package:flutter/material.dart';
import 'package:payment_manager/models/invoice_model.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({super.key, required this.invoice});
  final InvoiceModel invoice;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Id',
              style: TextStyle(fontSize: 18, color: Colors.black45),
            ),
            Text(
              invoice.id,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custmer',
                style: TextStyle(fontSize: 18, color: Colors.black45),
              ),
              Text(
                invoice.custmerName.split(' ')[0],
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status:',
              style: TextStyle(fontSize: 18, color: Colors.black45),
            ),
            Text(
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: invoice.status == 0 ? Colors.red : Colors.blueAccent,
              ),
              invoice.status == 0 ? 'UnPaid' : 'Paid',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
