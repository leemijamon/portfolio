import Button from '../Button'
import GearArt from './GearArt'
import { getTypeLabel, getLevelLabel } from '../../data/gear'
import styles from './GearDetail.module.scss'

// 장비 상세 내용 (Modal 안에 들어가요)
// - position / total: 지금 보는 장비가 목록에서 몇 번째인지 (예: 1 / 3)
// - onNext: '다음 장비' / onClose: '목록으로'
function GearDetail({ item, position, total, onNext, onClose }) {
  return (
    <div className={styles.detail}>
      {/* 왼쪽(모바일은 위쪽) 그림 패널 */}
      <div className={`${styles.visual} ${styles[item.tone]}`}>
        <div className={styles.visualTags}>
          {item.recommended && <span className={styles.badge}>입문 추천</span>}
          <span className={styles.count}>
            {position} / {total}
          </span>
        </div>
        <div className={styles.art}>
          <GearArt art={item.art} />
        </div>
        <div className={styles.highlight}>
          <span className="display">{item.highlight.value}</span>
          <p>{item.highlight.caption}</p>
        </div>
      </div>

      <div className={styles.content}>
        <div className={styles.head}>
          <div className={styles.tags}>
            <span className={styles.tag}>{getTypeLabel(item.type)}</span>
            {item.levels.map((level) => (
              <span key={level} className={styles.tag}>
                {getLevelLabel(level)}
              </span>
            ))}
          </div>
          <h2 id="gear-detail-title" className={styles.title}>
            {item.name}
          </h2>
          <p className={styles.summary}>{item.summary}</p>
        </div>

        {/* dl: 이름(dt)과 값(dd)이 짝인 목록 */}
        <dl className={styles.specs}>
          {item.specs.map((spec) => (
            <div key={spec.label}>
              <dt>{spec.label}</dt>
              <dd>{spec.value}</dd>
            </div>
          ))}
        </dl>

        <div>
          <b className={styles.subTitle}>이런 분께 추천해요</b>
          <ul className={styles.forWho}>
            {item.forWho.map((text) => (
              <li key={text}>{text}</li>
            ))}
          </ul>
        </div>

        <div className={styles.checkpoints}>
          <b>고를 때 체크포인트</b>
          <ol>
            {item.checkpoints.map((text, index) => (
              <li key={text}>
                <span className="display">{String(index + 1).padStart(2, '0')}</span>
                {text}
              </li>
            ))}
          </ol>
        </div>

        <div className={styles.actions}>
          <Button variant="outline" onClick={onClose}>
            목록으로
          </Button>
          {/* 장비가 1개뿐이면 '다음'이 필요 없어요 */}
          {total > 1 && (
            <Button variant="dark" onClick={onNext}>
              다음 장비 <span aria-hidden="true">→</span>
            </Button>
          )}
        </div>
      </div>
    </div>
  )
}

export default GearDetail
