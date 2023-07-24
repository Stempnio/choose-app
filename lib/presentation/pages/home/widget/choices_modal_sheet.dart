import 'package:auto_route/auto_route.dart';
import 'package:choose_app/domain/model/choices/choice_entity.dart';
import 'package:choose_app/presentation/constants/constants.dart';
import 'package:choose_app/presentation/pages/home/bloc/bloc.dart';
import 'package:choose_app/presentation/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoicesModalSheet extends StatefulWidget {
  const ChoicesModalSheet({super.key});

  @override
  State<ChoicesModalSheet> createState() => _ChoicesModalSheetState();
}

class _ChoicesModalSheetState extends State<ChoicesModalSheet> {
  final selectedFilters = {ChoiceType.place};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state) {
          case HomeSuccessState(:final predefinedChoices):
            return Padding(
              padding: const EdgeInsets.only(top: smallSize),
              child: Column(
                children: [
                  Wrap(
                    spacing: smallSize,
                    runSpacing: smallSize,
                    children: _buildChipFilters(),
                  ),
                  VSpace.small(),
                  Expanded(
                    child: ListView(
                      children: _buildChoiceListTiles(predefinedChoices),
                    ),
                  ),
                ],
              ),
            );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<Widget> _buildChipFilters() => ChoiceType.values
      .map(
        (type) => FilterChip(
          label: Text(type.str(context)),
          selected: selectedFilters.contains(type),
          onSelected: (selected) => _onSelected(selected, type),
        ),
      )
      .toList();

  void _onSelected(bool selected, ChoiceType type) => setState(() {
        selected ? selectedFilters.add(type) : selectedFilters.remove(type);
      });

  List<Widget> _buildChoiceListTiles(List<ChoiceEntity> choices) => choices
      .where((choice) => selectedFilters.contains(choice.type))
      .map(_ChoiceListTile.new)
      .toList();
}

class _ChoiceListTile extends StatelessWidget {
  const _ChoiceListTile(this.choice);

  final ChoiceEntity choice;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text(choice.name),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () => _onTap(context),
          ),
          const Divider(),
        ],
      );

  void _onTap(BuildContext context) {
    context.read<HomeBloc>().add(HomeEvent.choiceAdded(choice));
    context.router.pop();
  }
}
