import 'package:go_router/go_router.dart';

import 'pages/group_form_page.dart';
import 'pages/group_invite_page.dart';
import 'pages/group_home_page.dart';
import 'pages/group_list_page.dart';

final List<RouteBase> groupRoutes = [
  GoRoute(
    path: '/groups/created',
    builder: (context, state) => const GroupInvitePage(created: true),
  ),
  GoRoute(
    path: '/groups/invite',
    builder: (context, state) => const GroupInvitePage(),
  ),
  GoRoute(path: '/groups', builder: (context, state) => const GroupListPage()),
  GoRoute(
    path: '/groups/create',
    builder: (context, state) => const GroupFormPage(isJoining: false),
  ),
  GoRoute(
    path: '/groups/join',
    builder: (context, state) => const GroupFormPage(isJoining: true),
  ),
  GoRoute(
    path: '/groups/home',
    builder: (context, state) => const GroupHomePage(),
  ),
];
