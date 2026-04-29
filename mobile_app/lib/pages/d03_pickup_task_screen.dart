import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// D-03 — Pickup Task Screen
// ═════════════════════════════════════════════════════════════
/// Detailed view of a single pickup task.
/// Driver can:
///   • See household details and exact location
///   • Mark as completed (D-04 → D-05)
///   • Report issue (D-06)
///   • Call household directly
class PickupTaskScreen extends StatelessWidget {
  final String pickupId;
  const PickupTaskScreen({super.key, required this.pickupId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real data via DriverBloc using pickupId
    return DriverScaffold(
      currentTab: DriverNavTab.myRoute,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Pickup Task'),
          leading: const BackButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.phone_rounded),
              onPressed: () {
                // TODO: Launch phone dialer
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Status badge ──────────────────────────────────
              Center(child: StatusBadge.fromPickupStatus(PickupStatus.pending)),
              const SizedBox(height: 20),

              // ── Household card ────────────────────────────────
              _InfoCard(
                title: 'Household Information',
                icon: Icons.person_outline_rounded,
                children: [
                  _InfoRow(label: 'Name', value: 'Ama Mbarga'),
                  const Divider(height: 20),
                  _InfoRow(label: 'Phone', value: '+237 6XX XXX XXX'),
                  const Divider(height: 20),
                  _InfoRow(
                    label: 'Address',
                    value:
                        'Quartier Bastos, Yaounde\n(Opposite the water tower)',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Waste details ─────────────────────────────────
              _InfoCard(
                title: 'Waste to Collect',
                icon: Icons.recycling_rounded,
                children: [
                  _WasteDetailRow(
                    type: 'Plastic',
                    quantity: '2 bags',
                    icon: Icons.recycling_rounded,
                  ),
                  const Divider(height: 16),
                  _WasteDetailRow(
                    type: 'Organic',
                    quantity: '1 bin',
                    icon: Icons.eco_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Time window ───────────────────────────────────
              _InfoCard(
                title: 'Time Window',
                icon: Icons.schedule_rounded,
                children: [
                  _InfoRow(label: 'Window', value: '7:00 – 10:00 AM'),
                  const Divider(height: 20),
                  _InfoRow(
                    label: 'Est. Arrival',
                    value: '8:15 AM (15 min away)',
                    valueColor: AppColors.infoBlue,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Special instructions ──────────────────────────
              _InfoCard(
                title: 'Special Instructions',
                icon: Icons.notes_rounded,
                children: [
                  Text(
                    'Call upon arrival. Waste is placed at the back gate. Please knock twice.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Action buttons ─────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: CrrfSecondaryButton(
                      label: 'Report Issue',
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.reportIssue,
                          arguments: {'pickupId': pickupId},
                        );
                      },
                      leadingIcon: Icons.flag_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CrrfPrimaryButton(
                      label: 'Confirm Pickup',
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.confirmSuccess,
                          arguments: {'pickupId': pickupId},
                        );
                      },
                      leadingIcon: Icons.check_circle_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Info card wrapper ────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.infoBlue, size: 22),
              const SizedBox(width: 10),
              Text(title, style: AppTextStyles.h4),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// ─── Info row ─────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: valueColor != null
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Waste detail row ─────────────────────────────────────────
class _WasteDetailRow extends StatelessWidget {
  final String type, quantity;
  final IconData icon;
  const _WasteDetailRow({
    required this.type,
    required this.quantity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.greenLighter,
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          child: Icon(icon, color: AppColors.forestGreen, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type, style: AppTextStyles.bodySmall),
              Text(quantity, style: AppTextStyles.caption),
            ],
          ),
        ),
        StatusBadge.fromPickupStatus(PickupStatus.pending),
      ],
    );
  }
}
