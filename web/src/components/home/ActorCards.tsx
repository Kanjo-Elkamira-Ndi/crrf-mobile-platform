import Link from 'next/link';
import { cn } from '@/lib/utils';

const actors = [
  {
    id: 'household',
    emoji: '🏠',
    title: 'Households',
    subtitle: 'Forest Green',
    description: 'Sort waste at home. Earn CRF Credits. Track your environmental impact.',
    cta: 'For Households',
    href: '/for-households',
    color: 'crrf-forest',
    bgClass: 'bg-crrf-forest',
  },
  {
    id: 'farmer',
    emoji: '🌾',
    title: 'Farmers',
    subtitle: 'Earth Brown',
    description: 'Buy quality organic manure with vouchers. Request delivery to your farm.',
    cta: 'For Farmers',
    href: '/for-farmers',
    color: 'crrf-brown',
    bgClass: 'bg-crrf-brown',
  },
  {
    id: 'driver',
    emoji: '🚛',
    title: 'Drivers',
    subtitle: 'Blue Grey',
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
          {actors.map((actor) => (
            <div
              key={actor.id}
              className={cn(
                'rounded-[12px] p-[1px] overflow-hidden transition-transform hover:scale-[1.02]',
              )}
            >
              <div className="h-full flex flex-col">
                <div className={cn('p-8 text-center', actor.bgClass + ' text-white')}>
                  <div className="text-4xl mb-4">{actor.emoji}</div>
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
                      'w-full py-3 px-6 rounded-full font-medium text-center transition-colors',
                      actor.id === 'household' && 'bg-crrf-forest text-white hover:bg-crrf-green-mid',
                      actor.id === 'farmer' && 'bg-crrf-brown text-white hover:bg-crrf-brown/80',
                      actor.id === 'driver' && 'bg-gray-700 text-white hover:bg-gray-700/80',
                    )}
                  >
                    {actor.cta} →
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
