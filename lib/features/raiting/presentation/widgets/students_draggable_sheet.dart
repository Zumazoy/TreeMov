import 'package:flutter/material.dart';
import 'package:treemov/features/raiting/presentation/widgets/draggable_sheet_handler.dart';
import 'package:treemov/features/raiting/presentation/widgets/pinned_student_card.dart';
import 'package:treemov/features/raiting/presentation/widgets/student_card.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class StudentsDraggableSheet extends StatelessWidget {
  final List<StudentEntity> students;
  final StudentEntity? currentStudent;
  final int currentUserPosition;
  final bool showPinnedCard;
  final Function(bool) onPinnedCardVisibilityChanged;

  const StudentsDraggableSheet({
    super.key,
    required this.students,
    required this.currentStudent,
    required this.currentUserPosition,
    required this.showPinnedCard,
    required this.onPinnedCardVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '🎯 StudentsDraggableSheet: currentStudent = ${currentStudent?.id}',
    );
    debugPrint('🎯 StudentsDraggableSheet: showPinnedCard = $showPinnedCard');
    debugPrint(
      '🎯 StudentsDraggableSheet: currentUserPosition = $currentUserPosition',
    );

    if (currentStudent != null) {
      final found = students.any((s) => s.id == currentStudent!.id);
      debugPrint('🎯 StudentsDraggableSheet: student found in list = $found');
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 0.87,
      snap: true,
      snapSizes: const [0.45, 0.85],
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (currentStudent != null &&
                  students.any((s) => s.id == currentStudent!.id)) {
                _handleScrollNotification(notification);
              } else {
                debugPrint('🎯 Scroll: currentStudent null or not in list');
              }
              return false;
            },
            child: Stack(
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(child: const DraggableSheetHandler()),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final student = students[index];
                        final position = index + 1;
                        final isCurrentUser =
                            currentStudent != null &&
                            student.id == currentStudent!.id;

                        if (isCurrentUser) {
                          debugPrint(
                            '🎯 Rendering current student at index $index',
                          );
                        }

                        return StudentCard(
                          student: student,
                          position: position,
                          isCurrentUser: isCurrentUser,
                        );
                      }, childCount: students.length),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            currentStudent != null &&
                                students.any((s) => s.id == currentStudent!.id)
                            ? 80
                            : 0,
                      ),
                    ),
                  ],
                ),
                if (showPinnedCard && currentStudent != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: PinnedStudentCard(
                      student: currentStudent!,
                      position: currentUserPosition,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleScrollNotification(ScrollNotification notification) {
    const itemHeight = 72.0;
    final scrollOffset = notification.metrics.pixels;
    final viewportHeight = notification.metrics.viewportDimension;

    final userPosition = (currentUserPosition - 1) * itemHeight;
    final userIsAboveViewport = userPosition + itemHeight <= scrollOffset;
    final userIsBelowViewport = userPosition >= scrollOffset + viewportHeight;
    final shouldShowPinned = userIsAboveViewport || userIsBelowViewport;

    debugPrint(
      '🎯 Scroll: offset=$scrollOffset, viewport=$viewportHeight, userPos=$userPosition',
    );
    debugPrint(
      '🎯 Scroll: above=$userIsAboveViewport, below=$userIsBelowViewport',
    );
    debugPrint(
      '🎯 Scroll: shouldShowPinned=$shouldShowPinned, current=$showPinnedCard',
    );

    if (showPinnedCard != shouldShowPinned) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onPinnedCardVisibilityChanged(shouldShowPinned);
      });
    }
  }
}
