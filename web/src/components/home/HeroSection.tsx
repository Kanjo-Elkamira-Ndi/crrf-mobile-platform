'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';
import CrrfCycleRing from './CrrfCycleRing';

export default function HeroSection() {
  return (
    <section className="relative min-h-screen bg-gradient-to-b from-crrf-forest via-crrf-forest to-[#0D3B1E] overflow-hidden">
      {/* Subtle texture overlay */}
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-20 left-10 w-72 h-72 rounded-full bg-crrf-gold/20 blur-3xl" />
        <div className="absolute bottom-40 right-10 w-96 h-96 rounded-full bg-crrf-green-mid/30 blur-3xl" />
      </div>

      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 min-h-screen flex items-center py-20">
        <div className="grid grid-cols-1 lg:grid-cols-5 gap-12 items-center w-full">
          {/* Left column - 60% */}
          <div className="lg:col-span-3 text-center lg:text-left">
            <motion.span
              className="inline-block px-4 py-1.5 rounded-full bg-crrf-gold/20 text-crrf-gold text-xs font-bold uppercase tracking-wider mb-6"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
            >
              Cameroon&apos;s Circular Economy Platform
            </motion.span>

            <motion.h1
              className="font-display text-5xl sm:text-6xl lg:text-7xl font-bold text-white leading-[1.1] mb-6"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.1 }}
            >
              From Waste to Worth.
              <br />
              {/* <span className="text-crrf-gold">From Harvest to Hope.</span> */}
            </motion.h1>

            <motion.p
              className="text-lg sm:text-xl text-white/80 mb-8 max-w-2xl mx-auto lg:mx-0 leading-relaxed"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.3 }}
            >
              CRRF connects households who sort waste, drivers who collect it, and farmers
              who grow with it — through a single digital platform and a voucher economy
              that rewards everyone.
            </motion.p>

            <motion.div
              className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start mb-6"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.5 }}
            >
              <Link
                href="/contact"
                className="inline-flex items-center justify-center rounded-full bg-crrf-gold text-crrf-forest font-semibold px-8 py-4 hover:scale-105 transition-transform shadow-[0_8px_32px_rgba(245,158,11,0.3)]"
              >
                Download the App
              </Link>
              <Link
                href="/how-it-works"
                className="inline-flex items-center justify-center rounded-full border-2 border-white text-white font-medium px-8 py-4 hover:bg-white hover:text-crrf-forest transition-colors"
              >
                Learn How It Works
              </Link>
            </motion.div>

            <motion.p
              className="text-sm text-white/50"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.8, delay: 0.7 }}
            >
              Available on Android · Launching 2026 · Yaounde, Cameroon 🇨🇲
            </motion.p>
          </div>

          {/* Right column - 40% */}
          <motion.div
            className="lg:col-span-2"
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 1, delay: 0.4 }}
          >
            <CrrfCycleRing />
          </motion.div>
        </div>
      </div>
    </section>
  );
}
