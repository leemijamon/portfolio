import { Link } from 'react-router-dom'
import ShotDiagram from './ShotDiagram'
import LevelDots from './LevelDots'
import Highlight from '../Highlight'
import { getCategoryLabel } from '../../data/shots'
import styles from './ShotCard.module.scss'

// 샷 카드 (누르면 상세 페이지로)
// - variant: 'row'(검색 결과 · 그림 왼쪽) | 'tile'(기본 샷 · 그림 위쪽)
// - query: 이름에서 강조할 검색어
// - from: 상세 페이지의 '목록으로'가 돌아올 주소 (검색어 유지용)
function ShotCard({ shot, variant = 'row', query = '', from = '' }) {
  return (
    <Link to={`/glossary/${shot.id}`} state={{ from }} className={`${styles.card} ${styles[variant]}`}>
      <span className={styles.diagram}>
        <ShotDiagram diagram={shot.diagram} />
      </span>
      <span className={styles.text}>
        {variant === 'row' && (
          <span className={`${styles.tag} ${shot.category === 'attack' ? styles.tagBlue : ''}`}>
            {getCategoryLabel(shot.category)}
          </span>
        )}
        <span className={styles.titleRow}>
          <b className={styles.name}>
            <Highlight text={shot.name} query={query} />
          </b>
          <span className={`display ${styles.en}`}>{shot.en}</span>
        </span>
        <span className={styles.summary}>{shot.summary}</span>
        {variant === 'row' && <LevelDots level={shot.level} />}
      </span>
    </Link>
  )
}

export default ShotCard
