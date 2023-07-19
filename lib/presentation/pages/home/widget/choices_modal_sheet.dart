import 'package:auto_route/auto_route.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/presentation/pages/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoicesModalSheet extends StatelessWidget {
  const ChoicesModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state) {
          case HomeSuccessState(:final predefinedChoices):
            return ListView.separated(
              itemBuilder: (_, index) => _ChoiceListTile(
                predefinedChoices[index],
              ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: predefinedChoices.length,
            );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _ChoiceListTile extends StatelessWidget {
  const _ChoiceListTile(this.choice);

  final ChoiceEntity choice;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(choice.name),
        subtitle: Text(choice.type.str(context)),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () => _onTap(context),
      );

  void _onTap(BuildContext context) {
    context.read<HomeBloc>().add(HomeEvent.choiceAdded(choice));
    context.router.pop();
  }
}
