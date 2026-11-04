import { useState } from 'react'
import { Link, NavLink, useLocation } from 'react-router-dom'
import Logo from './Logo'
import Button from './Button'
import menus from '../data/menus'
import styles from './Header.module.css'

function Header() {
  // state: 모바일 메뉴가 열려 있는지 (true / false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  // 홈에서는 히어로 하늘색과 이어지는 파란 헤더를 써요
  const { pathname } = useLocation()
  const isHome = pathname === '/'

  const closeMenu = () => setIsMenuOpen(false)

  // NavLink는 현재 주소와 같으면 isActive가 true가 돼요
  const linkClass = ({ isActive }) => (isActive ? `${styles.link} ${styles.active}` : styles.link)

  return (
    <header className={`${styles.header} ${isHome ? styles.onSky : ''}`}>
      <div className={styles.inner}>
        <Link to="/" className={styles.logoLink} onClick={closeMenu} aria-label="FIRST RALLY 홈으로">
          <Logo theme={isHome ? 'onSky' : 'light'} />
        </Link>

        <nav
          id="main-menu"
          className={`${styles.nav} ${isMenuOpen ? styles.navOpen : ''}`}
          aria-label="주요 메뉴"
        >
          <ul className={styles.menuList}>
            {menus.map((menu) => (
              <li key={menu.to}>
                {/* end: '/'(홈)은 정확히 '/'일 때만 활성화되게 */}
                <NavLink to={menu.to} end={menu.to === '/'} onClick={closeMenu} className={linkClass}>
                  {menu.label}
                </NavLink>
              </li>
            ))}
            {/* 모바일 메뉴에서만 보이는 점수 계산기 링크 */}
            <li className={styles.mobileOnly}>
              <NavLink to="/score" onClick={closeMenu} className={linkClass}>
                점수 계산기
              </NavLink>
            </li>
          </ul>
        </nav>

        <div className={styles.cta}>
          <Button to="/score" variant={isHome ? 'volt' : 'dark'} size="sm">
            점수 계산기
          </Button>
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
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path d="M6 6l12 12M18 6 6 18" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" />
            </svg>
          ) : (
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" aria-hidden="true">
              <path d="M4 7h16M4 12h16M4 17h10" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" />
            </svg>
          )}
        </button>
      </div>
    </header>
  )
}

export default Header
