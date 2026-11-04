import { Link } from 'react-router-dom'
import styles from './PageHeader.module.css'

// 각 페이지 맨 위의 블루 배너
// - watermark: 배경에 크게 깔리는 영문 단어 (예: RULES)
// - children: 배너 아래쪽에 넣을 내용 (예: 페이지 안 이동 버튼)
function PageHeader({ watermark, title, description, children }) {
  return (
    <section className={styles.banner}>
      {watermark && (
        <span className={styles.watermark} aria-hidden="true">
          {watermark}
        </span>
      )}
      <div className={`container ${styles.inner}`}>
        <p className={styles.breadcrumb}>
          <Link to="/">홈</Link> / <b>{title}</b>
        </p>
        <h1 className={styles.title}>{title}</h1>
        {description && <p className={styles.description}>{description}</p>}
        {children}
      </div>
    </section>
  )
}

export default PageHeader
