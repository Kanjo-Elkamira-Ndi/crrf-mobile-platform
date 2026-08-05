import { cn } from '@/lib/utils';

interface SectionLabelProps {
  text: string;
  className?: string;
}

export default function SectionLabel({ text, className }: SectionLabelProps) {
  return (
    <div className={cn('inline-flex items-center px-3 py-1 rounded-full bg-crrf-gold/15 text-crrf-gold text-xs font-bold uppercase tracking-wider mb-4', className)}>
      {text}
    </div>
  );
}
