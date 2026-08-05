import { Package, Leaf } from 'lucide-react';
import { cn } from '@/lib/utils';

type WasteType = 'plastic' | 'organic';

interface WasteTypeBadgeProps {
  type: WasteType;
  className?: string;
}

const typeConfig: Record<WasteType, { label: string; color: string; icon: React.ComponentType<{ className?: string }> }> = {
  plastic: {
    label: 'Plastic',
    color: 'bg-blue-100 text-blue-700 border-blue-300',
    icon: Package,
  },
  organic: {
    label: 'Organic',
    color: 'bg-crrf-green-light text-crrf-forest border-crrf-green-mid',
    icon: Leaf,
  },
};

export default function WasteTypeBadge({ type, className }: WasteTypeBadgeProps) {
  const config = typeConfig[type];
  const Icon = config.icon;
  return (
    <span
      className={cn(
        'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border',
        config.color,
        className,
      )}
    >
      <Icon className="h-3.5 w-3.5" />
      <span className="ml-1">{config.label}</span>
    </span>
  );
}
