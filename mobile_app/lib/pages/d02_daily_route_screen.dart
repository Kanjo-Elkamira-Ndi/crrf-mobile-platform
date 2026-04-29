import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// D-02 — Daily Route Screen
// ═════════════════════════════════════════════════════════════
/// Shows the driver's full list of pickups for today.
/// Each pickup row shows address, time window, waste types.
/// Tapping a row → D-03 (Pickup Task Screen)
class DailyRouteScreen extends StatelessWidget {
  const DailyRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with DriverBloc data
    final List<_PickupTask> _pickups = [
      _PickupTask(
        id: 'P-001',
        householdName: 'Ama Mbarga',
        address: 'Quartier Bastos, Yaounde',
        timeWindow: '7:00 – 10:00 AM',
        wasteTypes: ['Plastic', 'Organic'],
        status: PickupStatus.pending,
        distance: '1.2 km',
      ),
      _PickupTask(
        id: 'P-002',
        householdName: 'Jean Nkolo',
        address: 'Quartier Mvog-Mbi, Yaounde',
        timeWindow: '10:30 AM – 1:00 PM',
        wasteTypes: ['Glass', 'Organic'],
        status: PickupStatus.pending,
        distance: '2.5 km',
      ),
      _PickupTask(
        id: 'P-003',
        householdName: 'Claire Bikono',
        address: 'Quartier Mokolo, Yaounde',
        timeWindow: '2:00 – 5:00 PM',
        wasteTypes: ['Plastic', 'Paper'],
        status: PickupStatus.pending,
        distance: '3.8 km',
      ),
      _PickupTask(
        id: 'P-004',
        householdName: 'Paul Essomba',
        address: 'Quartier Etoudi, Yaounde',
        timeWindow: '5:30 – 7:00 PM',
        wasteTypes: ['Organic', 'E-waste'],
        status: PickupStatus.pending,
        distance: '4.2 km',
      ),
    ];

    return DriverScaffold(
      currentTab: DriverNavTab.myRoute,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Today\'s Route'),
          leading: const BackButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                // TODO: Refresh route data
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // ── Route summary header ───────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _RouteStat(
                    value: '${_pickups.length}',
                    label: 'Pickups',
                    icon: Icons.inventory_2_rounded,
                  ),
                  Container(width: 1, height: 40, color: AppColors.borderLight),
                  _RouteStat(
                    value: '12.4 km',
                    label: 'Total Distance',
                    icon: Icons.route_rounded,
                  ),
                  Container(width: 1, height: 40, color: AppColors.borderLight),
                  _RouteStat(
                    value: '~4.5 hrs',
                    label: 'Est. Time',
                    icon: Icons.schedule_rounded,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ── Pickup list ─────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                itemCount: _pickups.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _PickupCard(
                  pickup: _pickups[i],
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.pickupTask,
                    arguments: {'pickupId': _pickups[i].id},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Pickup task model ────────────────────────────────────────
class _PickupTask {
  final String id, householdName, address, timeWindow, distance;
  final List<String> wasteTypes;
  final PickupStatus status;

  const _PickupTask({
    required this.id,
    required this.householdName,
    required this.address,
    required this.timeWindow,
    required this.wasteTypes,
    required this.status,
    required this.distance,
  });
}

// ─── Route stat widget ────────────────────────────────────────
class _RouteStat extends StatelessWidget {
  final String value, label;
  final IconData icon;
  const _RouteStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.infoBlue, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.h4.copyWith(color: AppColors.infoBlue),
        ),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

// ─── Pickup card ──────────────────────────────────────────────
class _PickupCard extends StatelessWidget {
  final _PickupTask pickup;
  final VoidCallback onTap;
  const _PickupCard({required this.pickup, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Order number
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.infoLight,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: Center(
                child: Text(
                  '#${pickup.id.substring(2, 5)}',
                  style: AppTextStyles.h4.copyWith(color: AppColors.infoBlue),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pickup.householdName,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        pickup.distance,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          pickup.address,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: pickup.wasteTypes
                            .map(
                              (w) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: _WasteTypeChip(label: w),
                              ),
                            )
                            .toList(),
                      ),
                      Text(
                        pickup.timeWindow,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.infoBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}

class _WasteTypeChip extends StatelessWidget {
  final String label;
  const _WasteTypeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.greenLighter,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.forestGreen,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
