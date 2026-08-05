'use client';

import { motion, useReducedMotion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { Home, Truck, Settings, Wheat } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';

interface CycleNode {
  id: number;
  label: string;
  icon: LucideIcon;
  color: string;
  position: { x: number; y: number };
}

const cycleNodes: CycleNode[] = [
  { id: 0, label: 'Household', icon: Home, color: '#1B6B3A', position: { x: 0, y: -180 } },
  { id: 1, label: 'Collection', icon: Truck, color: '#6B7280', position: { x: 180, y: 0 } },
  { id: 2, label: 'Processing', icon: Settings, color: '#6D4C41', position: { x: 0, y: 180 } },
  { id: 3, label: 'Farm', icon: Wheat, color: '#2E8B57', position: { x: -180, y: 0 } },
];

const ringRadius = 180;
const centerX = 200;
const centerY = 200;
const nodeRadius = 28;
const labelOffset = 38;

// SVG path data for icons (extracted from Lucide React for use inside SVG foreignObject fallback)
const iconPaths: Record<string, string[]> = {
  Home: ['M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z', 'M9 18v-6h6v6'],
  Truck: ['M3 16v5a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5M3 16l2-2V7a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v7l2 2'],
  Settings: ['M12 15.5A3.5 3.5 0 0 1 8.5 12A3.5 3.5 0 0 1 12 8.5a3.5 3.5 0 0 1 3.5 3.5 3.5 3.5 0 0 1-3.5 3.5Zm7.43-2.54a9.43 9.43 0 0 0 0-2.54 2.94 2.94 0 0 0 2.42-2.42 2.94 2.94 0 0 0-.55-2.55l-2.1 2.1a17.8 17.8 0 0 0-1.42-1.29l.65-2.52a2.94 2.94 0 0 0-2.42-2.12 2.94 2.94 0 0 0-1.82.87 17.7 17.7 0 0 0-1.29-1.42l-2.52.65a2.94 2.94 0 0 0-2.12-2.42 2.94 2.94 0 0 0-2.55.55l2.1 2.1A17.9 17.9 0 0 0 5.46 6.17l-.65 2.52a2.94 2.94 0 0 0 .55 2.55 2.94 2.94 0 0 1 .93.93 2.94 2.94 0 0 0 1.62 1.62 2.94 2.94 0 0 1-.23 2.37A9.4 9.4 0 0 0 4.56 13.2'],
  Wheat: ['M2 22l20-20'],
};

const iconNames = ['Home', 'Truck', 'Settings', 'Wheat'];

export default function CrrfCycleRing() {
  const shouldReduceMotion = useReducedMotion();
  const [activeNode, setActiveNode] = useState(0);

  useEffect(() => {
    if (shouldReduceMotion) return;
    const interval = setInterval(() => {
      setActiveNode((prev) => (prev + 1) % cycleNodes.length);
    }, 2200);
    return () => clearInterval(interval);
  }, [shouldReduceMotion]);

  const nextNodeIndex = (activeNode + 1) % cycleNodes.length;

  const polarToCartesian = (radius: number, angleDegrees: number) => {
    const angleRad = (angleDegrees - 90) * Math.PI / 180;
    return {
      x: centerX + radius * Math.cos(angleRad),
      y: centerY + radius * Math.sin(angleRad),
    };
  };

  const getNodePosition = (node: CycleNode) => {
    const angle = cycleNodes.indexOf(node) * 90;
    return polarToCartesian(ringRadius, angle);
  };

  const getArcPath = (startAngle: number, endAngle: number) => {
    const start = polarToCartesian(ringRadius, startAngle);
    const end = polarToCartesian(ringRadius, endAngle);
    const largeArc = endAngle - startAngle > 180 ? 1 : 0;
    return `M ${start.x} ${start.y} A ${ringRadius} ${ringRadius} 0 ${largeArc} 1 ${end.x} ${end.y}`;
  };

  const renderIcon = (iconName: string, isActive: boolean, isNext: boolean) => {
    const paths = iconPaths[iconName] || [];
    return (
      <svg
        width="28"
        height="28"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth={isActive ? "2.5" : isNext ? "2" : "1.5"}
        strokeLinecap="round"
        strokeLinejoin="round"
        style={{ color: isActive ? '#FFFFFF' : isNext ? '#FFFFFF' : '#FFFFFF' }}
      >
        {paths.map((path, i) => (
          <path key={i} d={path} />
        ))}
      </svg>
    );
  };

  return (
    <motion.div
      className="relative w-72 h-72 mx-auto"
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.8, ease: 'easeOut' }}
    >
      <svg
        width="280"
        height="280"
        viewBox="0 0 400 400"
        className="w-full h-full"
      >
        {/* Track ring */}
        <circle
          cx={centerX}
          cy={centerY}
          r={ringRadius}
          fill="none"
          stroke="#1B6B3A"
          strokeWidth="2"
          opacity="0.12"
        />

        {/* Arrow paths between nodes */}
        {cycleNodes.map((_, i) => {
          const startAngle = i * 90 + 10;
          const endAngle = (i + 1) * 90 - 10;
          const isActive = i === activeNode;

          if (shouldReduceMotion) return null;

          return (
            <motion.path
              key={`arrow-${i}`}
              d={getArcPath(startAngle, endAngle)}
              fill="none"
              stroke={isActive ? '#2E8B57' : '#D1D5DB'}
              strokeWidth={isActive ? '3' : '2'}
              strokeLinecap="round"
              initial={{ pathLength: 0, opacity: 0.3 }}
              animate={{
                pathLength: isActive ? [0, 1, 0] : 0.3,
                opacity: isActive ? [0.3, 1, 0.3] : 0.3,
              }}
              transition={{
                duration: isActive ? 0.8 : 0.4,
                repeat: isActive ? Infinity : 0,
                repeatDelay: 1.4,
              }}
              style={{
                filter: 'url(#glow)',
              }}
            />
          );
        })}

        {/* Arrow marker definition */}
        <defs>
          <marker
            id="arrowhead"
            markerWidth="10"
            markerHeight="7"
            refX="9"
            refY="3.5"
            orient="auto"
          >
            <polygon points="0 0, 10 3.5, 0 7" fill="#2E8B57" />
          </marker>
          <filter id="glow" x="-50%" y="-50%" width="200%" height="200%">
            <feGaussianBlur stdDeviation="2" result="coloredBlur" />
            <feMerge>
              <feMergeNode in="coloredBlur" />
              <feMergeNode in="SourceGraphic" />
            </feMerge>
          </filter>
        </defs>

        {/* Nodes */}
        {cycleNodes.map((node, idx) => {
          const pos = getNodePosition(node);
          const isActive = node.id === activeNode;
          const isNext = node.id === nextNodeIndex;
          const iconName = iconNames[idx];

          return (
            <g key={node.id}>
              <motion.circle
                cx={pos.x}
                cy={pos.y}
                r={isActive ? nodeRadius + 4 : nodeRadius}
                fill={node.color}
                opacity={isActive || isNext ? 1 : 0.4}
                animate={{
                  r: isActive ? [nodeRadius, nodeRadius + 6, nodeRadius] : nodeRadius,
                  opacity: isActive ? [0.4, 1, 0.4] : (isNext ? 0.7 : 0.4),
                }}
                transition={{
                  duration: shouldReduceMotion ? 0 : 0.6,
                  repeat: shouldReduceMotion ? 0 : (isActive ? Infinity : 0),
                  repeatType: 'loop',
                  repeatDelay: 1.6,
                }}
                stroke="white"
                strokeWidth="3"
              />
              <foreignObject
                x={pos.x - 18}
                y={pos.y - 18}
                width="36"
                height="36"
              >
                <div className="flex items-center justify-center">
                  {renderIcon(iconName, isActive, isNext)}
                </div>
              </foreignObject>

              {/* Label below node */}
              <text
                x={pos.x}
                y={pos.y + labelOffset + 14}
                textAnchor="middle"
                fontSize="13"
                fontWeight={isActive ? 'bold' : 'normal'}
                fill={isActive ? node.color : '#9CA3AF'}
              >
                {node.label}
              </text>
            </g>
          );
        })}

        {/* Center label */}
        <text
          x={centerX}
          y={centerY + 6}
          textAnchor="middle"
          fontSize="14"
          fontWeight="600"
          fill="#1B6B3A"
        >
          The CRRF Loop
        </text>
      </svg>
    </motion.div>
  );
}
