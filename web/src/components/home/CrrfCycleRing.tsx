'use client';

import { motion, useReducedMotion } from 'framer-motion';
import { useEffect, useState } from 'react';

interface CycleNode {
  id: number;
  label: string;
  emoji: string;
  color: string;
  position: { x: number; y: number };
}

const cycleNodes: CycleNode[] = [
  { id: 0, label: 'Household', emoji: '🏠', color: '#1B6B3A', position: { x: 0, y: -180 } },
  { id: 1, label: 'Collection', emoji: '🚛', color: '#6B7280', position: { x: 180, y: 0 } },
  { id: 2, label: 'Processing', emoji: '⚙', color: '#6D4C41', position: { x: 0, y: 180 } },
  { id: 3, label: 'Farm', emoji: '🌾', color: '#2E8B57', position: { x: -180, y: 0 } },
];

const ringRadius = 180;
const centerX = 200;
const centerY = 200;
const nodeRadius = 28;
const labelOffset = 38;

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
        {cycleNodes.map((node) => {
          const pos = getNodePosition(node);
          const isActive = node.id === activeNode;
          const isNext = node.id === nextNodeIndex;

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
                x={pos.x - 22}
                y={pos.y - 22}
                width="44"
                height="44"
              >
                <div className="flex items-center justify-center text-2xl">
                  {node.emoji}
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
