import type { Metadata } from 'next';
import { Recycle, Users, Lightbulb, Heart } from 'lucide-react';

export const metadata: Metadata = {
  title: 'About — CRRF',
  description: 'Our mission, our team, and why we believe in Cameroon’s circular economy.',
};

const values = [
  {
    icon: Recycle,
    title: 'Environmental Impact',
    description: 'Every pickup diverts waste from landfills and converts it into agricultural value.',
  },
  {
    icon: Users,
    title: 'Economic Inclusion',
    description: 'We create income opportunities for households, drivers, and smallholder farmers.',
  },
  {
    icon: Lightbulb,
    title: 'Digital Innovation',
    description: 'A voucher economy built on accessible mobile technology — no smartphone required for basic use.',
  },
  {
    icon: Heart,
    title: 'Community First',
    description: 'CRRF is rooted in Yaounde, built with local communities, and committed to local growth.',
  },
];

const stats = [
  { value: '6M', label: 'Tonnes of waste generated annually in Cameroon' },
  { value: '<15%', label: 'Of that waste is properly managed' },
  { value: '70%', label: 'Of Cameroonians rely on agriculture for income' },
  { value: '1', label: 'Platform connecting them all' },
];

export default function AboutPage() {
  return (
    <>
      {/* Hero */}
      <section className="text-white py-20" style={{ background: '#1B6B3A' }}>
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="font-display text-4xl sm:text-5xl font-bold mb-4">
            We are turning Cameroon&apos;s waste into wealth.
          </h1>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            CRRF was founded on a simple belief: the waste piling up in our streets has
            value — for our farms, for our roads, and for our people.
          </p>
        </div>
      </section>

      {/* Mission */}
      <section className="bg-white py-16">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Our Mission
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Build the circular economy Cameroon deserves
            </h2>
          </div>
          <div className="prose prose-lg max-w-none text-crrf-muted">
            <p className="text-lg leading-relaxed">
              Cameroon generates over 6 million tonnes of waste each year, and less than 15%
              is managed properly. At the same time, our smallholder farmers — the backbone of
              the economy — struggle to access affordable organic fertiliser.
            </p>
            <p className="text-lg leading-relaxed mt-4">
              CRRF was founded to solve both problems at once. By connecting households who
              sort waste, drivers who collect it, and farmers who grow with it, we created a
              closed-loop system where everyone benefits. Households earn digital vouchers for
              every kilogram confirmed. Farmers get affordable, delivered manure. And our
              communities get cleaner, healthier environments.
            </p>
            <p className="text-lg leading-relaxed mt-4">
              We call this <span className="font-semibold text-crrf-forest">Waste to Value. Crops to Markets.</span>
            </p>
          </div>
        </div>
      </section>

      {/* Value chain visual */}
      <section className="py-16" style={{ background: '#EEF8F2' }}>
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest">
              The Circular Economy Value Chain
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 relative">
            {[
              { emoji: '🏠', label: 'Household', desc: 'Sorts waste' },
              { emoji: '🚛', label: 'Driver', desc: 'Collects & weighs' },
              { emoji: '⚙', label: 'Processing', desc: 'Converts to manure' },
              { emoji: '🌾', label: 'Farmer', desc: 'Buys & grows' },
            ].map((step, i) => (
              <div key={step.label} className="text-center">
                <div className="bg-white rounded-[12px] p-6 shadow-sm border border-crrf-border">
                  <div className="text-4xl mb-3">{step.emoji}</div>
                  <h3 className="font-semibold text-crrf-ink">{step.label}</h3>
                  <p className="text-xs text-crrf-muted mt-1">{step.desc}</p>
                </div>
                {i < 3 && (
                  <div className="hidden md:block text-crrf-forest text-2xl my-2">→</div>
                )}
              </div>
            ))}
          </div>
          <p className="text-center text-crrf-forest italic mt-8 text-sm">
            ...and the loop repeats, infinitely.
          </p>
        </div>
      </section>

      {/* Why Cameroon */}
      <section className="bg-white py-16">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              The Context
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Why Cameroon?
            </h2>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {stats.map((stat) => (
              <div key={stat.label} className="text-center">
                <p className="text-4xl font-bold font-mono text-crrf-forest">{stat.value}</p>
                <p className="text-xs text-crrf-muted mt-2 leading-snug">{stat.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Team */}
      <section className="py-16" style={{ background: '#F5EDE9' }}>
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              The Team
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Built by DigiMark Consulting
            </h2>
          </div>

          <div className="bg-white rounded-[12px] p-8 border border-crrf-border text-center max-w-md mx-auto">
            <div className="w-20 h-20 rounded-full bg-crrf-green-light flex items-center justify-center mx-auto mb-4">
              <span className="text-3xl">🏢</span>
            </div>
            <h3 className="font-semibold text-crrf-ink text-lg">DigiMark Consulting</h3>
            <p className="text-sm text-crrf-muted mt-3 leading-relaxed">
              A digital product and consulting firm based in Yaounde, Cameroon, building
              technology solutions for the African circular economy. CRRF is our flagship
              platform — designed, engineered, and operated from within the communities we
              serve.
            </p>
          </div>
        </div>
      </section>

      {/* Values */}
      <section className="bg-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Our Values
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              What we stand for
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {values.map((value) => {
              const Icon = value.icon;
              return (
                <div key={value.title} className="text-center">
                  <div className="w-14 h-14 rounded-full bg-crrf-green-light flex items-center justify-center mx-auto mb-4">
                    <Icon className="h-7 w-7 text-crrf-forest" />
                  </div>
                  <h3 className="font-semibold text-crrf-ink mb-2">{value.title}</h3>
                  <p className="text-sm text-crrf-muted leading-relaxed">{value.description}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>
    </>
  );
}
