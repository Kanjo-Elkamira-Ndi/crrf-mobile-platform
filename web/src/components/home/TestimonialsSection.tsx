const testimonials = [
  {
    quote:
      "I can't wait for the app — soon I'll be able to sort my waste, schedule pickups easily, and watch my credits grow. Our neighbourhood will be cleaner and we'll all benefit.",
    name: 'Ama Mbarga',
    meta: '34, Yaounde',
    role: 'Household',
    roleColor: 'bg-crrf-forest',
  },
  {
    quote:
      'I am excited for the app — CRRF manure will be easy to order, affordable and delivered, and I expect my maize yields to improve once I start using it regularly.',
    name: 'Emmanuel Nkodo',
    meta: '52, Obala',
    role: 'Farmer',
    roleColor: 'bg-crrf-brown',
  },
  {
    quote:
      'With the app coming, my route will be on my phone — I will confirm pickups, enter weights quickly, and credits will go to households automatically. No paperwork and much less hassle.',
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
