import styles from './Logo.module.css'

// 검은 공 + 노란 점 두 개 = 스쿼시 공 모양 로고
// theme='dark'는 어두운 배경(푸터)에서 쓰는 버전이에요
function Logo({ theme = 'light' }) {
  return (
    <span className={`${styles.logo} ${theme === 'dark' ? styles.dark : ''}`}>
      <span className={styles.ball} aria-hidden="true">
        <i></i>
        <i></i>
      </span>
      <span className={styles.wordmark}>SQUASH 101</span>
    </span>
  )
}

export default Logo
