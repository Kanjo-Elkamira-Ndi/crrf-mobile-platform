'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import { Smartphone } from 'lucide-react';
import { APP_DOWNLOAD_URL } from '@/lib/download';

export default function DownloadCTA() {
  const [email, setEmail] = useState('');
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Beta waitlist signup:', email);
    setSubmitted(true);
    setEmail('');
  };

  return (
    <section
      id="download"
      className="py-20 bg-gradient-to-br from-crrf-forest to-crrf-green-mid text-white relative overflow-hidden"
    >
      {/* Decorative circles */}
      <div className="absolute top-0 right-0 w-64 h-64 rounded-full bg-white/5 -translate-y-1/2 translate-x-1/2" />
      <div className="absolute bottom-0 left-0 w-48 h-48 rounded-full bg-crrf-gold/10 translate-y-1/2 -translate-x-1/2" />

      <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <motion.h2
          className="font-display text-4xl sm:text-5xl font-bold mb-4"
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          Ready to close the loop?
        </motion.h2>
        <p className="text-lg text-white/80 mb-8 max-w-2xl mx-auto">
          Download the CRRF app and join the circular economy movement in Cameroon.
        </p>

        <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-8">
          <a
            href={APP_DOWNLOAD_URL}
            className="inline-flex items-center justify-center rounded-full bg-crrf-gold text-crrf-forest font-semibold px-8 py-4 hover:scale-105 transition-transform shadow-lg"
          >
            Get the Android App
          </a>
          <a
            href="#"
            className="inline-flex items-center justify-center rounded-full border-2 border-white text-white font-medium px-8 py-4 hover:bg-white hover:text-crrf-forest transition-colors"
          >
            Join the Beta Waitlist
          </a>
        </div>

        {/* Beta waitlist form */}
        {submitted ? (
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="inline-flex items-center px-6 py-3 rounded-full bg-crrf-gold-light/20 text-crrf-gold-light border border-crrf-gold/30"
          >
            <span className="mr-2">✓</span>
            You&apos;re on the list! We&apos;ll be in touch.
          </motion.div>
        ) : (
          <form onSubmit={handleSubmit} className="max-w-md mx-auto">
            <div className="flex flex-col sm:flex-row gap-3">
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Enter your email"
                required
                className="flex-1 px-5 py-3 rounded-full text-crrf-ink bg-white border-0 focus:outline-none focus:ring-2 focus:ring-crrf-gold"
              />
              <button
                type="submit"
                className="px-6 py-3 rounded-full bg-crrf-gold text-crrf-forest font-semibold hover:scale-105 transition-transform whitespace-nowrap"
              >
                Join Waitlist
              </button>
            </div>
          </form>
        )}

        <div className="mt-8 inline-flex items-center px-4 py-2 rounded-full bg-white/10 text-white/60 text-sm">
            <Smartphone className="h-4 w-4 mr-2 inline-block" />
          Available on Android · Coming 2026
        </div>
      </div>
    </section>
  );
}
