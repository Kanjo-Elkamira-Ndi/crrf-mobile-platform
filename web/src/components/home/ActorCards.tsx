import Link from 'next/link';
import { Home, Wheat, Truck, ArrowRight } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import { cn } from '@/lib/utils';

interface Actor {
  id: string;
  icon: LucideIcon;
  title: string;
  subtitle: string;
  description: string;
  cta: string;
  href: string;
  color: string;
  bgClass: string;
}

const actors: Actor[] = [
  {
    id: 'household',
    icon: Home,
    title: 'Households',
    subtitle: 'For Households',
    description: 'Sort waste at home. Earn CRF Credits. Track your environmental impact.',
    cta: 'For Households',
    href: '/for-households',
    color: 'crrf-forest',
    bgClass: 'bg-crrf-forest',
  },
  {
    id: 'farmer',
    icon: Wheat,
    title: 'Farmers',
    subtitle: 'For Farmers',
    description: 'Buy quality organic manure with vouchers. Request delivery to your farm.',
    cta: 'For Farmers',
    href: '/for-farmers',
    color: 'crrf-brown',
    bgClass: 'bg-crrf-brown',
  },
  {
    id: 'driver',
    icon: Truck,
    title: 'Drivers',
    subtitle: 'For Drivers',
    description: 'Manage your daily route. Confirm pickups. Trigger credit issuance — all in-app.',
    cta: 'Join the Team',
    href: '/contact',
    color: 'gray-700',
    bgClass: 'bg-gray-700',
  },
];

export default function ActorCards() {
  return (
    <section className="py-16 bg-crrf-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
            Built for Everyone in the Loop
          </span>
          <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
            Who CRRF is for
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {actors.map((actor) => {
            const Icon = actor.icon;
            return (
              <div
                key={actor.id}
                className={cn(
                  'rounded-[12px] p-[1px] overflow-hidden transition-transform hover:scale-[1.02]',
                )}
              >
                <div className="h-full flex flex-col">
                  <div className={cn('p-8 text-center', actor.bgClass + ' text-white')}>
                    <div className="flex justify-center mb-4">
                      <Icon className="h-10 w-10" />
                    </div>
                    <h3 className="font-display text-2xl font-bold mb-1">{actor.title}</h3>
                    <p className="text-sm opacity-75">{actor.subtitle}</p>
                  </div>
                  <div className="p-8 bg-crrf-white flex-1 flex flex-col">
                    <p className="text-crrf-muted text-sm leading-relaxed mb-6 flex-1">
                      {actor.description}
                    </p>
                    <Link
                      href={actor.href}
                      className={cn(
                        'w-full py-3 px-6 rounded-full font-medium text-center flex items-center justify-center gap-2 transition-colors',
                        actor.id === 'household' && 'bg-crrf-forest text-white hover:bg-crrf-green-mid',
                        actor.id === 'farmer' && 'bg-crrf-brown text-white hover:bg-crrf-brown/80',
                        actor.id === 'driver' && 'bg-gray-700 text-white hover:bg-gray-700/80',
                      )}
                    >
                      {actor.cta}
                      <ArrowRight className="h-4 w-4" />
                    </Link>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
