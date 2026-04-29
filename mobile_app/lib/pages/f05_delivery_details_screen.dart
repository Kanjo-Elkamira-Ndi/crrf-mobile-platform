import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// F-05 — Delivery Details Screen
// ═════════════════════════════════════════════════════════════
/// Farmer fills in delivery address + preferred window + notes.
/// On submit → Order is placed → navigate to F-06 Confirmation.
class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedDistrict;
  String? _selectedWindow;
  bool _isLoading = false;

  static const _deliveryWindows = [
    {'key': 'morning', 'label': 'Morning  (7:00 AM – 12:00 PM)'},
    {'key': 'afternoon', 'label': 'Afternoon (12:00 PM – 5:00 PM)'},
    {'key': 'anytime', 'label': 'Any time — driver will call'},
  ];

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedWindow == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a delivery window.')),
      );
      return;
    }
    setState(() => _isLoading = true);
    // TODO: Call OrderRepository.placeOrder(cart, deliveryDetails)
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacementNamed(AppRoutes.orderConfirmation);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _landmarkController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FarmerScaffold(
      currentTab: FarmerNavTab.orders,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Delivery Details'),
          leading: const BackButton(),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // ── Address ──────────────────────────────────
                    Text('Delivery Address', style: AppTextStyles.h4),
                    const SizedBox(height: 14),

                    DropdownButtonFormField<String>(
                      value: _selectedDistrict,
                      decoration: InputDecoration(
                        labelText: 'District',
                        prefixIcon: const Icon(Icons.location_city_outlined),
                        filled: true,
                        fillColor: AppColors.inputBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.borderLight,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.borderLight,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: AppColors.forestGreen,
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: AppTextStyles.body,
                      items: AppConstants.districts
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedDistrict = v),
                      validator: (v) =>
                          v == null ? 'Please select your district' : null,
                    ),

                    const SizedBox(height: 12),
                    CrrfTextField(
                      label: 'Street Address / Village',
                      hint: 'e.g. Quartier Bastos, Rue 1.234',
                      controller: _addressController,
                      prefixIcon: const Icon(Icons.home_outlined),
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Address is required'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    CrrfTextField(
                      label: 'Landmark (optional)',
                      hint: 'e.g. Near the blue water tower',
                      controller: _landmarkController,
                      prefixIcon: const Icon(Icons.place_outlined),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 12),
                    CrrfTextField(
                      label: 'Contact Phone',
                      hint: '6XX XXX XXX',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Phone number is required'
                          : null,
                    ),

                    const SizedBox(height: 24),

                    // ── Delivery window ───────────────────────────
                    Text('Preferred Delivery Window', style: AppTextStyles.h4),
                    const SizedBox(height: 12),
                    ..._deliveryWindows.map((w) {
                      final isSelected = _selectedWindow == w['key'];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedWindow = w['key']),
                        child: AnimatedContainer(
                          duration: AppConstants.animFast,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.brownLighter
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusL,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.earthBrown
                                  : AppColors.borderLight,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                color: isSelected
                                    ? AppColors.earthBrown
                                    : AppColors.textHint,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  w['label']!,
                                  style: AppTextStyles.body.copyWith(
                                    color: isSelected
                                        ? AppColors.earthBrown
                                        : AppColors.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.earthBrown,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 24),

                    // ── Notes ────────────────────────────────────
                    Text(
                      'Additional Notes (optional)',
                      style: AppTextStyles.h4,
                    ),
                    const SizedBox(height: 12),
                    CrrfTextField(
                      label: 'e.g. Call before arrival, leave at gate',
                      controller: _notesController,
                      maxLines: 3,
                      prefixIcon: const Icon(Icons.notes_rounded),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // ── Place order CTA ──────────────────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                color: AppColors.white,
                child: CrrfPrimaryButton(
                  label: 'Place Order',
                  onPressed: _placeOrder,
                  isLoading: _isLoading,
                  leadingIcon: Icons.check_circle_outline_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
