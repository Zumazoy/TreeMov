import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

class GroupSelector extends StatefulWidget {
  final List<GroupStudentsResponseModel> groups;
  final GroupStudentsResponseModel? selectedGroup;
  final Function(GroupStudentsResponseModel) onGroupSelected;

  const GroupSelector({
    super.key,
    required this.groups,
    required this.selectedGroup,
    required this.onGroupSelected,
  });

  @override
  State<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  bool _isOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groups.isEmpty) {
      return const SizedBox.shrink();
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 36,
        width: double.infinity,
        child: Material(
          color: const Color(0xFF0099E9),
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () {
              if (_isOpen) {
                setState(() => _isOpen = false);
                _removeOverlay();
              } else {
                setState(() => _isOpen = true);
                _showOverlay();
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedGroup?.title ?? 'Выберите группу',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    _removeOverlay();

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isOpen = false;
                });
                _removeOverlay();
              },
              behavior: HitTestBehavior.opaque,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4,
            width: size.width,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0099E9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withAlpha(51),
                    width: 1,
                  ),
                ),
                constraints: BoxConstraints(maxHeight: 36 * 5.5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: widget.groups.length,
                    itemBuilder: (context, index) {
                      final group = widget.groups[index];
                      final isSelected = widget.selectedGroup?.id == group.id;

                      return InkWell(
                        onTap: () {
                          widget.onGroupSelected(group);
                          setState(() {
                            _isOpen = false;
                          });
                          _removeOverlay();
                        },
                        child: Container(
                          height: 36,
                          color: isSelected
                              ? Colors.white.withAlpha(51)
                              : Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  group.title ?? 'Группа ${group.id}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
