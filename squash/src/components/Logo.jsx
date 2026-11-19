import styles from './Logo.module.scss'

// 가장 느린 공인 '더블 옐로' 볼을 옮긴 로고
// theme: 'light'(기본) | 'dark'(푸터) | 'onSky'(홈 하늘색 헤더)
// size: 'big'(큰 사이즈 가이드)
function Logo({ theme = 'light', size ='default' }) {
  return (
    <span className={`${styles.logo} ${styles[theme] ?? ''} ${styles[size] ?? ''}`}>
      <span className={styles.ball} aria-hidden="true">
        <i></i>
        <i></i>
      </span>
      <span className={styles.wordmark}>FIRST RALLY</span>
    </span>
  )
}

export default Logo
