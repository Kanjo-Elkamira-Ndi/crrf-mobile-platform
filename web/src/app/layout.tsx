import type { Metadata, Viewport } from 'next';
import { Playfair_Display, DM_Sans, JetBrains_Mono } from 'next/font/google';
import './globals.css';
import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/layout/Footer';

const playfair = Playfair_Display({
  subsets: ['latin'],
  variable: '--font-display',
  weight: ['700'],
});

const dmSans = DM_Sans({
  subsets: ['latin'],
  variable: '--font-sans',
  weight: ['400', '500', '600', '700'],
});

const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  variable: '--font-mono',
  weight: ['400', '700'],
});

export const metadata: Metadata = {
  title: 'CRRF — Cam Recycle Roads & Farms',
  description:
    "Cameroon's circular economy platform. Connecting households, farmers, and drivers through waste collection, CRF Credits, and an organic manure marketplace.",
  keywords: [
    'circular economy',
    'Cameroon',
    'waste management',
    'organic manure',
    'CRF Credits',
    'CRRF',
    'DigiMark',
  ],
  authors: [{ name: 'DigiMark Consulting' }],
  openGraph: {
    title: 'CRRF — Cam Recycle Roads & Farms',
    description: 'Waste to Value. Crops to Markets.',
    type: 'website',
    locale: 'en_CM',
  },
};

export const viewport: Viewport = {
  themeColor: '#1B6B3A',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${playfair.variable} ${dmSans.variable} ${jetbrainsMono.variable} scroll-smooth`}>
      <body className="min-h-screen flex flex-col font-sans text-crrf-ink overflow-x-hidden">
        <Navbar />
        <main className="flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
