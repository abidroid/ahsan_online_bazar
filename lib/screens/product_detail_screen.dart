import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utility/utility.dart';

class ProductDetailScreen extends StatefulWidget {
  final DocumentSnapshot advertisement;

  const ProductDetailScreen({super.key, required this.advertisement});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.advertisement['photos'][0],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.advertisement['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: Text(
              getHumanReadableDate(widget.advertisement['postedOn']),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          const Gap(16),

          Text(
            widget.advertisement['desc'],
          ),
          const Gap(16),
          Row(
            children: [
              const SizedBox(width: 100, child: Text('City')),
              Text(widget.advertisement['city'])
            ],
          ),
          const Gap(16),
          Row(
            children: [
              const SizedBox(width: 100, child: Text('Price')),
              Text(widget.advertisement['price'])
            ],
          ),
          const Gap(16),
          Row(
            children: [
              const SizedBox(width: 100, child: Text('Seller')),
              Text(widget.advertisement['postedByName'])
            ],
          ),
          const Gap(16),
          Row(
            children: [
              const SizedBox(width: 100, child: Text('Mobile')),
              Text(widget.advertisement['mobile'])
            ],
          ),
          Spacer(),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    String mobileNum = widget.advertisement['mobile'];

                    final call = Uri.parse('tel:$mobileNum');

                    if (await canLaunchUrl(call)) {
                      launchUrl(call);
                    } else {
                      throw 'Could not launch $call';
                    }
                  },
                  child: const Text('Call Seller')))
        ],
      ),
    );
  }



}
