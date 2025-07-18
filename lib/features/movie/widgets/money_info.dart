import 'package:cinehive_mobile/utils/formatters.dart';
import 'package:flutter/material.dart';

final revenueGradient = LinearGradient(
  colors: [Colors.transparent, Colors.green.shade500.withAlpha(50)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final budgetGradient = LinearGradient(
  colors: [Colors.transparent, Colors.red.shade500.withAlpha(50)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final budgetIcon=Icons.trending_down;
final revenueIcon=Icons.trending_up;

class MoneyInfo extends StatelessWidget {
  final int budget;
  final int revenue;

  const MoneyInfo({super.key, required this.budget, required this.revenue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMoneyBox("Budget", budget, budgetGradient, budgetIcon,context),
          const SizedBox(width: 16),
          _buildMoneyBox("Revenue", revenue, revenueGradient,revenueIcon, context),
        ],
      ),
    );
  }

  Widget _buildMoneyBox(
    String label,
    int amount,
    LinearGradient gradient,
    IconData icon,
    BuildContext context,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Formatters.formatMoney(amount),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              Icon(icon,size: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
