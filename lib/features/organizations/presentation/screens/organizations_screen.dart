import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.dart'; 
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
import 'package:treemov/features/directory/presentation/widgets/search_field.dart';
import 'package:treemov/features/organizations/presentation/widgets/organization_item.dart';
import 'package:treemov/features/organizations/presentation/widgets/invite_item.dart';
import 'package:treemov/features/organizations/presentation/widgets/section_header.dart';
import 'package:treemov/features/organizations/presentation/widgets/empty_states.dart';
import 'package:treemov/features/organizations/presentation/dialogs/create_organization_dialog.dart';
import 'package:treemov/features/organizations/presentation/dialogs/accept_invite_dialog.dart';
import 'package:treemov/features/organizations/presentation/screens/organization_detail_screen.dart';
import 'package:treemov/features/organizations/models/organization.dart';
import 'package:treemov/features/organizations/models/invite.dart';
import 'package:treemov/features/organizations/services/organization_service.dart';
import 'package:treemov/features/organizations/services/invite_service.dart';
import 'package:treemov/core/network/dio_client.dart'; 

class OrganizationsScreen extends StatelessWidget {
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OrganizationsScreenContent();
  }
}

class _OrganizationsScreenContent extends StatefulWidget {
  const _OrganizationsScreenContent();

  @override
  State<_OrganizationsScreenContent> createState() =>
      _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<_OrganizationsScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  
  late final OrganizationService _organizationService;
  late final InviteService _inviteService;
  
  List<OrganizationMember> _adminOrganizations = [];
  List<OrganizationMember> _memberOrganizations = [];
  List<Invite> _pendingInvites = [];

  List<OrganizationMember> _filteredAdmin = [];
  List<OrganizationMember> _filteredMember = [];
  List<Invite> _filteredInvites = [];

  bool _isLoading = true;
  String? _error;
  bool _hasSearchQuery = false;

  @override
  void initState() {
    super.initState();
    
    // Получаем DioClient через getIt вместо context.read
    final dioClient = getIt<DioClient>();
    
    _organizationService = OrganizationService(dioClient);
    _inviteService = InviteService(dioClient);
    
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Загружаем данные параллельно
      final results = await Future.wait([
        _organizationService.getMyOrganizations(),
        _inviteService.getInvites(),
      ]);

      final organizations = results[0] as List<OrganizationMember>;
      final invites = results[1] as List<Invite>;

      if (mounted) {
        setState(() {
          _splitOrganizationsByRole(organizations);
          _pendingInvites = invites;
          _filteredInvites = List.from(invites);
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

  void _splitOrganizationsByRole(List<OrganizationMember> organizations) {
    _adminOrganizations = organizations.where((org) => org.isAdmin).toList();
    _memberOrganizations = organizations.where((org) => org.isMember).toList();

    _filteredAdmin = List.from(_adminOrganizations);
    _filteredMember = List.from(_memberOrganizations);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _hasSearchQuery = query.isNotEmpty;

      if (query.isEmpty) {
        _filteredAdmin = List.from(_adminOrganizations);
        _filteredMember = List.from(_memberOrganizations);
        _filteredInvites = List.from(_pendingInvites);
      } else {
        _filteredAdmin = _adminOrganizations.where((org) {
          return org.organizationName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        _filteredMember = _memberOrganizations.where((org) {
          return org.organizationName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        _filteredInvites = _pendingInvites.where((invite) {
          return invite.email.toLowerCase().contains(query.toLowerCase()) ||
              invite.role.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onOrganizationTap(OrganizationMember organization) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrganizationDetailScreen(
          organization: organization,
        ),
      ),
    );
  }

  Future<void> _acceptInvite(Invite invite) async {
    // TODO: когда бэкенд будет готов, раскомментировать
    /*
    showDialog(
      context: context,
      builder: (context) => AcceptInviteDialog(
        organizationName: 'Организация', // TODO: получить название из invite
        inviterName: invite.email,
        onConfirm: () async {
          Navigator.pop(context);
          
          setState(() => _isLoading = true);
          
          try {
            if (invite.uuid != null) {
              await _inviteService.acceptInvite(invite.uuid!);
            }
            await _loadData();
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Вы присоединились к организации'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ошибка: ${e.toString().replaceFirst('Exception: ', '')}'),
                  backgroundColor: Colors.red,
                ),
              );
              setState(() => _isLoading = false);
            }
          }
        },
      ),
    );
    */
    
    // Временное решение пока бэкенд не готов
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Функция принятия приглашений временно недоступна'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _declineInvite(Invite invite) async {
    // TODO: добавить метод отклонения, когда будет на бэкенде
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Отклонить приглашение'),
        content: Text(
          'Вы уверены, что хотите отклонить приглашение?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pendingInvites.removeWhere((i) => i.id == invite.id);
                _filteredInvites.removeWhere((i) => i.id == invite.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Приглашение отклонено'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Отклонить'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateOrganizationDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => CreateOrganizationDialog(
        onConfirm: (name) {
          Navigator.pop(context, name);
        },
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _isLoading = true);

      try {
        final newOrg = await _organizationService.createOrganization(result);
        await _loadData();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Организация "${newOrg.organizationName}" создана'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка: ${e.toString().replaceFirst('Exception: ', '')}'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const AppBarTitle(text: 'Мои организации'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateOrganizationDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: 'Поиск организаций...',
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? _buildErrorWidget()
                    : RefreshIndicator(
                        onRefresh: _loadData,
                        child: _buildContent(),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ошибка: $_error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    bool hasAnyContent = _filteredAdmin.isNotEmpty ||
        _filteredMember.isNotEmpty ||
        _filteredInvites.isNotEmpty;

    if (_hasSearchQuery && !hasAnyContent) {
      return const EmptySearchView();
    }

    if (!hasAnyContent) {
      return EmptyOrganizationsView(
        onCreatePressed: _showCreateOrganizationDialog,
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (_filteredInvites.isNotEmpty) ...[
          const SectionHeader(title: 'Приглашения', icon: Icons.mail_outline),
          ..._filteredInvites.map(
            (invite) => InviteItem(
              organizationName: 'Организация', // TODO: заменить на реальное название
              inviterName: invite.email,
              inviterEmail: invite.email,
              createdAt: _formatDate(invite.createdAt),
              onAccept: () => _acceptInvite(invite),
              onDecline: () => _declineInvite(invite),
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (_filteredAdmin.isNotEmpty) ...[
          const SectionHeader(
            title: 'Администрируемые',
            icon: Icons.admin_panel_settings,
          ),
          ..._filteredAdmin.map(
            (org) => OrganizationItem(
              organizationName: org.organizationName,
              memberCount: 0, // TODO: получить количество участников
              userRole: 'Администратор',
              avatarColor: AppColors.plusButton,
              onTap: () => _onOrganizationTap(org),
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (_filteredMember.isNotEmpty) ...[
          const SectionHeader(title: 'Участвую', icon: Icons.people_outline),
          ..._filteredMember.map(
            (org) => OrganizationItem(
              organizationName: org.organizationName,
              memberCount: 0, // TODO: получить количество участников
              userRole: 'Участник',
              avatarColor: AppColors.calendarButton,
              onTap: () => _onOrganizationTap(org),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}