import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              "\$ ${spendingAmount.toStringAsFixed(2)}",
            ),
          ),
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            /**The children are placed from bottom to top. */
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}
