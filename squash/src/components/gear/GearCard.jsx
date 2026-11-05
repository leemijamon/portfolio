import GearArt from './GearArt'
import { getTypeLabel, getLevelLabel } from '../../data/gear'
import styles from './GearCard.module.scss'

// 장비 카드 1장
// - item: data/gear.js의 장비 하나
// - onOpen: '자세히 보기'를 누르면 부모에게 알려 줘요 (상세 창 열기)
function GearCard({ item, onOpen }) {
  return (
    <article className={styles.card}>
      <div className={`${styles.visual} ${styles[item.tone]}`}>
        {item.recommended && <span className={styles.badge}>입문 추천</span>}
        <GearArt art={item.art} />
      </div>

      <div className={styles.body}>
        <div className={styles.tags}>
          <span className={styles.tag}>{getTypeLabel(item.type)}</span>
          {item.levels.map((level) => (
            <span key={level} className={styles.tag}>
              {getLevelLabel(level)}
            </span>
          ))}
        </div>
        <h3 className={styles.name}>{item.name}</h3>
        <p className={styles.summary}>{item.summary}</p>
        <p className={styles.specs}>
          {item.specs.map((spec) => (
            <span key={spec.label}>{spec.value}</span>
          ))}
        </p>

        {/* 버튼의 ::after가 카드 전체를 덮어서, 카드 어디를 눌러도 열려요 */}
        <button type="button" className={styles.more} onClick={() => onOpen(item.id)}>
          <span>
            자세히 보기<span className="sr-only"> · {item.name}</span>
          </span>
          <span aria-hidden="true">→</span>
        </button>
      </div>
    </article>
  )
}

export default GearCard
