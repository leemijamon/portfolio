import { Link } from 'react-router-dom'
import styles from './GuideCard.module.scss'

// 카드 위쪽 그림 영역 (장식)
function GuideVisual({ type }) {
  if (type === 'court') {
    return (
      <svg width="150" height="200" viewBox="0 0 150 200" aria-hidden="true">
        <rect x="5" y="5" width="140" height="190" fill="none" stroke="#fff" strokeWidth="3" />
        <line x1="5" y1="110" x2="145" y2="110" stroke="#D42F25" strokeWidth="3" />
        <line x1="75" y1="110" x2="75" y2="195" stroke="#D42F25" strokeWidth="3" />
        <rect x="5" y="110" width="35" height="35" fill="none" stroke="#D42F25" strokeWidth="3" />
        <rect x="110" y="110" width="35" height="35" fill="none" stroke="#D42F25" strokeWidth="3" />
        <rect x="5" y="5" width="140" height="8" fill="#D7FF3F" />
      </svg>
    )
  }
  if (type === 'balls') {
    // 점 색깔: 블루 · 레드 · 싱글 옐로 · 더블 옐로
    const balls = [['#2E8BFF'], ['#FF5247'], ['#FFD400'], ['#FFD400', '#FFD400']]
    return (
      <div className={styles.ballRow} aria-hidden="true">
        {balls.map((dots, index) => (
          <span key={index} className={styles.ball}>
            {dots.map((color, i) => (
              <i key={i} style={{ background: color }} />
            ))}
          </span>
        ))}
      </div>
    )
  }
  // 'shots'
  return (
    <div className={styles.shotStage} aria-hidden="true">
      <span className={styles.pillDark}>
        드라이브 <b className="display">DRIVE</b>
      </span>
      <span className={styles.pillBlue}>
        보스트 <b className="display">BOAST</b>
      </span>
      <span className={styles.pillVolt}>
        드롭 <b className="display">DROP</b>
      </span>
    </div>
  )
}

// 홈 '입문 가이드' 카드: 카드 전체가 하나의 링크
function GuideCard({ to, visual, title, en, points, linkLabel }) {
  return (
    <Link to={to} className={styles.card}>
      <div className={`${styles.visual} ${styles[visual]}`}>
        <GuideVisual type={visual} />
      </div>
      <div className={styles.body}>
        <div className={styles.titleRow}>
          <h3 className={styles.title}>{title}</h3>
          <span className={`display ${styles.en}`} aria-hidden="true">
            {en}
          </span>
        </div>
        <ul className={styles.points}>
          {points.map((point) => (
            <li key={point}>— {point}</li>
          ))}
        </ul>
        <span className={styles.link}>
          {linkLabel}
          <span className={styles.arrow} aria-hidden="true">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4">
              <path d="M7 17L17 7M9 7h8v8" />
            </svg>
          </span>
        </span>
      </div>
    </Link>
  )
}

export default GuideCard
