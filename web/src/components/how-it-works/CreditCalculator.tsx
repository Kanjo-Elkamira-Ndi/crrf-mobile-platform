'use client';

import { useState, useMemo } from 'react';

const products = [
  { name: 'Premium Organic Manure', emoji: '🌱', creditPrice: 80, cashPrice: 4000 },
  { name: 'Compost Blend', emoji: '🍂', creditPrice: 60, cashPrice: 3000 },
  { name: 'Bio-Fertiliser Pellets', emoji: '⚪', creditPrice: 120, cashPrice: 6000 },
];

export default function CreditCalculator() {
  const [plasticKg, setPlasticKg] = useState('');
  const [organicKg, setOrganicKg] = useState('');

  const { plasticPoints, organicPoints, totalPoints, roundedPlastic, roundedOrganic } = useMemo(() => {
    const pInput = parseFloat(plasticKg) || 0;
    const oInput = parseFloat(organicKg) || 0;

    // Round down to nearest 0.5 kg
    const roundDown = (n: number) => Math.floor(n * 2) / 2;
    const rp = roundDown(pInput);
    const ro = roundDown(oInput);

    const pp = rp * 10;
    const op = ro * 5;

    return {
      plasticPoints: pp,
      organicPoints: op,
      totalPoints: pp + op,
      roundedPlastic: rp,
      roundedOrganic: ro,
    };
  }, [plasticKg, organicKg]);

  const affordableProducts = products.filter((p) => p.creditPrice <= totalPoints);

  return (
    <div className="bg-crrf-white rounded-[24px] p-8 shadow-sm border border-crrf-border max-w-2xl mx-auto">
      <div className="text-center mb-8">
        <h3 className="font-display text-2xl font-bold text-crrf-forest mb-2">
          Credit Calculator
        </h3>
        <p className="text-sm text-crrf-muted">
          See how many CRF Credits your waste would earn
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
        <div>
          <label htmlFor="plastic" className="block text-sm font-medium text-crrf-ink mb-1">
            ♳ Plastic (kg)
          </label>
          <input
            id="plastic"
            type="number"
            step="0.1"
            min="0"
            value={plasticKg}
            onChange={(e) => setPlasticKg(e.target.value)}
            placeholder="e.g. 3.2"
            className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
          />
          <p className="text-xs text-crrf-subtle mt-1">10 pts per kg · rounded down to 0.5 kg</p>
        </div>
        <div>
          <label htmlFor="organic" className="block text-sm font-medium text-crrf-ink mb-1">
            🌿 Organic (kg)
          </label>
          <input
            id="organic"
            type="number"
            step="0.1"
            min="0"
            value={organicKg}
            onChange={(e) => setOrganicKg(e.target.value)}
            placeholder="e.g. 1.8"
            className="w-full px-4 py-3 rounded-[4px] border border-crrf-border bg-crrf-bg text-crrf-ink focus:outline-none focus:ring-2 focus:ring-crrf-forest focus:border-transparent"
          />
          <p className="text-xs text-crrf-subtle mt-1">5 pts per kg · rounded down to 0.5 kg</p>
        </div>
      </div>

      {/* Results */}
      <div className="bg-crrf-green-faint rounded-[12px] p-6">
        <div className="space-y-2 mb-4">
          {(plasticKg || organicKg) ? (
            <>
              <div className="flex justify-between text-sm">
                <span className="text-crrf-muted">
                  Plastic: {roundedPlastic} kg × 10 = 
                </span>
                <span className="font-mono font-semibold text-crrf-forest">{plasticPoints} pts</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-crrf-muted">
                  Organic: {roundedOrganic} kg × 5 =
                </span>
                <span className="font-mono font-semibold text-crrf-forest">{organicPoints} pts</span>
              </div>
              <div className="border-t border-crrf-border pt-2 mt-2"></div>
            </>
          ) : null}
        </div>

        <div className="flex justify-between items-center">
          <span className="font-display text-lg text-crrf-ink">You would earn</span>
          <span className="font-mono text-3xl font-bold text-crrf-forest">
            {totalPoints} <span className="text-base font-normal">pts</span>
          </span>
        </div>
      </div>

      {/* What you can buy */}
      {totalPoints > 0 && (
        <div className="mt-6">
          <h4 className="text-sm font-semibold text-crrf-ink mb-3">
            With {totalPoints} pts, you could buy:
          </h4>
          {affordableProducts.length > 0 ? (
            <div className="space-y-2">
              {affordableProducts.map((product) => (
                <div
                  key={product.name}
                  className="flex items-center justify-between bg-crrf-bg rounded-[4px] px-4 py-3"
                >
                  <div className="flex items-center">
                    <span className="text-xl mr-3">{product.emoji}</span>
                    <span className="text-sm text-crrf-ink">{product.name}</span>
                  </div>
                  <span className="font-mono text-sm font-semibold text-crrf-forest">
                    {product.creditPrice} pts
                  </span>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-sm text-crrf-muted italic">
              Earn at least 60 pts to unlock your first marketplace purchase.
            </p>
          )}
        </div>
      )}
    </div>
  );
}
