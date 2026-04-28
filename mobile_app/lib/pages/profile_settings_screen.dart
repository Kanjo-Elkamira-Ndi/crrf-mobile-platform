import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile Settings',
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _ProfileHeader(
              name: 'John Kamga',
              email: 'johnkamga@email.com',
              role: 'Household',
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Account Section
            _SectionTitle(title: 'Account'),
            const SizedBox(height: AppConstants.spacingM),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Full Name',
                  subtitle: 'John Kamga',
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.mail_outline_rounded,
                  title: 'Email',
                  subtitle: 'johnkamga@email.com',
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.phone_outlined,
                  title: 'Phone Number',
                  subtitle: '+237 681 234 567',
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Address',
                  subtitle: 'Mfoundi, Yaoundé',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Preferences Section
            _SectionTitle(title: 'Preferences'),
            const SizedBox(height: AppConstants.spacingM),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'All enabled',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeTrackColor: AppColors.forestGreen,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Off',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeTrackColor: AppColors.forestGreen,
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Security Section
            _SectionTitle(title: 'Security'),
            const SizedBox(height: AppConstants.spacingM),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  subtitle: 'Last changed 30 days ago',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.fingerprint_rounded,
                  title: 'Biometric Login',
                  subtitle: 'Disabled',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeTrackColor: AppColors.forestGreen,
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Support Section
            _SectionTitle(title: 'Support'),
            const SizedBox(height: AppConstants.spacingM),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & FAQ',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Contact Support',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About',
                  subtitle: 'Version 1.0.0',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Legal Section
            _SectionTitle(title: 'Legal'),
            const SizedBox(height: AppConstants.spacingM),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded, color: AppColors.errorRed),
                label: Text(
                  'Log Out',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.errorRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.errorRed, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacingXL),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.greenLighter,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderGreen,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 36,
              color: AppColors.forestGreen,
            ),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.greenLighter,
                    borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                  ),
                  child: Text(
                    role,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.forestGreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.greenLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(width: AppConstants.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
      child: Divider(height: 1, color: AppColors.borderLight),
    );
  }
}
