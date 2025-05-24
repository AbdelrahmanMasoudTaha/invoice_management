import 'package:flutter/material.dart';
import 'package:payment_manager/models/invoice_model.dart';
import 'package:payment_manager/view/add_invoice_screen.dart';
import 'package:payment_manager/view/components/invoice_card.dart';
import 'package:payment_manager/view/invoice_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<InvoiceModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = invoices;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = invoices.where((item) {
        return item.custmerName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Invoices'),
        actions: [
          IconButton(
            onPressed: () async {
              InvoiceModel? newInvoce = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const AddInvoiceScreen();
              }));
              if (newInvoce != null) {
                setState(() {
                  invoices.add(newInvoce);
                  filterItems(searchController.text);
                });
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search By Custmer Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                //icon: Icon(Icons.search),
                suffixIcon: const Icon(Icons.search),
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
              onChanged: filterItems,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final InvoiceModel invoice = filteredItems[index];
                  return GestureDetector(
                    child: InvoiceCard(invoice: invoice),
                    onTap: () async {
                      final updatedInvoice = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return InvoiceDetailsScreen(invoice: invoice);
                        }),
                      );
                      if (updatedInvoice != null) {
                        setState(() {
                          // Find and update the invoice in the main list
                          final index = invoices
                              .indexWhere((inv) => inv.id == updatedInvoice.id);
                          if (index != -1) {
                            invoices[index] = updatedInvoice;
                            // Update filtered items to reflect the changes
                            filterItems(searchController.text);
                          }
                        });
                      }
                    },
                  );
                },
                itemCount: filteredItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
