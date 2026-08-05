import { cn } from '@/lib/utils';

type WasteType = 'plastic' | 'organic';

interface WasteTypeBadgeProps {
  type: WasteType;
  className?: string;
}

const typeConfig: Record<WasteType, { label: string; color: string }> = {
  plastic: { label: 'Plastic', color: 'bg-blue-100 text-blue-700 border-blue-300' },
  organic: { label: 'Organic', color: 'bg-crrf-green-light text-crrf-forest border-crrf-green-mid' },
};

export default function WasteTypeBadge({ type, className }: WasteTypeBadgeProps) {
  const config = typeConfig[type];
  return (
    <span
      className={cn(
        'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border',
        config.color,
        className,
      )}
    >
      {type === 'plastic' && '♳'}
      {type === 'organic' && '🌿'}
      <span className="ml-1">{config.label}</span>
    </span>
  );
}
