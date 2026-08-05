import Link from 'next/link';

const platformLinks = [
  { href: '/how-it-works', label: 'How It Works' },
  { href: '/for-households', label: 'For Households' },
  { href: '/for-farmers', label: 'For Farmers' },
  { href: '/about', label: 'About' },
  { href: '/contact', label: 'Contact' },
];

const householdLinks = [
  { href: '/for-households', label: 'Household Features' },
  { href: '/how-it-works', label: 'Credit System' },
  { href: '/about', label: 'Environmental Impact' },
];

const farmerLinks = [
  { href: '/for-farmers', label: 'Farmer Features' },
  { href: '/how-it-works', label: 'Available Manure' },
  { href: '/how-it-works', label: 'Micro-Loans' },
];

const companyLinks = [
  { href: '/about', label: 'Our Mission' },
  { href: '/about', label: 'Team' },
  { href: '/contact', label: 'Contact' },
  { href: '/contact', label: 'Careers' },
];

export default function Footer() {
  return (
    <footer className="bg-crrf-forest text-crrf-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-16 pb-8">
        <div className="grid grid-cols-1 gap-12 md:grid-cols-2 lg:grid-cols-5">
          {/* Logo & Tagline */}
          <div className="lg:col-span-1">
            <Link href="/" className="flex items-center space-x-3 mb-4">
              <span className="text-2xl">♻</span>
              <span className="font-display text-2xl font-bold">CRRF</span>
            </Link>
            <p className="text-sm opacity-80">
              Waste to Value. Crops to Markets.
            </p>
          </div>

          {/* Platform Links */}
          <div>
            <h3 className="font-semibold text-white mb-4">Platform</h3>
            <ul className="space-y-3">
              {platformLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-sm opacity-80 hover:text-white transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Household Links */}
          <div>
            <h3 className="font-semibold text-white mb-4">Households</h3>
            <ul className="space-y-3">
              {householdLinks.map((link) => (
                <li key={`${link.href}-${link.label}`}>
                  <Link
                    href={link.href}
                    className="text-sm opacity-80 hover:text-white transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Farmer Links */}
          <div>
            <h3 className="font-semibold text-white mb-4">Farmers</h3>
            <ul className="space-y-3">
              {farmerLinks.map((link) => (
                <li key={`${link.href}-${link.label}`}>
                  <Link
                    href={link.href}
                    className="text-sm opacity-80 hover:text-white transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Company Links */}
          <div>
            <h3 className="font-semibold text-white mb-4">Company</h3>
            <ul className="space-y-3">
              {companyLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-sm opacity-80 hover:text-white transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="border-t border-crrf-green-mid/20 mt-12 pt-8 flex flex-col sm:flex-row justify-between items-center">
          <p className="text-sm opacity-70">
            © 2026 Cam Recycle Roads & Farms / DigiMark Consulting · Built in Cameroon 🇨🇲
          </p>
          <div className="flex items-center space-x-4 mt-4 sm:mt-0">
            <a
              href="https://github.com/DigiMarkConsulting"
              target="_blank"
              rel="noopener noreferrer"
              className="p-2 text-crrf-white/60 hover:text-white transition-colors"
              aria-label="GitHub"
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                <path d="M12 .5C5.65.5.5 5.65.5 12c0 5.08 3.29 9.39 7.86 10.91.58.11.79-.25.79-.55 0-.27-.01-1.17-.02-2.12-3.2.7-3.88-1.36-3.88-1.36-.52-1.33-1.28-1.68-1.28-1.68-1.04-.71.08-.7.08-.7 1.15.08 1.76 1.18 1.76 1.18 1.03 1.76 2.7 1.25 3.36.96.1-.75.4-1.25.72-1.54-2.55-.29-5.24-1.28-5.24-5.68 0-1.26.45-2.28 1.18-3.09-.12-.29-.51-1.46.11-3.05 0 0 .96-.31 3.15 1.18a10.9 10.9 0 0 1 5.74 0c2.19-1.49 3.15-1.18 3.15-1.18.62 1.59.23 2.76.11 3.05.73.81 1.18 1.83 1.18 3.09 0 4.41-2.69 5.38-5.26 5.66.41.36.78 1.06.78 2.14 0 1.54-.01 2.79-.01 3.17 0 .31.21.67.8.55A11.52 11.52 0 0 0 23.5 12C23.5 5.65 18.35.5 12 .5Z" />
              </svg>
            </a>
            <a
              href="https://linkedin.com/company/digimarkconsulting"
              target="_blank"
              rel="noopener noreferrer"
              className="p-2 text-crrf-white/60 hover:text-white transition-colors"
              aria-label="LinkedIn"
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                <path d="M20.45 20.45h-3.55v-5.57c0-1.33-.03-3.04-1.85-3.04-1.85 0-2.14 1.45-2.14 2.94v5.67H9.35V9h3.41v1.56h.05c.48-.9 1.64-1.85 3.37-1.85 3.6 0 4.27 2.37 4.27 5.46v6.28ZM5.34 7.43a2.06 2.06 0 1 1 0-4.12 2.06 2.06 0 0 1 0 4.12ZM7.12 20.45H3.56V9h3.56v11.45ZM22.22 0H1.77C.79 0 0 .77 0 1.72v20.55C0 23.23.79 24 1.77 24h20.45c.98 0 1.78-.77 1.78-1.73V1.72C24 .77 23.2 0 22.22 0Z" />
              </svg>
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}
