import { dotColors } from '../../data/gear'
import styles from './GearArt.module.scss'

// 장비 그림 (장식이라 화면 낭독기는 건너뛰어요: aria-hidden)
// art: data/gear.js의 art 값 { kind, variant?, dots? }
// size: 'lg'(카드) | 'sm'(모바일 카드·상세 창 썸네일)

// 라켓 색 조합: 배경색(tone)에 맞춰 잘 보이는 색으로
const racketColors = {
  power: { frame: '#ffffff', string: 'rgba(255,255,255,.5)', grip: '#0b1220' },
  control: { frame: '#d7ff3f', string: 'rgba(215,255,63,.4)', grip: '#ffffff' },
  speed: { frame: '#0b1220', string: 'rgba(11,18,32,.3)', grip: '#3d63cc' },
}

const shoeColors = {
  court: { upper: '#ffffff', line: '#0b1220', sole: '#d9b98a', stripe: '#3d63cc' },
  support: { upper: '#0b1220', line: '#ffffff', sole: '#ffffff', stripe: '#d7ff3f' },
}

// 공: 검은 공 + 색 점 (점 개수 = dots 배열 길이)
export function Ball({ dots, size = 'lg' }) {
  return (
    <span className={`${styles.ball} ${styles[size]}`} aria-hidden="true">
      {dots.map((dot, index) => (
        <i key={index} style={{ background: dotColors[dot] }} />
      ))}
    </span>
  )
}

function Racket({ variant }) {
  const c = racketColors[variant]
  return (
    <svg className={styles.svg} viewBox="0 0 230 120" aria-hidden="true">
      <g transform="rotate(-18 115 60)">
        <ellipse cx="66" cy="60" rx="56" ry="40" fill="none" stroke={c.frame} strokeWidth="7" />
        <path d="M30 40h72M24 60h84M30 80h72M50 24v72M66 20v80M82 24v72" stroke={c.string} strokeWidth="1.5" />
        <path d="M120 60 L150 60" stroke={c.frame} strokeWidth="7" />
        <rect x="150" y="52" width="70" height="16" rx="6" fill={c.grip} />
      </g>
    </svg>
  )
}

function Shoe({ variant }) {
  const c = shoeColors[variant]
  return (
    <svg className={styles.svg} viewBox="0 0 220 110" aria-hidden="true">
      <path
        d="M20 80 C 20 50, 40 30, 70 26 L 96 50 L 140 54 C 170 56, 196 66, 200 84 Z"
        fill={c.upper}
        stroke={c.line}
        strokeWidth="4"
        strokeLinejoin="round"
      />
      <path d="M16 82 H 204 V 96 H 16 Z" fill={c.sole} stroke={c.line} strokeWidth="4" strokeLinejoin="round" />
      <path d="M80 40 L120 54 M88 36 L128 50" stroke={c.stripe} strokeWidth="4" />
    </svg>
  )
}

function Goggles() {
  return (
    <svg className={styles.svg} viewBox="0 0 220 110" aria-hidden="true">
      <path d="M8 52 H 30 M190 52 H 212" stroke="#d7ff3f" strokeWidth="6" strokeLinecap="round" />
      <rect x="28" y="26" width="72" height="54" rx="24" fill="rgba(215,255,63,.18)" stroke="#d7ff3f" strokeWidth="6" />
      <rect x="120" y="26" width="72" height="54" rx="24" fill="rgba(215,255,63,.18)" stroke="#d7ff3f" strokeWidth="6" />
      <path d="M100 46 Q 110 36 120 46" fill="none" stroke="#d7ff3f" strokeWidth="6" />
      <path d="M44 40 L 60 36" stroke="#ffffff" strokeWidth="4" strokeLinecap="round" />
    </svg>
  )
}

function GearArt({ art, size = 'lg' }) {
  if (art.kind === 'ball') return <Ball dots={art.dots} size={size} />
  if (art.kind === 'racket') return <Racket variant={art.variant} />
  if (art.kind === 'shoe') return <Shoe variant={art.variant} />
  return <Goggles />
}

export default GearArt
