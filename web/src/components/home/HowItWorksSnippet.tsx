import Link from 'next/link';
import { Home, Truck, Wheat, ArrowRight, type LucideIcon } from 'lucide-react';
import { ChevronRight } from 'lucide-react';

interface Step {
  number: string;
  icon: LucideIcon;
  title: string;
  description: string;
}

const steps: Step[] = [
  {
    number: '1',
    icon: Home,
    title: 'Households sort & schedule',
    description:
      'Register on the app, separate plastic and organic waste, and request a free pickup. Earn CRF Credits for every kilogram confirmed.',
  },
  {
    number: '2',
    icon: Truck,
    title: 'Drivers collect & confirm',
    description:
      'CRRF drivers pick up your waste, weigh it on-site, and confirm the pickup. Credits are issued automatically — no manual process.',
  },
  {
    number: '3',
    icon: Wheat,
    title: 'Farmers buy & grow',
    description:
      "Farmers browse the CRRF marketplace and purchase processed organic manure using their credits or cash on delivery. Better crops. Lower costs.",
  },
];

export default function HowItWorksSnippet() {
  return (
    <section className="py-16 bg-crrf-green-faint">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
            The Process
          </span>
          <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
            Three actors. One loop. Infinite value.
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {steps.map((step) => {
            const Icon = step.icon;
            return (
              <div key={step.number} className="relative">
                <div className="bg-crrf-white rounded-[12px] p-8 shadow-sm border border-crrf-border">
                  <div className="flex items-center justify-center w-10 h-10 rounded-full bg-crrf-forest text-white mb-4 mx-auto">
                    <span className="font-mono font-bold">{step.number}</span>
                  </div>
                  <div className="flex justify-center mb-3">
                    <Icon className="h-8 w-8 text-crrf-forest" />
                  </div>
                  <h3 className="font-semibold text-crrf-ink text-center mb-3">{step.title}</h3>
                  <p className="text-sm text-crrf-muted text-center leading-relaxed">
                    {step.description}
                  </p>
                </div>
              </div>
            );
          })}
        </div>

        <div className="text-center mt-10">
          <Link
            href="/how-it-works"
            className="inline-flex items-center text-crrf-forest font-medium hover:text-crrf-green-mid transition-colors group"
          >
            See the full process
            <ChevronRight className="ml-1 h-4 w-4 transition-transform group-hover:translate-x-1" />
          </Link>
        </div>
      </div>
    </section>
  );
}
