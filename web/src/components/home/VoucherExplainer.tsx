import { CheckCircle2 } from 'lucide-react';

const keyPoints = [
  'Credits earned per confirmed kg, not per request',
  'Credits redeemable in the CRRF marketplace',
  'Credits expire in 12 months — spend them on your farm',
  'Credits are non-transferable in MVP — tied to your household',
];

export default function VoucherExplainer() {
  return (
    <section className="py-16 bg-crrf-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
            The Voucher Economy
          </span>
          <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
            Your waste has value. We prove it.
          </h2>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* Left: explanation */}
          <div className="space-y-6">
            <p className="text-lg text-crrf-muted leading-relaxed">
              Every kilogram of waste you sort is converted into CRF Credits — a digital
              voucher currency that flows from households to farmers, funding both the
              collection operation and sustainable agriculture.
            </p>
            <div className="space-y-3">
              {keyPoints.map((point) => (
                <div key={point} className="flex items-start">
                  <CheckCircle2 className="h-5 w-5 text-crrf-forest mt-0.5 mr-3 flex-shrink-0" />
                  <span className="text-crrf-ink text-sm">{point}</span>
                </div>
              ))}
            </div>
          </div>

          {/* Right: wallet card mockup */}
          <div className="relative">
            <div className="bg-gradient-to-br from-crrf-forest to-crrf-green-mid rounded-[24px] p-8 text-white shadow-xl max-w-sm mx-auto">
              <div className="flex justify-between items-start mb-8">
                <div>
                  <p className="text-xs opacity-70 uppercase tracking-wider">CRF Wallet</p>
                  <p className="text-sm opacity-90 mt-1">Ama Mbarga</p>
                </div>
                <div className="text-2xl">♻</div>
              </div>

              <div className="mb-6">
                <p className="text-xs opacity-70 uppercase tracking-wider mb-1">Balance</p>
                <p className="text-4xl font-bold font-mono">
                  340 <span className="text-lg font-normal opacity-80">pts</span>
                </p>
              </div>

              <div className="space-y-2 border-t border-white/20 pt-4">
                <p className="text-xs opacity-70 uppercase tracking-wider mb-2">Recent</p>
                {[
                  { label: 'Plastic pickup · 3.0 kg', amount: '+30', date: 'Today' },
                  { label: 'Organic pickup · 1.5 kg', amount: '+8', date: 'Yesterday' },
                  { label: 'Manure purchase', amount: '-120', date: '3 days ago' },
                ].map((tx) => (
                  <div key={tx.label} className="flex justify-between items-center text-sm">
                    <div>
                      <p className="opacity-90">{tx.label}</p>
                      <p className="text-xs opacity-60">{tx.date}</p>
                    </div>
                    <span
                      className={
                        tx.amount.startsWith('+')
                          ? 'text-crrf-gold-light font-mono'
                          : 'text-white/70 font-mono'
                      }
                    >
                      {tx.amount}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
