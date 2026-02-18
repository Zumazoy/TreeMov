import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/organizations/presentation/widgets/member_item.dart';
import 'package:treemov/features/organizations/presentation/widgets/organization_menu.dart';
import 'package:treemov/features/organizations/models/organization.dart';
import 'package:treemov/features/organizations/models/invite.dart';
import 'package:treemov/features/organizations/services/organization_service.dart';
import 'package:treemov/features/organizations/services/invite_service.dart';

class OrganizationDetailScreen extends StatefulWidget {
  final OrganizationMember organization;

  const OrganizationDetailScreen({
    super.key,
    required this.organization,
  });

  @override
  State<OrganizationDetailScreen> createState() => _OrganizationDetailScreenState();
}

class _OrganizationDetailScreenState extends State<OrganizationDetailScreen> {
  late final OrganizationService _organizationService;
  late final InviteService _inviteService;
  
  List<OrganizationMember> _members = [];
  bool _isLoading = true;
  String? _error;
  int _membersCount = 0;

  @override
  void initState() {
    super.initState();
    
    final dioClient = context.read<DioClient>();
    _organizationService = OrganizationService(dioClient);
    _inviteService = InviteService(dioClient);
    
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final members = await _organizationService.getOrganizationMembers(
        widget.organization.org.id,
      );
      
      if (mounted) {
        setState(() {
          _members = members;
          _membersCount = members.length;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceFirst('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _inviteMember(String email) async {
    setState(() => _isLoading = true);

    try {
      // TODO: получить правильный roleId для приглашения
      // Обычно роль "member" имеет id = 2
      await _inviteService.createInvite(
        2, // roleId - позиционный параметр
        email, // email - позиционный параметр
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Приглашение отправлено'),
            backgroundColor: Colors.green,
          ),
        );
        // Перезагружаем список участников после приглашения
        _loadMembers();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString().replaceFirst('Exception: ', '')}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showInviteDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Пригласить в организацию'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Email пользователя',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (controller.text.isNotEmpty) {
                _inviteMember(controller.text);
              }
            },
            child: const Text('Пригласить'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    // TODO: реализовать редактирование организации
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Редактирование организации в разработке')),
    );
  }

  Future<void> _deleteOrganization() async {
    // TODO: реализовать удаление организации
    setState(() => _isLoading = true);
    
    // Имитация удаления
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Организация удалена'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить организацию'),
        content: Text(
          'Вы уверены, что хотите удалить "${widget.organization.organizationName}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteOrganization();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  Future<void> _leaveOrganization() async {
    // TODO: реализовать выход из организации
    setState(() => _isLoading = true);
    
    // Имитация выхода
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Вы покинули организацию'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Покинуть организацию'),
        content: Text(
          'Вы уверены, что хотите покинуть "${widget.organization.organizationName}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _leaveOrganization();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Покинуть'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.organization.isAdmin;
    final avatarColor = isAdmin ? AppColors.plusButton : AppColors.calendarButton;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          widget.organization.organizationName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.grayFieldText,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
        actions: [
          OrganizationMenu(
            userRole: isAdmin ? 'Администратор' : 'Участник',
            onEdit: isAdmin ? () => _showEditDialog(context) : null,
            onDelete: isAdmin ? () => _showDeleteDialog(context) : null,
            onLeave: () => _showLeaveDialog(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ошибка: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadMembers,
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Статистика
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.notesBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.directoryBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn(
                            'Участников',
                            _membersCount.toString(),
                            avatarColor,
                          ),
                          _buildStatColumn(
                            'Роль',
                            isAdmin ? 'Администратор' : 'Участник',
                            avatarColor,
                          ),
                        ],
                      ),
                    ),

                    // Заголовок и кнопка приглашения
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Участники',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grayFieldText,
                            ),
                          ),
                          if (isAdmin)
                            TextButton.icon(
                              onPressed: () => _showInviteDialog(context),
                              icon: const Icon(Icons.person_add, size: 18),
                              label: const Text('Пригласить'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.plusButton,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Список участников
                    Expanded(
                      child: _members.isEmpty
                          ? const Center(
                              child: Text('В организации пока нет участников'),
                            )
                          : ListView(
                              padding: const EdgeInsets.all(16),
                              children: _members.map((member) {
                                return MemberItem(
                                  name: member.memberName,
                                  email: member.memberEmail,
                                  role: member.roleTitle,
                                  avatarColor: avatarColor,
                                  isCurrentUser: member.profile.id == widget.organization.profile.id,
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.directoryTextSecondary,
          ),
        ),
      ],
    );
  }
}