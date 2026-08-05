'use client';

import { useState } from 'react';
import Link from 'next/link';
import { MessageCircle, MapPin, Mail, Phone } from 'lucide-react';

const roles = [
  'Household',
  'Farmer',
  'Driver',
  'Investor',
  'Press',
  'Other',
];

export default function ContactPage() {
  const [form, setForm] = useState({
    name: '',
    email: '',
    phone: '',
    role: '',
    message: '',
  });
  const [submitted, setSubmitted] = useState(false);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>,
  ) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Contact form submission:', form);
    setSubmitted(true);
  };

  return (
    <>
      {/* Hero */}
      <section className="relative min-h-[50vh] bg-cover bg-center text-white py-20" style={{ backgroundImage: 'url(/hero_3.avif)' }}>
        <div className="absolute inset-0 bg-crrf-forest/60" />
        <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="font-display text-4xl sm:text-5xl font-bold mb-4">
            Let&apos;s talk
          </h1>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            Questions, partnerships, or feedback — we&apos;d love to hear from you.
          </p>
        </div>
      </section>

      {/* Contact section */}
      <section className="bg-crrf-white py-16">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
            {/* Form */}
            <div>
              <h2 className="font-display text-2xl font-bold text-crrf-forest mb-6">
                Send us a message
              </h2>

              {submitted ? (
                <div className="bg-crrf-green-faint border border-crrf-green-mid rounded-[12px] p-8 text-center">
                  <div className="w-16 h-16 rounded-full bg-crrf-forest flex items-center justify-center mx-auto mb-4">
                    <span className="text-white text-3xl">✓</span>
                  </div>
                  <h3 className="font-semibold text-crrf-ink text-lg mb-2">Message sent!</h3>
                  <p className="text-sm text-crrf-muted">
                    Thank you for reaching out. Our team will respond within 24–48 hours.
                  </p>
                  <button
                    onClick={() => {
                      setSubmitted(false);
                      setForm({ name: '', email: '', phone: '', role: '', message: '' });
                    }}
                    className="mt-6 text-crrf-forest font-medium text-sm hover:text-crrf-green-mid"
                  >
                    Send another message
                  </button>
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div>
                    <label htmlFor="name" className="block text-sm font-medium text-crrf-ink mb-1">
                      Name *
                    </label>
                    <input
                      id="name"
                      name="name"
                      type="text"
                      required
                      value={form.name}
                      onChange={handleChange}
                      className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
                    />
                  </div>

                  <div>
                    <label htmlFor="email" className="block text-sm font-medium text-crrf-ink mb-1">
                      Email *
                    </label>
                    <input
                      id="email"
                      name="email"
                      type="email"
                      required
                      value={form.email}
                      onChange={handleChange}
                      className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
                    />
                  </div>

                  <div>
                    <label htmlFor="phone" className="block text-sm font-medium text-crrf-ink mb-1">
                      Phone
                    </label>
                    <input
                      id="phone"
                      name="phone"
                      type="tel"
                      value={form.phone}
                      onChange={handleChange}
                      className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
                    />
                  </div>

                  <div>
                    <label htmlFor="role" className="block text-sm font-medium text-crrf-ink mb-1">
                      I am a...
                    </label>
                    <select
                      id="role"
                      name="role"
                      value={form.role}
                      onChange={handleChange}
                      className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
                    >
                      <option value="">Select a role</option>
                      {roles.map((r) => (
                        <option key={r} value={r}>
                          {r}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label htmlFor="message" className="block text-sm font-medium text-crrf-ink mb-1">
                      Message *
                    </label>
                    <textarea
                      id="message"
                      name="message"
                      required
                      rows={5}
                      value={form.message}
                      onChange={handleChange}
                      className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent resize-none"
                    />
                  </div>

                  <button
                    type="submit"
                    className="w-full py-3 rounded-full bg-crrf-forest text-white font-medium hover:bg-crrf-green-mid transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-crrf-forest"
                  >
                    Send Message
                  </button>
                </form>
              )}
            </div>

            {/* Contact info */}
            <div className="space-y-8">
              <div>
                <h2 className="font-display text-2xl font-bold text-crrf-forest mb-6">
                  Other ways to reach us
                </h2>

                {/* WhatsApp CTA */}
                <a
                  href="https://wa.me/237651816622"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-4 bg-[#25D366] text-white rounded-[12px] p-5 hover:scale-[1.02] transition-transform"
                >
                  <div className="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center">
                    <MessageCircle className="h-6 w-6" />
                  </div>
                  <div>
                    <p className="font-semibold">Chat with us on WhatsApp</p>
                    <p className="text-sm text-white/80">Fastest response · Mon–Fri 9AM–6PM WAT</p>
                  </div>
                </a>
              </div>

              {/* Office */}
              <div className="bg-crrf-bg rounded-[12px] p-6 border border-crrf-border">
                <h3 className="font-semibold text-crrf-ink mb-4">Office</h3>
                <div className="flex items-start gap-3 mb-3">
                  <MapPin className="h-5 w-5 text-crrf-forest mt-0.5 flex-shrink-0" />
                  <div>
                    <p className="text-sm text-crrf-ink">Yaounde, Centre Region</p>
                    <p className="text-sm text-crrf-muted">Cameroon</p>
                  </div>
                </div>
                <div className="flex items-start gap-3 mb-3">
                  <Mail className="h-5 w-5 text-crrf-forest mt-0.5 flex-shrink-0" />
                  <p className="text-sm text-crrf-ink">hello@crrf.cm</p>
                </div>
                <div className="flex items-start gap-3">
                  <Phone className="h-5 w-5 text-crrf-forest mt-0.5 flex-shrink-0" />
                  <p className="text-sm text-crrf-ink">+237 651 816 622</p>
                </div>
              </div>

              {/* Beta signup CTA */}
              <div className="bg-crrf-forest text-white rounded-[12px] p-6">
                <h3 className="font-semibold mb-2">Want to try the app?</h3>
                <p className="text-sm text-white/80 mb-4">
                  Join our beta programme and be among the first households in Yaounde to
                  recycle for rewards.
                </p>
                <Link
                  href="/#download"
                  className="inline-flex items-center justify-center px-6 py-2 rounded-full bg-crrf-gold text-crrf-forest font-medium text-sm"
                >
                  Join the Beta
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
