import styles from './PageHeader.module.css'

// 각 페이지 맨 위의 제목 영역 (라벨 + 제목 + 설명)
function PageHeader({ label, title, description }) {
  return (
    <div className={`container ${styles.pageHeader}`}>
      <p className={styles.label}>{label}</p>
      <h1 className={styles.title}>{title}</h1>
      {description && <p className={styles.description}>{description}</p>}
    </div>
  )
}

export default PageHeader
