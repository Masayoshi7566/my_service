// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_service_demo/model/service_model.dart';
import 'package:provider/provider.dart';

class MyServiceList extends StatelessWidget {
  const MyServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service List',
            style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/my_service/add'),
          ),
        ],
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _MyServiceList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.go('/my_service/add'),
        ),
      ],
    );
  }
}

class _MyServiceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var service = context.watch<ServiceList>();

    return ListView.builder(
      itemCount: service.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            service.remove(service.items[index]);
          },
        ),
        title: Text(
          service.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}
