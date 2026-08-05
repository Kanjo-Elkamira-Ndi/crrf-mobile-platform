import HeroSection from '@/components/home/HeroSection';
import HowItWorksSnippet from '@/components/home/HowItWorksSnippet';
import ImpactNumbers from '@/components/home/ImpactNumbers';
import ActorCards from '@/components/home/ActorCards';
import VoucherExplainer from '@/components/home/VoucherExplainer';
import TestimonialsSection from '@/components/home/TestimonialsSection';
import DownloadCTA from '@/components/home/DownloadCTA';
import { Trash2, Sprout, Home } from 'lucide-react';

const problems = [
  {
    icon: Trash2,
    title: '6M tonnes of waste',
    description: 'Less than 15% is properly managed in Cameroon',
  },
  {
    icon: Sprout,
    title: 'Fertiliser access gap',
    description: 'Smallholder farmers lack access to affordable organic fertiliser',
  },
  {
    icon: Home,
    title: 'No rewarded channel',
    description: 'Households have no formal, rewarded channel for waste disposal',
  },
];

export default function HomePage() {
  return (
    <>
      {/* Section 1 — Hero */}
      <HeroSection />

      {/* Section 2 — The Problem We Solve */}
      <section className="py-16 bg-crrf-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              The Problem
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Three problems. One solution.
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
            {problems.map((problem) => {
              const Icon = problem.icon;
              return (
                <div
                  key={problem.title}
                  className="bg-crrf-bg rounded-[12px] p-8 border border-crrf-border border-l-4 border-l-amber-500"
                >
                  <div className="w-12 h-12 rounded-full bg-amber-100 flex items-center justify-center mb-4">
                    <Icon className="h-6 w-6 text-amber-600" />
                  </div>
                  <h3 className="font-semibold text-crrf-ink mb-2">{problem.title}</h3>
                  <p className="text-sm text-crrf-muted leading-relaxed">
                    {problem.description}
                  </p>
                </div>
              );
            })}
          </div>

          <p className="text-center text-crrf-forest italic font-display text-xl">
            CRRF solves all three. At once.
          </p>
        </div>
      </section>

      {/* Section 3 — How It Works */}
      <HowItWorksSnippet />

      {/* Section 4 — Impact Numbers */}
      <ImpactNumbers />

      {/* Section 5 — Actor Cards */}
      <ActorCards />

      {/* Section 6 — Voucher Explainer */}
      <VoucherExplainer />

      {/* Section 7 — Testimonials */}
      <TestimonialsSection />

      {/* Section 8 — Download CTA */}
      <DownloadCTA />
    </>
  );
}
