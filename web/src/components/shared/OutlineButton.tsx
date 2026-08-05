import { cn } from '@/lib/utils';

interface OutlineButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  href?: string;
  className?: string;
  color?: 'white' | 'gold';
}

export default function OutlineButton({
  children,
  onClick,
  href,
  className,
  color = 'white',
}: OutlineButtonProps) {
  const colorClasses =
    color === 'gold'
      ? 'border-crrf-gold text-crrf-gold hover:bg-crrf-gold hover:text-crrf-forest'
      : 'border-crrf-white text-crrf-white hover:bg-crrf-white hover:text-crrf-forest';

  const baseClasses = cn(
    'inline-flex items-center justify-center rounded-full font-medium border-2 transition-all duration-200 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-crrf-foreground',
    colorClasses,
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
