import { cn } from '@/lib/utils';

interface GreenButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  href?: string;
  className?: string;
  fullWidth?: boolean;
}

export default function GreenButton({
  children,
  onClick,
  href,
  className,
  fullWidth,
}: GreenButtonProps) {
  const baseClasses = cn(
    'inline-flex items-center justify-center rounded-full font-medium transition-all duration-200 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-crrf-forest bg-crrf-gold text-crrf-forest shadow-[0_8px_32px_rgba(82,171,93,0.25)] hover:shadow-[0_12px_40px_rgba(82,171,93,0.35)] hover:scale-[1.02] active:scale-[0.98]',
    fullWidth && 'w-full',
    className,
  );

  if (href) {
    return (
      <a href={href} className={baseClasses}>
        {children}
      </a>
    );
  }

  return (
    <button type="button" onClick={onClick} className={baseClasses}>
      {children}
    </button>
  );
}
