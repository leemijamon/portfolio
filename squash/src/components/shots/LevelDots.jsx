import { levelLabels } from '../../data/shots'
import styles from './LevelDots.module.scss'

// 난이도 점 3개 (level 개수만큼 채워져요)
// showText: 점 옆에 '보통' 같은 글자를 함께 보여줄지
function LevelDots({ level, showText = false }) {
  return (
    <span className={styles.level}>
      <span className="sr-only">난이도 {levelLabels[level]}</span>
      <span className={styles.dots} aria-hidden="true">
        {/* [1, 2, 3]을 돌면서 level 이하인 점만 채워요 */}
        {[1, 2, 3].map((dot) => (
          <i key={dot} className={dot <= level ? styles.filled : ''} />
        ))}
      </span>
      {showText && <b aria-hidden="true">{levelLabels[level]}</b>}
    </span>
  )
}

export default LevelDots
