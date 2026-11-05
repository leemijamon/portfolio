import styles from './Logo.module.scss'

// 가장 느린 공인 '더블 옐로' 볼을 옮긴 로고
// theme: 'light'(기본) | 'dark'(푸터) | 'onSky'(홈 하늘색 헤더)
function Logo({ theme = 'light' }) {
  return (
    <span className={`${styles.logo} ${styles[theme] ?? ''}`}>
      <span className={styles.ball} aria-hidden="true">
        <i></i>
        <i></i>
      </span>
      <span className={styles.wordmark}>FIRST RALLY</span>
    </span>
  )
}

export default Logo
