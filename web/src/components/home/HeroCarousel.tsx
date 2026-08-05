'use client';

import { motion, AnimatePresence } from 'framer-motion';
import { useEffect, useState } from 'react';

const heroImages = [
  { src: '/hero_2.png', alt: 'Households sorting and earning credits' },
  { src: '/hero_3.avif', alt: 'Farmers receiving organic manure' },
];

export default function HeroCarousel() {
  const [current, setCurrent] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrent((prev) => (prev + 1) % heroImages.length);
    }, 6000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="absolute inset-0 overflow-hidden">
      <AnimatePresence initial={false}>
        <motion.div
          key={current}
          className="absolute inset-0 bg-center bg-cover bg-no-repeat"
          style={{
            backgroundImage: `url(${heroImages[current].src})`,
          }}
          initial={{ opacity: 0, scale: 1.08 }}
          animate={{ opacity: 1, scale: 1 }}
          exit={{ opacity: 0, scale: 1 }}
          transition={{ duration: 1.2, ease: 'easeOut' }}
        />
      </AnimatePresence>

      {/* Dark overlay for text readability */}
      <div className="absolute inset-0 bg-crrf-forest/70" />

      {/* Progress indicators */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 flex items-center gap-2">
        {heroImages.map((_, i) => (
          <button
            key={i}
            type="button"
            aria-label={`Go to slide ${i + 1}`}
            onClick={() => setCurrent(i)}
            className="relative h-1.5 w-8 rounded-full bg-white/30 hover:bg-white/50 transition-colors"
          >
            {i === current && (
              <motion.div
                className="absolute inset-0 h-1.5 rounded-full bg-crrf-gold"
                layoutId="carousel-progress"
                transition={{ duration: 0.6, ease: 'easeOut' }}
              />
            )}
          </button>
        ))}
      </div>
    </div>
  );
}
