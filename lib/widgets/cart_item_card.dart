import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humari_dukan/widgets/counter.dart';

class CardItemCard extends StatefulWidget {
  const CardItemCard({Key? key, required this.documentSnapshot})
      : super(key: key);
  final DocumentSnapshot documentSnapshot;

  @override
  State<CardItemCard> createState() => _CardItemCardState();
}

class _CardItemCardState extends State<CardItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          elevation: 4,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset(
                    "assets/choose_image.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.documentSnapshot['productName'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs ${widget.documentSnapshot['sellingPrice']}",
                          style: const TextStyle(
                              color: Color(0xffffdf4d),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rs ${widget.documentSnapshot['costPrice']}",
                          style: const TextStyle(
                              color: Color(0xffadacac),
                              decoration: TextDecoration.lineThrough,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                CounterWidget(
                    documentSnapshot: widget.documentSnapshot),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
