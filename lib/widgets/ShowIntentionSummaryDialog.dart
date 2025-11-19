import 'package:flutter/material.dart';
import 'package:most_app/styles/Colors.dart';

/// Dialog podsumowania zamawianej intencji
Future<void> showIntentionSummaryDialog(
    BuildContext context, {
      required String name,
      required String email,
      required String content,
      required VoidCallback onOrder,
      required VoidCallback onEdit,
    }) async {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      child: SizedBox(
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // <-- białe tło
            borderRadius: BorderRadius.circular(18),
          ),
          constraints: const BoxConstraints(maxWidth: 600,  minWidth: 400,
          ),
          child: Stack(
            children:[ Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'PODSUMOWANIE\nZAMAWIANEJ INTENCJI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 22,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Zamawiający:',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 2),
                      child: Text(
                        '$name\n$email',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Treść intencji:',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 12),
                      child: Text(
                        content,
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: greenColor, width: 1.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          minimumSize: const Size(100, 40),
                          foregroundColor: greenColor,
                          textStyle: const TextStyle(
                              fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onEdit();
                        },
                        child: const Text('EDYTUJ'),
                      ),
                      // const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          minimumSize: const Size(110, 40),
                          textStyle: const TextStyle(
                               fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onOrder();
                        },
                        child: const Text('ZAMAWIAM'),
                      ),
                    ],
                  ),
                ],
              ),
            ),Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: blueColor, size: 40),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),]
          ),
        ),
      ),
    ),
  );
}

/// Dialog potwierdzenia dodania intencji
Future<void> showIntentionAddedDialog(BuildContext context, {required VoidCallback onOk}) async {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // <-- białe tło
          borderRadius: BorderRadius.circular(18),
        ),
        constraints: const BoxConstraints(maxWidth: 330),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),

                  Center(
                    child: Text(
                      'DODANO INTENCJĘ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 26,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gdy tylko intencja zostanie potwierdzona, otrzymasz powiadomienie na podanego maila.',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify, // <-- dodaj to!
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(200, 40),
                        side: BorderSide(color: greenColor, width: 1.6),
                        foregroundColor: greenColor,
                        textStyle: const TextStyle(
                            fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onOk();
                      },
                      child: const Text('SUPER!'),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: blueColor, size: 40),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}