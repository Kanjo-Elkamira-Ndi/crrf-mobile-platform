import type { Metadata } from 'next';
import { ShoppingBag, Truck, Coins, FileText } from 'lucide-react';

export const metadata: Metadata = {
  title: 'For Farmers — CRRF',
  description: 'Buy quality organic manure with CRF Credits or cash on delivery.',
};

const features = [
  {
    icon: ShoppingBag,
    title: 'Marketplace Catalog',
    description: 'Browse organic manure products with NPK profiles and clear pricing.',
  },
  {
    icon: Coins,
    title: 'Voucher Checkout',
    description: 'Pay with CRF Credits from your household or cash on delivery.',
  },
  {
    icon: Truck,
    title: 'Delivery Scheduling',
    description: 'Select your district, address, and preferred delivery time window.',
  },
  {
    icon: FileText,
    title: 'Offtake Agreements',
    description: 'Access micro-loans backed by guaranteed offtake from CRRF.',
  },
];

const products = [
  {
    img: '/organic manure.jpg',
    name: 'Premium Organic Manure',
    description: 'High-grade composted organic waste',
    creditPrice: 80,
    cashPrice: '4,000 XAF',
  },
  {
    img: '/compost_blend.jpeg',
    name: 'Compost Blend',
    description: 'Balanced mix for general crop use',
    creditPrice: 60,
    cashPrice: '3,000 XAF',
  },
  {
    img: '/bio-fertilizer-pellets.jpeg',
    name: 'Bio-Fertiliser Pellets',
    description: 'Slow-release pellets for sustained growth',
    creditPrice: 120,
    cashPrice: '6,000 XAF',
  },
];

const faqs = [
  {
    q: 'Can I pay with credits if I am not a household?',
    a: 'CRF Credits are currently earned by households for their waste. Farmers can pay cash on delivery or use credits transferred from a household account.',
  },
  {
    q: 'How is the manure delivered?',
    a: 'CRRF drivers deliver directly to your farm address. You select your district, address, and a delivery time window during checkout.',
  },
  {
    q: 'What is an offtake agreement?',
    a: 'CRRF offers micro-loans backed by guaranteed offtake — we agree to purchase your future harvest at a fair price, which serves as collateral for the loan.',
  },
  {
    q: 'Is the manure certified?',
    a: 'Yes. All CRRF manure is processed, tested, and quality-graded before being listed on the marketplace.',
  },
  {
    q: 'What areas do you deliver to?',
    a: 'We currently deliver within Yaounde and the surrounding Centre Region. Expansion to other regions is planned for 2027.',
  },
];

export default function ForFarmersPage() {
  return (
    <>
      {/* Hero */}
      <section className="relative min-h-[50vh] bg-cover bg-center text-white py-20" style={{ backgroundImage: 'url(/hero_2.png)' }}>
        <div className="absolute inset-0 bg-crrf-brown/60" />
        <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="font-display text-4xl sm:text-5xl font-bold mb-4">
            Better manure. Lower cost. Delivered to your farm.
          </h1>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            Access affordable, high-quality organic fertiliser through the CRRF marketplace.
            Pay with credits, cash on delivery, or explore our micro-loan programmes.
          </p>
        </div>
      </section>

      {/* Features */}
      <section className="bg-crrf-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Farmer Features
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              A marketplace built for African agriculture
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {features.map((feature) => {
              const Icon = feature.icon;
              return (
                <div
                  key={feature.title}
                  className="bg-crrf-brown-light rounded-[12px] p-6 border border-crrf-border"
                >
                  <div className="w-12 h-12 rounded-full bg-crrf-brown/10 flex items-center justify-center mb-4">
                    <Icon className="h-6 w-6 text-crrf-brown" />
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
               { src: '/img_3.jpg', label: 'Farmer Dashboard' },
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

       {/* Product preview grid */}
      <section className="bg-crrf-green-faint py-16">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <span className="text-crrf-gold font-semibold text-sm uppercase tracking-wider">
              Available Now
            </span>
            <h2 className="font-display text-3xl sm:text-4xl font-bold text-crrf-forest mt-2">
              Manure products
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {products.map((product) => (
              <div
                key={product.name}
                className="bg-crrf-white rounded-[12px] p-6 border border-crrf-border shadow-sm hover:shadow-md transition-shadow"
              >
                <div className="h-48 rounded-[8px] overflow-hidden mb-4 border border-crrf-border">
                  <img
                    src={product.img}
                    alt={product.name}
                    className="w-full h-full object-cover object-center"
                  />
                </div>
                <h3 className="font-semibold text-crrf-ink text-center mb-1">{product.name}</h3>
                <p className="text-xs text-crrf-muted text-center mb-4">{product.description}</p>
                <div className="flex justify-between items-center pt-4 border-t border-crrf-border">
                  <div>
                    <p className="text-xs text-crrf-subtle">Credits</p>
                    <p className="font-mono font-bold text-crrf-forest">{product.creditPrice} pts</p>
                  </div>
                  <div className="text-right">
                    <p className="text-xs text-crrf-subtle">Cash</p>
                    <p className="font-semibold text-crrf-ink">{product.cashPrice}</p>
                  </div>
                </div>
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
