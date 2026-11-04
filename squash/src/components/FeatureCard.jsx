import styles from './FeatureCard.module.css'

// 매력 카드 상단 그림 (장식이라 aria-hidden)
function FeatureArt({ type }) {
  if (type === 'pulse') {
    return (
      <svg viewBox="0 0 340 200" width="100%" height="100%" preserveAspectRatio="none" aria-hidden="true">
        <polyline
          points="0,130 60,130 80,130 95,60 112,170 128,40 146,150 160,130 220,130 236,80 250,160 264,110 340,110"
          fill="none"
          stroke="#D7FF3F"
          strokeWidth="4"
          strokeLinejoin="round"
        />
      </svg>
    )
  }
  if (type === 'wall') {
    return (
      <svg viewBox="0 0 340 200" width="100%" height="100%" aria-hidden="true">
        <rect x="40" y="30" width="260" height="130" fill="#F5F6F8" stroke="#CDD3DE" />
        <line x1="40" y1="44" x2="300" y2="44" stroke="#D42F25" strokeWidth="4" />
        <line x1="40" y1="112" x2="300" y2="112" stroke="#D42F25" strokeWidth="3" />
        <rect x="40" y="148" width="260" height="12" fill="#D42F25" />
        <path d="M40 160 L0 200 M300 160 L340 200" stroke="#CDD3DE" strokeWidth="2" />
        <circle cx="214" cy="78" r="13" fill="#0B1220" />
        <circle cx="210" cy="78" r="2.6" fill="#D7FF3F" />
        <circle cx="218" cy="78" r="2.6" fill="#D7FF3F" />
      </svg>
    )
  }
  // 'angle'
  return (
    <svg viewBox="0 0 340 200" width="100%" height="100%" aria-hidden="true">
      <rect x="110" y="16" width="120" height="170" fill="none" stroke="#0B1220" strokeWidth="2" />
      <line x1="110" y1="100" x2="230" y2="100" stroke="#0B1220" strokeWidth="2" />
      <line x1="170" y1="100" x2="170" y2="186" stroke="#0B1220" strokeWidth="2" />
      <polyline points="210,170 110,120 160,16 230,70" fill="none" stroke="#1F4BFF" strokeWidth="3" strokeDasharray="6 6" />
      <circle cx="230" cy="70" r="8" fill="#0B1220" />
    </svg>
  )
}

// 홈의 '스쿼시의 매력' 카드
// - highlight: true면 블루 카드로 강조
function FeatureCard({ number, art, title, description, highlight = false }) {
  return (
    <article className={`${styles.card} ${highlight ? styles.highlight : ''}`}>
      <div className={`${styles.visual} ${styles[art]}`}>
        <FeatureArt type={art} />
        {art === 'pulse' && <span className={styles.visualLabel}>HIGH INTENSITY</span>}
      </div>
      <span className={`display ${styles.number}`}>{number}</span>
      <h3 className={styles.title}>{title}</h3>
      <p className={styles.description}>{description}</p>
    </article>
  )
}

export default FeatureCard
