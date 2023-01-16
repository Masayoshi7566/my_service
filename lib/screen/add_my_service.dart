import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/service_model.dart';

class AddMyService extends StatelessWidget {
  const AddMyService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _AddMyService(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final ServiceItem item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<ServiceList, bool>(
      (service) => service.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var service = context.read<ServiceList>();
              service.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
    );
  }
}

class _AddMyService extends StatelessWidget {
  final int index;

  const _AddMyService(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<MyServiceModel, ServiceItem>(
      (service) => service.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
