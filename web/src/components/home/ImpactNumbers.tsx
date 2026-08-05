'use client';

import { useRef, useEffect, useState } from 'react';
import { motion, useInView, useReducedMotion } from 'framer-motion';

interface CounterProps {
  value: string;
  label: string;
  accentColor?: string;
  suffix?: string;
  prefix?: string;
}

const counters: CounterProps[] = [
  { value: '10', label: 'CRF Credits per kg of plastic sorted', accentColor: '#1B6B3A' },
  { value: '5', label: 'CRF Credits per kg of organic waste sorted', accentColor: '#2E8B57' },
  { value: '3', label: 'User roles connected in one platform', accentColor: '#6D4C41' },
  { value: '0', label: 'Cost to households for collection', suffix: ' XAF', accentColor: '#F59E0B' },
];

function CounterItem({ value, label, accentColor, suffix = '', prefix = '' }: CounterProps) {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref, { once: true, margin: '0px 0px -100px 0px' });
  const shouldReduceMotion = useReducedMotion();
  const [displayValue, setDisplayValue] = useState(shouldReduceMotion ? value : '0');

  useEffect(() => {
    if (!isInView || shouldReduceMotion) return;

    const target = parseFloat(value);
    const duration = 2000;
    const steps = 60;
    const increment = target / steps;
    let current = 0;

    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        current = target;
        clearInterval(timer);
      }
      setDisplayValue(current % 1 === 0 ? current.toFixed(0) : current.toFixed(1));
    }, duration / steps);

    return () => clearInterval(timer);
  }, [isInView, value, shouldReduceMotion]);

  return (
    <motion.div
      ref={ref}
      className="text-center"
      initial={{ opacity: 0, y: 20 }}
      animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 20 }}
      transition={{ duration: shouldReduceMotion ? 0 : 0.6, delay: shouldReduceMotion ? 0 : 0.1 }}
    >
      <div className="flex items-center justify-center">
        {prefix && <span className="text-crrf-subtle font-mono text-lg">{prefix}</span>}
        <span
          className="text-4xl sm:text-5xl font-bold font-mono"
          style={{ color: accentColor }}
        >
          {displayValue}
        </span>
        {suffix && <span className="text-crrf-subtle font-mono text-lg">{suffix}</span>}
      </div>
      <div
        className="w-16 h-1 mx-auto mt-3 rounded-full"
        style={{ backgroundColor: accentColor, opacity: 0.3 }}
      />
      <p className="text-sm text-crrf-muted mt-2 max-w-xs mx-auto">
        {label}
      </p>
    </motion.div>
  );
}

export default function ImpactNumbers() {
  return (
    <section className="py-16 bg-crrf-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <p className="text-crrf-gold font-semibold text-sm uppercase tracking-wider mb-2">
            The Economics
          </p>
          <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest">
            Your waste has real value. Here&apos;s how it&apos;s measured.
          </h2>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-12">
          {counters.map((counter) => (
            <CounterItem
              key={counter.label}
              value={counter.value}
              label={counter.label}
              accentColor={counter.accentColor}
              suffix={counter.suffix}
              prefix={counter.prefix}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
