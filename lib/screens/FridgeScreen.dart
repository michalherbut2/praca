// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:most_app/helper/AuthService.dart';
// import 'package:most_app/styles/Colors.dart';
// import 'package:most_app/widgets/ScreenHeader.dart';
//
// class Product {
//   final String name;
//   final String imageUrl;
//   final String addedDate;
//   final String expiryDate;
//   final String owner;
//   final bool opened;
//
//   Product({
//     required this.name,
//     required this.imageUrl,
//     required this.addedDate,
//     required this.expiryDate,
//     required this.owner,
//     required this.opened,
//   });
// }
//
// class FridgeScreen extends StatefulWidget {
//   const FridgeScreen({super.key});
//
//   @override
//   State<FridgeScreen> createState() => _FridgeScreenState();
// }
//
// class _FridgeScreenState extends State<FridgeScreen> {
//   List<Product> products = [
//     Product(
//       name: 'Sałatka jarzynowa',
//       imageUrl:
//           'https://www.polonist.com/wp-content/uploads/2021/09/Salatka_Jarzynowa_3_1600x2250-o.jpg',
//       addedDate: '20.06',
//       expiryDate: '22.07',
//       owner: 'Jan Kowalski',
//       opened: true,
//     ),
//     Product(
//       name: 'Dżem truskawkowy',
//       imageUrl:
//           'https://bitesbybianca.com/wp-content/uploads/2024/06/homemade-strawberry-jam-3.jpg',
//       addedDate: '18.06',
//       expiryDate: '25.06',
//       owner: 'Jan Kowalski',
//       opened: false,
//     ),
//   ];
//
//   void _showDetails(Product product) {
//     showDialog(
//       context: context,
//       builder: (context) => FridgeProductDetailsDialog(product: product),
//     );
//   }
//
//   void _showAddProductDialog() async {
//     final result = await showDialog<Product>(
//       context: context,
//       builder: (context) => const FridgeAddProductDialog(),
//     );
//     if (result != null) {
//       setState(() {
//         products.add(result);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const ScreenHeader(title: 'LODÓWKA'),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Produkty obecnie w mostowej lodówce:',
//                   style: TextStyle(
//                     color: blueColor,
//                     fontSize: 32,
//                   ),
//                 ),
//                 const SizedBox(height: 18),
//                 ...products.map((product) => FridgeProductCard(
//                       product: product,
//                       onDetails: () => _showDetails(product),
//                     )),
//                 const SizedBox(height: 100),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: FloatingActionButton(
//                 elevation: 0,
//                 backgroundColor: greenColor,
//                 foregroundColor: Colors.white,
//                 shape: const CircleBorder(),
//                 onPressed: _showAddProductDialog,
//                 child: const Icon(Icons.add, size: 40),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FridgeProductCard extends StatelessWidget {
//   final Product product;
//   final VoidCallback onDetails;
//   const FridgeProductCard({
//     super.key,
//     required this.product,
//     required this.onDetails,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: blueColor),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 1,
//             offset: Offset(0, 1),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 70,
//             height: 70,
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               image: product.imageUrl.isNotEmpty ? DecorationImage(
//                 image:  NetworkImage(product.imageUrl),
//                 fit: BoxFit.cover,
//               ) : null,
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: TextStyle(
//                         color: blueColor, fontSize: 24, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     'W lodówce od: ${product.addedDate}',
//                     style: TextStyle(color: blueColor, fontSize: 20),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         backgroundColor: greenColor,
//                         foregroundColor: Colors.white,
//                         textStyle: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                         minimumSize: const Size(110, 38),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                       ),
//                       onPressed: onDetails,
//                       child: const Text('SZCZEGÓŁY'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FridgeProductDetailsDialog extends StatelessWidget {
//   final Product product;
//   const FridgeProductDetailsDialog({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       elevation: 6,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         constraints: const BoxConstraints(maxWidth: 330),
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Center(
//                     child: Text(
//                       product.name,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: blueColor,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Produkt umieścił:',
//                       style: TextStyle(
//                           color: blueColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 8, top: 2),
//                       child: Text(
//                         product.owner,
//                         style: TextStyle(color: blueColor, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Data włożenia do lodówki:',
//                       style: TextStyle(
//                           color: blueColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 8, top: 2),
//                       child: Text(
//                         product.addedDate,
//                         style: TextStyle(color: blueColor, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Termin ważności:',
//                       style: TextStyle(
//                           color: blueColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 8, top: 2),
//                       child: Text(
//                         product.expiryDate,
//                         style: TextStyle(color: blueColor, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Produkt otwarty?',
//                       style: TextStyle(
//                           color: blueColor,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 8, top: 2),
//                       child: Text(
//                         product.opened ? 'Tak' : 'Nie',
//                         style: TextStyle(color: blueColor, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 80,
//                     height: 80,
//                     color: Colors.grey.shade300,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: product.imageUrl.isNotEmpty
//                         ? Image.network(product.imageUrl, fit: BoxFit.cover)
//                         : null,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         backgroundColor: greenColor,
//                         foregroundColor: Colors.white,
//                         textStyle: const TextStyle(fontSize: 20),
//                         minimumSize: const Size(120, 38),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('GOTOWE'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 2,
//               right: 0,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: blueColor, size: 40),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FridgeAddProductDialog extends StatefulWidget {
//   const FridgeAddProductDialog({super.key});
//
//   @override
//   State<FridgeAddProductDialog> createState() => _FridgeAddProductDialogState();
// }
//
// class _FridgeAddProductDialogState extends State<FridgeAddProductDialog> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addedDateController = TextEditingController();
//   final TextEditingController expiryDateController = TextEditingController();
//   bool opened = false;
//   String? imageUrl;
//
//   @override
//   void initState() {
//     super.initState();
//     addedDateController.text = '22.06';
//     expiryDateController.text = '22.07';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       elevation: 6,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         constraints: const BoxConstraints(maxWidth: 330),
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'DODANIE PRODUKTU',
//                       style: TextStyle(
//                         color: greenColor,
//                         fontSize: 22,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   _label('Nazwa produktu:'),
//                   _textField(nameController),
//                   _label('Data włożenia do lodówki:'),
//                   _textField(addedDateController),
//                   _label('Termin ważności:'),
//                   _textField(expiryDateController),
//                   _label('Produkt otwarty?'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Radio<bool>(
//                         value: true,
//                         groupValue: opened,
//                         activeColor: blueColor,
//                         onChanged: (val) =>
//                             setState(() => opened = val ?? false),
//                       ),
//                       Text('Tak', style: TextStyle(color: blueColor, fontSize: 16)),
//                       Radio<bool>(
//                         value: false,
//                         groupValue: opened,
//                         activeColor: blueColor,
//                         onChanged: (val) =>
//                             setState(() => opened = val ?? false),
//                       ),
//                       Text('Nie', style: TextStyle(color: blueColor, fontSize: 16)),
//                     ],
//                   ),
//                   _label('Dodaj zdjęcie produktu:'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // tutaj obsługa wyboru zdjęcia
//                         },
//                         child: Container(
//                           width: 44,
//                           height: 44,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: blueColor),
//                           ),
//                           child: imageUrl == null
//                               ? null
//                               : ClipOval(
//                                   child: Image.network(imageUrl!,
//                                       fit: BoxFit.cover)),
//                         ),
//                       ),
//                       if (imageUrl != null)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 18),
//                           child: InkWell(
//                             onTap: () {
//                               // tutaj obsługa zmiany zdjęcia
//                             },
//                             child: Container(
//                               width: 44,
//                               height: 44,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border:
//                                     Border.all(color: blueColor),
//                               ),
//                               child: Center(
//                                 child: Text('Zmień',
//                                     style:
//                                         TextStyle(color: blueColor, fontSize: 12)),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Center(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: greenColor,
//                         foregroundColor: Colors.white,
//                         textStyle: const TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 16),
//                         minimumSize: const Size(120, 38),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                       onPressed: () {
//                         final user = context.read<AuthService>().user;
//                         if (nameController.text.isNotEmpty) {
//                           Navigator.of(context).pop(Product(
//                             name: nameController.text,
//                             imageUrl: imageUrl ?? '',
//                             addedDate: addedDateController.text,
//                             expiryDate: expiryDateController.text,
//                             owner: user!.name,
//                             opened: opened,
//                           ));
//                         }
//                       },
//                       child: const Text('GOTOWE'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 2,
//               right: 0,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: blueColor, size: 40),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _label(String text) => Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 8, bottom: 2),
//           child: Text(text,
//               style: TextStyle(
//                   color: blueColor, fontWeight: FontWeight.w600, fontSize: 16)),
//         ),
//       );
//
//   Widget _textField(TextEditingController controller) => Padding(
//         padding: const EdgeInsets.only(bottom: 2),
//         child: TextField(
//           controller: controller,
//           style: TextStyle(color: blueColor, fontSize: 15),
//           decoration: InputDecoration(
//             isDense: true,
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: blueColor),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: blueColor, width: 2),
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//         ),
//       );
// }


// ============================================
// 3. screens/FridgeScreen.dart
// ============================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/FridgeService.dart';
import 'package:most_app/models/FridgeItem.dart';
import 'package:most_app/screens/AddFridgeItemScreen.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({super.key});

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    print("Init FridgeScreen");
    super.initState();
    print("Wywołano super.initState()");
    _loadItems();
    print("Wywołano _loadItems()");
  }

  Future<void> _loadItems() async {
    try {
      print("Ładowanie przedmiotów z lodówki...");
      await context.read<FridgeService>().fetchItems();
      print("Ładowanie przedmiotów z lodówki zakończone");
    } catch (e) {
      debugPrint('Błąd: $e');
      print("Błąd podczas ładowania przedmiotów z lodówki: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
      print("Ustawiono isLoading na false" );
    }
  }

  Future<void> _deleteItem(FridgeItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuń produkt'),
        content: Text('Czy na pewno zużyto/wyrzucono "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Usuń'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        await context.read<FridgeService>().deleteItem(item.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Produkt usunięty')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Błąd: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fridgeService = context.watch<FridgeService>();
    final items = fridgeService.items;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadItems,
        child: items.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.kitchen, size: 80, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'Lodówka jest pusta',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddFridgeItemScreen(),
                    ),
                  );
                  if (result == true) _loadItems();
                },
                icon: const Icon(Icons.add),
                label: const Text('Dodaj pierwszy produkt'),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildFridgeItemCard(item);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFridgeItemScreen(),
            ),
          );
          if (result == true) _loadItems();
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFridgeItemCard(FridgeItem item) {
    Color cardColor = Colors.white;
    Color borderColor = Colors.grey[300]!;

    if (item.isExpired()) {
      cardColor = Colors.red[50]!;
      borderColor = Colors.red[300]!;
    } else if (item.isExpiringSoon()) {
      cardColor = Colors.orange[50]!;
      borderColor = Colors.orange[300]!;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          radius: 24,
          child: Text(
            item.getCategoryEmoji(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (item.isOpened)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Otwarte',
                  style: TextStyle(fontSize: 10, color: Colors.orange),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${item.quantity} ${item.unit}',
              style: const TextStyle(fontSize: 14),
            ),
            if (item.expiryDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: item.isExpired()
                        ? Colors.red
                        : item.isExpiringSoon()
                        ? Colors.orange
                        : Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Ważne do: ${_formatDate(item.expiryDate!)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: item.isExpired()
                          ? Colors.red
                          : item.isExpiringSoon()
                          ? Colors.orange
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4),
            Text(
              'Dodane przez ${item.addedByName}',
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
            if (item.notes != null && item.notes!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                item.notes!,
                style: TextStyle(fontSize: 11, color: Colors.grey[600], fontStyle: FontStyle.italic),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _deleteItem(item),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}