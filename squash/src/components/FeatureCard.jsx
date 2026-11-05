import styles from './FeatureCard.module.scss'

// 홈의 '스쿼시의 매력' 카드
// - image / imageAlt: 상단 사진과 대체 텍스트
// - highlight: true면 블루 카드로 강조
function FeatureCard({ number, image, imageAlt, title, description, highlight = false }) {
  return (
    <article className={`${styles.card} ${highlight ? styles.highlight : ''}`}>
      <div className={styles.visual}>
        <img className={styles.image} src={image} alt={imageAlt} width="1672" height="941" loading="lazy" />
      </div>
      <span className={`display ${styles.number}`}>{number}</span>
      <h3 className={styles.title}>{title}</h3>
      <p className={styles.description}>{description}</p>
    </article>
  )
}

export default FeatureCard
