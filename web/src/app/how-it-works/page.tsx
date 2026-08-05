import type { Metadata } from 'next';
import ProcessTimeline from '@/components/how-it-works/ProcessTimeline';
import CreditCalculator from '@/components/how-it-works/CreditCalculator';

export const metadata: Metadata = {
  title: 'How It Works — CRRF',
  description: 'The complete CRRF process from household registration to farm delivery.',
};

export default function HowItWorksPage() {
  return (
    <>
      {/* Hero */}
      <section className="bg-crrf-forest text-white py-20">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="font-display text-4xl sm:text-5xl font-bold mb-4">
            How CRRF Works
          </h1>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            A step-by-step walkthrough of the circular economy loop — from the moment a
            household sorts their waste to the moment a farmer receives their manure.
          </p>
        </div>
      </section>

      {/* Timeline */}
      <section className="bg-crrf-white py-16">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <ProcessTimeline />
        </div>
      </section>

      {/* Credit Calculator */}
      <section className="bg-crrf-green-faint py-16">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Try It Yourself
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Calculate your credits
            </h2>
            <p className="text-crrf-muted mt-4 max-w-xl mx-auto">
              Enter the weight of waste you could sort at home and see what you&apos;d earn in
              CRF Credits.
            </p>
          </div>
          <CreditCalculator />
        </div>
      </section>
    </>
  );
}
