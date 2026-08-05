import type { Metadata } from 'next';
import { Phone, Calendar, Wallet, Recycle, MapPin, Bell } from 'lucide-react';

export const metadata: Metadata = {
  title: 'For Households — CRRF',
  description: 'Sort waste, earn CRF Credits, and track your environmental impact.',
};

const features = [
  {
    icon: Phone,
    title: 'Phone Registration',
    description: 'Sign up in seconds with your phone number and OTP verification.',
  },
  {
    icon: Calendar,
    title: 'Easy Scheduling',
    description: 'Pick a date, time window, and waste type. We handle the rest.',
  },
  {
    icon: Wallet,
    title: 'Credit Wallet',
    description: 'Watch your CRF Credits grow with every confirmed pickup.',
  },
  {
    icon: Recycle,
    title: 'Waste Guide',
    description: 'Illustrated guide showing exactly what to sort and how.',
  },
  {
    icon: MapPin,
    title: 'Pickup Tracking',
    description: 'Real-time status from pending to completed with driver details.',
  },
  {
    icon: Bell,
    title: 'Impact Dashboard',
    description: 'See kg recycled, CO₂ avoided, and your neighbourhood ranking.',
  },
];

const faqs = [
  {
    q: 'How much does collection cost?',
    a: 'Nothing. CRRF collection is completely free for households. You earn CRF Credits for every kilogram confirmed — you never pay us.',
  },
  {
    q: 'How are credits calculated?',
    a: 'Plastic earns 10 CRF Credits per kg, organic earns 5 CRF Credits per kg. Weights are rounded down to the nearest 0.5 kg before calculation.',
  },
  {
    q: 'How long do credits last?',
    a: 'CRF Credits expire 12 months after issuance. You can spend them in the CRRF marketplace on organic manure for your own garden.',
  },
  {
    q: 'What if I miss a scheduled pickup?',
    a: 'No problem. You can reschedule or cancel anytime before the driver arrives. Use the in-app support to report any issues.',
  },
  {
    q: 'What areas does CRRF cover?',
    a: 'We are launching in Yaounde and the surrounding Centre Region in 2026, with plans to expand across Cameroon.',
  },
  {
    q: 'What types of waste can I sort?',
    a: 'Currently, CRRF accepts plastic and organic waste. Use the in-app waste guide for specific categories and examples.',
  },
];

export default function ForHouseholdsPage() {
  return (
    <>
      {/* Hero */}
      <section className="bg-gradient-to-br from-crrf-forest to-crrf-green-mid text-white py-20">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="font-display text-4xl sm:text-5xl font-bold mb-4">
            Sort waste. Earn rewards. Clean your city.
          </h1>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            Join thousands of Cameroonian households turning their waste into value. Free
            collection, real rewards, real impact.
          </p>
        </div>
      </section>

      {/* Features grid */}
      <section className="bg-crrf-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Household Features
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Everything you need to recycle smarter
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {features.map((feature) => {
              const Icon = feature.icon;
              return (
                <div
                  key={feature.title}
                  className="bg-crrf-bg rounded-[12px] p-6 border border-crrf-border"
                >
                  <div className="w-12 h-12 rounded-full bg-crrf-green-light flex items-center justify-center mb-4">
                    <Icon className="h-6 w-6 text-crrf-forest" />
                  </div>
                  <h3 className="font-semibold text-crrf-ink mb-2">{feature.title}</h3>
                  <p className="text-sm text-crrf-muted leading-relaxed">
                    {feature.description}
                  </p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* Screenshots section with phone mockups */}
      <section className="bg-crrf-green-faint py-16">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              The App
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Designed for everyday use
            </h2>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 max-w-3xl mx-auto">
            {[
              { src: '/img_1.jpg', label: 'Category Selection' },
              { src: '/img_2.jpg', label: 'Household Dashboard' },
            ].map((screen) => (
              <div key={screen.label} className="text-center">
                <div className="bg-crrf-white rounded-[24px] border-4 border-crrf-forest overflow-hidden aspect-[9/19] mx-auto max-w-[200px]">
                  <img
                    src={screen.src}
                    alt={screen.label}
                    className="w-full h-full object-cover"
                  />
                </div>
                <span className="text-xs font-medium text-crrf-muted mt-2 block">
                  {screen.label}
                </span>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* FAQ */}
      <section className="bg-crrf-white py-16">
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              FAQ
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Questions, answered
            </h2>
          </div>

          <div className="space-y-4">
            {faqs.map((faq, i) => (
              <details
                key={i}
                className="group bg-crrf-bg rounded-[12px] p-5 border border-crrf-border"
              >
                <summary className="font-semibold text-crrf-ink cursor-pointer list-none flex justify-between items-center">
                  {faq.q}
                  <span className="text-crrf-forest group-open:rotate-180 transition-transform">⌄</span>
                </summary>
                <p className="text-sm text-crrf-muted mt-4 leading-relaxed">{faq.a}</p>
              </details>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}
