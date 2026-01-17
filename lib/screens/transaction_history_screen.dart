import 'package:flutter/material.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,
      body: Column(
        children: [
          AppHeader(
            name: 'John Noon',
            email: 'johnnoon77@gmail.com',
            onMenuTap: () {}, // later
            showSearchBar: false,
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: ProductRepo.transactionVersion,
              builder: (_, __, ___) {
                final list = ProductRepo.transactions;

                if (list.isEmpty) {
                  return const Center(
                    child: Text(
                      "No transactions yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final trx = list[i];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAE2DA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.receipt_long),
                          ),
                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trx.id,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${trx.totalQty} items • ${trx.status}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _formatDate(trx.createdAt),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "\$${trx.grandTotal.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }
}
