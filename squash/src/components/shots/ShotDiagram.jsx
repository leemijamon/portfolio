// 위에서 본 코트 그림 + 공의 궤적 (앞벽이 위쪽)
// diagram: data/shots.js의 diagram 값 { player, path, nick?, tOnly? }
// 좌표는 가로 60 × 세로 90 기준이라, 그림 크기가 달라도 같은 데이터를 써요

const RED = '#d42f25'
const BLUE = '#3d63cc'
const INK = '#0b1220'
const VOLT = '#d7ff3f'

function ShotDiagram({ diagram, label }) {
  const { player, path, nick, tOnly } = diagram
  // [[46,62],[52,2]] → "46,62 52,2" (polyline이 원하는 글자 형태)
  const points = path.map((point) => point.join(',')).join(' ')
  const [ballX, ballY] = path[path.length - 1]

  return (
    <svg viewBox="0 0 60 90" width="100%" role={label ? 'img' : undefined} aria-label={label} aria-hidden={label ? undefined : true}>
      {/* 코트 바닥과 라인 */}
      <rect x="2" y="2" width="56" height="86" fill="#fff" stroke={INK} strokeWidth="1.5" />
      <rect x="2" y="0" width="56" height="3" fill={RED} />
      <line x1="2" y1="50" x2="58" y2="50" stroke={RED} strokeWidth="1" />
      <line x1="30" y1="50" x2="30" y2="88" stroke={RED} strokeWidth="1" />
      <rect x="2" y="50" width="14" height="14" fill="none" stroke={RED} strokeWidth="1" />
      <rect x="44" y="50" width="14" height="14" fill="none" stroke={RED} strokeWidth="1" />

      {/* 닉: 옆벽과 바닥이 만나는 모서리 강조 */}
      {nick && <line x1="57" y1="12" x2="57" y2="32" stroke={VOLT} strokeWidth="3" />}
      {/* T 포지션: 가운데 T 지점 강조 */}
      {tOnly && <circle cx="30" cy="50" r="6" fill={VOLT} opacity="0.7" />}

      {/* 공의 궤적 (파란 점선) */}
      <polyline points={points} fill="none" stroke={BLUE} strokeWidth="1.8" strokeDasharray="3 2" strokeLinejoin="round" />

      {/* 치는 사람(볼트 원)과 공이 떨어지는 곳(검은 원) */}
      <circle cx={player[0]} cy={player[1]} r="4" fill={VOLT} stroke={INK} strokeWidth="1" />
      {!tOnly && <circle cx={ballX} cy={ballY} r="2.6" fill={INK} />}
    </svg>
  )
}

export default ShotDiagram
