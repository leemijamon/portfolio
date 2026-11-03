import { Link } from 'react-router-dom'
import Logo from './Logo'
import menus from '../data/menus'
import styles from './Footer.module.css'

function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={styles.inner}>
        <div className={styles.top}>
          <Link to="/" aria-label="Squash 101 홈으로">
            <Logo theme="dark" />
          </Link>
          <ul className={styles.menuList}>
            {menus.map((menu) => (
              <li key={menu.to}>
                <Link to={menu.to} className={styles.link}>
                  {menu.label}
                </Link>
              </li>
            ))}
          </ul>
        </div>

        {/* 장식용 대형 워드마크라서 화면 낭독기에서는 숨겨요 */}
        <p className={styles.wordmark} aria-hidden="true">
          SQUASH 101
        </p>

        <div className={styles.bottom}>
          <p>© 2026 Squash 101 · 규칙 출처: World Squash Federation</p>
          <p>퍼블리셔 이미자 포트폴리오 프로젝트 · React</p>
        </div>
      </div>
    </footer>
  )
}

export default Footer
