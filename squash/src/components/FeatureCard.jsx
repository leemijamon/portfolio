import styles from './FeatureCard.module.css'

// CSS Modules: styles.card처럼 '객체'로 클래스 이름을 불러와요
// 오타가 나면(styles.crad) 클래스가 아예 안 붙기 때문에, 화면이 이상하면 이름부터 확인!
function FeatureCard({ icon, title, description }) {
  return (
    <article className={styles.card}>
      <span className={styles.icon} aria-hidden="true">
        {icon}
      </span>
      <h3 className={styles.title}>{title}</h3>
      <p className={styles.description}>{description}</p>
    </article>
  )
}

export default FeatureCard
