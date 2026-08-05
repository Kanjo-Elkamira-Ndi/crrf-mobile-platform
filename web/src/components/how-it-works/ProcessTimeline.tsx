import { Smartphone, Recycle, Calendar, Truck, Scale, Sparkles, ShoppingCart, Wheat } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import SectionLabel from '@/components/shared/SectionLabel';

interface Step {
  number: string;
  icon: LucideIcon;
  title: string;
  description: string;
  actor: string;
}

const steps: Step[] = [
  {
    number: '01',
    icon: Smartphone,
    title: 'Household Registration',
    description: 'Download the app, create an account with your phone number, verify via OTP, and join the CRRF network.',
    actor: 'Household',
  },
  {
    number: '02',
    icon: Recycle,
    title: 'Waste Sorting',
    description: 'Separate your household waste into plastic and organic categories using the in-app guide.',
    actor: 'Household',
  },
  {
    number: '03',
    icon: Calendar,
    title: 'Pickup Request',
    description: 'Schedule a free pickup by selecting a date, time window, and waste type through the app.',
    actor: 'Household',
  },
  {
    number: '04',
    icon: Truck,
    title: 'Driver Collection',
    description: 'A CRRF driver is assigned and arrives at your location during the scheduled window.',
    actor: 'Driver',
  },
  {
    number: '05',
    icon: Scale,
    title: 'Weight Confirmation',
    description: "The driver weighs your waste on-site and confirms the pickup in the app with actual weights.",
    actor: 'Driver',
  },
  {
    number: '06',
    icon: Sparkles,
    title: 'Credit Issuance',
    description: 'CRF Credits are automatically issued to your wallet based on confirmed weights. No paperwork.',
    actor: 'System',
  },
  {
    number: '07',
    icon: ShoppingCart,
    title: 'Marketplace Purchase',
    description: 'Farmers browse the CRRF marketplace and buy organic manure using credits or cash on delivery.',
    actor: 'Farmer',
  },
  {
    number: '08',
    icon: Wheat,
    title: 'Farm Delivery',
    description: 'Manure is delivered to the farmer\'s address. Better crops. Lower costs. Full circle.',
    actor: 'Farmer',
  },
];

export default function ProcessTimeline() {
  return (
    <div className="py-12">
      <div className="text-center mb-16">
        <SectionLabel text="The Full Process" />
        <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest">
          From waste to harvest — step by step
        </h2>
      </div>

      <div className="relative">
        {/* Vertical line - hidden on mobile */}
        <div className="absolute left-[31px] md:left-1/2 top-0 bottom-0 w-px bg-crrf-border md:-translate-x-px" />

        <div className="space-y-8">
          {steps.map((step, i) => {
            const Icon = step.icon;
            return (
              <div
                key={step.number}
                className={
                  `relative flex items-start gap-8 ` +
                  (i % 2 === 0 ? 'md:flex-row' : 'md:flex-row-reverse')
                }
              >
                {/* Number circle */}
                <div className="relative z-10 flex-shrink-0 w-16 h-16 rounded-full bg-crrf-forest text-white flex items-center justify-center font-bold font-mono text-lg shadow-md md:absolute md:left-1/2 md:-translate-x-1/2">
                  {step.number}
                </div>

                {/* Content card */}
                <div className={`flex-1 md:w-1/2 ${i % 2 === 0 ? 'md:pr-16' : 'md:pl-16'}`}>
                  <div className="bg-crrf-white rounded-[12px] p-6 shadow-sm border border-crrf-border">
                    <div className="flex items-center mb-3">
                      <Icon className="h-6 w-6 text-crrf-forest mr-3" />
                      <h3 className="font-semibold text-crrf-ink">{step.title}</h3>
                    </div>
                    <p className="text-sm text-crrf-muted leading-relaxed mb-3">
                      {step.description}
                    </p>
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-crrf-green-light text-crrf-forest">
                      {step.actor}
                    </span>
                  </div>
                </div>

                {/* Spacer for the other half on desktop */}
                <div className="hidden md:block md:w-1/2" />
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
