// 코트 그림 2종 (앞벽 / 바닥)
// active: 지금 선택된 라인 번호 → 해당 라인만 블루로 강조해요

const RED = '#D42F25'
const BLUE = '#1F4BFF'
const VOLT = '#D7FF3F'
const INK = '#0B1220'

// 번호 원 (선택되면 블루 + 흰 테두리)
function Marker({ x, y, number, active, size = 15 }) {
  const isActive = active === number
  return (
    <g>
      <circle
        cx={x}
        cy={y}
        r={isActive ? size + 3 : size}
        fill={isActive ? BLUE : INK}
        stroke="#fff"
        strokeWidth={isActive ? 3 : 0}
      />
      <text x={x} y={y + 5} textAnchor="middle" fontSize="15" fontWeight="700" fill="#fff" fontFamily="Noto Sans KR">
        {number}
      </text>
    </g>
  )
}

// 앞벽: 1 아웃 라인 / 2 서비스 라인 / 3 틴
export function FrontWallDiagram({ active }) {
  const lineColor = (id) => (active === id ? BLUE : RED)
  const lineWidth = (id) => (active === id ? 8 : 5)

  return (
    <svg
      role="img"
      aria-label="앞벽 그림: 위에서부터 아웃 라인 4.57m, 서비스 라인 1.78m, 틴 0.48m"
      viewBox="0 0 640 300"
      width="100%"
    >
      <rect x="20" y="10" width="600" height="270" fill="#fff" stroke="#CDD3DE" strokeWidth="2" />

      {/* 선택된 라인 뒤에 볼트색 띠 */}
      {active === 1 && <rect x="20" y="43" width="600" height="18" fill={VOLT} />}
      {active === 2 && <rect x="20" y="182" width="600" height="18" fill={VOLT} />}

      <line x1="20" y1="52" x2="620" y2="52" stroke={lineColor(1)} strokeWidth={lineWidth(1)} />
      <line x1="20" y1="191" x2="620" y2="191" stroke={lineColor(2)} strokeWidth={lineWidth(2)} />
      <rect x="20" y="256" width="600" height="24" fill={lineColor(3)} />
      <line x1="0" y1="280" x2="640" y2="280" stroke={INK} strokeWidth="2" />

      <Marker x={56} y={52} number={1} active={active} />
      <Marker x={56} y={191} number={2} active={active} />
      <Marker x={56} y={268} number={3} active={active} />

      <text x="604" y="40" textAnchor="end" fontSize="14" fill="#5A6478" fontFamily="Noto Sans KR">4.57m</text>
      <text x="604" y="179" textAnchor="end" fontSize="14" fill="#5A6478" fontFamily="Noto Sans KR">1.78m</text>
      <text x="604" y="248" textAnchor="end" fontSize="14" fill="#5A6478" fontFamily="Noto Sans KR">0.48m</text>
    </svg>
  )
}

// 바닥(위에서 본 모습): 4 쇼트 라인 / 5 하프 코트 라인 / 6 서비스 박스
export function CourtFloorDiagram({ active }) {
  const lineColor = (id) => (active === id ? BLUE : RED)
  const lineWidth = (id) => (active === id ? 7 : 4)

  return (
    <svg
      role="img"
      aria-label="코트 바닥을 위에서 본 그림: 쇼트 라인, 하프 코트 라인, 좌우 서비스 박스"
      viewBox="0 0 300 440"
      width="100%"
    >
      <rect x="22" y="20" width="256" height="390" fill="#fff" stroke={INK} strokeWidth="2" />
      <rect x="22" y="12" width="256" height="8" fill={RED} />

      {/* 서비스 박스: 선택되면 볼트색으로 채워요 */}
      <rect
        x="22"
        y="237"
        width="64"
        height="64"
        fill={active === 6 ? VOLT : 'rgba(31,75,255,.08)'}
        stroke={lineColor(6)}
        strokeWidth={lineWidth(6)}
      />
      <rect
        x="214"
        y="237"
        width="64"
        height="64"
        fill={active === 6 ? VOLT : 'rgba(31,75,255,.08)'}
        stroke={lineColor(6)}
        strokeWidth={lineWidth(6)}
      />
      <line x1="22" y1="237" x2="278" y2="237" stroke={lineColor(4)} strokeWidth={lineWidth(4)} />
      <line x1="150" y1="237" x2="150" y2="410" stroke={lineColor(5)} strokeWidth={lineWidth(5)} />

      <Marker x={110} y={237} number={4} active={active} size={14} />
      <Marker x={150} y={360} number={5} active={active} size={14} />
      <Marker x={246} y={269} number={6} active={active} size={14} />

      <text x="150" y="8" textAnchor="middle" fontSize="12" fill="#5A6478" fontFamily="Noto Sans KR">앞벽</text>
      <text x="150" y="432" textAnchor="middle" fontSize="12" fill="#5A6478" fontFamily="Noto Sans KR">뒷벽</text>
    </svg>
  )
}
