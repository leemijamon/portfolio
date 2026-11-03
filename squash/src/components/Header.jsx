import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import Logo from './Logo'
import Button from './Button'
import menus from '../data/menus'
import styles from './Header.module.css'

function Header() {
  // state: 모바일 메뉴가 열려 있는지 (true / false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  const closeMenu = () => setIsMenuOpen(false)

  return (
    <header className={styles.header}>
      <div className={styles.inner}>
        <Link to="/" className={styles.logoLink} onClick={closeMenu} aria-label="Squash 101 홈으로">
          <Logo />
        </Link>

        <nav
          id="main-menu"
          className={`${styles.nav} ${isMenuOpen ? styles.navOpen : ''}`}
          aria-label="주요 메뉴"
        >
          <ul className={styles.menuList}>
            {menus.map((menu) => (
              <li key={menu.to}>
                {/* NavLink는 현재 주소와 같으면 isActive가 true가 돼요 */}
                <NavLink
                  to={menu.to}
                  onClick={closeMenu}
                  className={({ isActive }) =>
                    isActive ? `${styles.link} ${styles.active}` : styles.link
                  }
                >
                  {menu.label}
                </NavLink>
              </li>
            ))}
          </ul>
        </nav>

        <div className={styles.cta}>
          <Button to="/score">점수 기록 시작</Button>
        </div>

        {/* 모바일에서만 보이는 메뉴 버튼 */}
        <button
          type="button"
          className={styles.menuButton}
          aria-expanded={isMenuOpen}
          aria-controls="main-menu"
          aria-label={isMenuOpen ? '메뉴 닫기' : '메뉴 열기'}
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          {isMenuOpen ? (
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path d="M6 6l12 12M18 6 6 18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
            </svg>
          ) : (
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path d="M4 7h16M4 12h16M4 17h16" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
            </svg>
          )}
        </button>
      </div>
    </header>
  )
}

export default Header
