const testimonials = [
  {
    quote:
      "Before CRRF, I burned my waste behind the house. Now I sort it, schedule a pickup, and watch my credits grow. My neighbourhood is cleaner and I'm getting something back.",
    name: 'Ama Mbarga',
    meta: '34, Yaounde',
    role: 'Household',
    roleColor: 'bg-crrf-forest',
  },
  {
    quote:
      'Chemical fertiliser is too expensive and not always available. CRRF manure is affordable, delivered, and my maize yield improved this season.',
    name: 'Emmanuel Nkodo',
    meta: '52, Obala',
    role: 'Farmer',
    roleColor: 'bg-crrf-brown',
  },
  {
    quote:
      'My route is on the app. I confirm pickups, enter the weights, and the credits go to the household automatically. No paperwork.',
    name: 'Didier Tchoumba',
    meta: '28, CRRF Driver',
    role: 'Driver',
    roleColor: 'bg-gray-700',
  },
];

export default function TestimonialsSection() {
  return (
    <section className="py-16 bg-crrf-green-faint">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
            Voices from the Loop
          </span>
          <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
            Real people. Real impact.
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {testimonials.map((t) => (
            <div
              key={t.name}
              className="bg-crrf-white rounded-[12px] p-8 shadow-sm border border-crrf-border flex flex-col"
            >
              <div className="flex items-center mb-4">
                <span
                  className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium text-white ${t.roleColor}`}
                >
                  {t.role}
                </span>
              </div>
              <blockquote className="text-crrf-ink text-sm italic leading-relaxed flex-1">
                &ldquo;{t.quote}&rdquo;
              </blockquote>
              <div className="mt-6 pt-4 border-t border-crrf-border">
                <p className="font-semibold text-crrf-forest">{t.name}</p>
                <p className="text-sm text-crrf-muted">{t.meta}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
