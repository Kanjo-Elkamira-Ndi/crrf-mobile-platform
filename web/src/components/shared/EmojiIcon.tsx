import {
  Recycle,
  Home,
  Truck,
  Wheat,
  Leaf,
  Settings,
  Package,
  Handbag,
  Calendar,
  BarChart3,
  Smartphone,
  ShoppingCart,
  Check,
  Sparkles,
  CircleDot,
  Scale,
  ArrowRight,
  Building,
  type LucideIcon,
} from 'lucide-react';

const emojiToIcon: Record<string, LucideIcon> = {
  '♻': Recycle,
  '♳': Package,
  '🏠': Home,
  '🚛': Truck,
  '🌾': Wheat,
  '🌱': Leaf,
  '🌿': Leaf,
  '🍂': Leaf,
  '⚙': Settings,
  '⚖': Scale,
  '⚪': CircleDot,
  '🏢': Building,
  '👛': Handbag,
  '📅': Calendar,
  '📊': BarChart3,
  '📱': Smartphone,
  '🛒': ShoppingCart,
  '✓': Check,
  '✨': Sparkles,
  '→': ArrowRight,
};

interface EmojiIconProps {
  emoji: string;
  className?: string;
}

export default function EmojiIcon({ emoji, className }: EmojiIconProps) {
  const Icon = emojiToIcon[emoji];
  if (!Icon) return <span className={className}>{emoji}</span>;
  return <Icon className={className} />;
}

export { emojiToIcon };
