'use client';

import { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Menu, X } from 'lucide-react';
import { cn } from '@/lib/utils';

const navLinks = [
  { href: '/how-it-works', label: 'How It Works' },
  { href: '/for-households', label: 'For Households' },
  { href: '/for-farmers', label: 'For Farmers' },
  { href: '/about', label: 'About' },
  { href: '/contact', label: 'Contact' },
];

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const activePath = usePathname();

  return (
    <>
      <nav className="sticky top-0 z-50 bg-crrf-white border-b border-crrf-border">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex h-16 items-center justify-between">
            <Link href="/" className="flex items-center space-x-3">
              <span className="text-crrf-forest text-2xl">♻</span>
              <span className="font-display text-2xl font-bold text-crrf-forest">
                CRRF
              </span>
            </Link>

            <div className="hidden md:flex items-center space-x-8">
              {navLinks.map((link) => {
                const isActive = activePath === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={cn(
                      'relative text-sm font-medium transition-colors hover:text-crrf-forest',
                      isActive ? 'text-crrf-forest' : 'text-crrf-muted',
                    )}
                  >
                    {link.label}
                    {isActive && (
                      <span className="absolute -bottom-1 left-0 w-1.5 h-1.5 rounded-full bg-crrf-forest" />
                    )}
                  </Link>
                );
              })}
              <Link
                href="/contact"
                className="ml-4 rounded-full bg-crrf-forest px-5 py-2 text-sm font-medium text-white hover:bg-crrf-green-mid transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-crrf-forest"
              >
                Download App
              </Link>
            </div>

            <button
              type="button"
              onClick={() => setIsOpen(!isOpen)}
              className="md:hidden p-2 text-crrf-ink hover:text-crrf-forest focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-crrf-forest rounded-md"
              aria-label={isOpen ? 'Close menu' : 'Open menu'}
            >
              {isOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile menu */}
      {isOpen && (
        <div
          className="fixed inset-0 z-40 md:hidden bg-crrf-white"
          style={{ top: '64px' }}
        >
          <div className="h-[calc(100vh-64px)] overflow-y-auto">
            <div className="px-4 pt-4 pb-6 space-y-1 border-t border-crrf-border">
              {navLinks.map((link) => {
                const isActive = activePath === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    onClick={() => setIsOpen(false)}
                    className={cn(
                      'block px-4 py-3 text-lg font-medium transition-colors',
                      isActive
                        ? 'text-crrf-forest bg-crrf-green-faint'
                        : 'text-crrf-ink hover:bg-crrf-green-faint hover:text-crrf-forest',
                    )}
                  >
                    {link.label}
                  </Link>
                );
              })}
              <div className="px-4 pt-4 border-t border-crrf-border">
                <Link
                  href="/contact"
                  onClick={() => setIsOpen(false)}
                  className="block w-full text-center bg-crrf-forest text-white py-3 rounded-full font-medium hover:bg-crrf-green-mid transition-colors"
                >
                  Download App
                </Link>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
