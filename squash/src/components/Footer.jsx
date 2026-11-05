import { Link } from 'react-router-dom'
import Button from './Button'
import styles from './Footer.module.scss'

// 푸터 메뉴를 묶음(그룹)별 데이터로
const footerGroups = [
  {
    title: '가이드',
    links: [
      { to: '/rules', label: '규칙 가이드' },
      { to: '/gear', label: '장비 가이드' },
      { to: '/glossary', label: '샷 용어 사전' },
    ],
  },
  {
    title: '도구',
    links: [
      { to: '/score', label: '점수 계산기' },
      { to: '/#checklist', label: '첫 코트 체크리스트' },
    ],
  },
]

function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={styles.inner}>
        <div className={styles.top}>
          <div>
            <h2 className={styles.ctaTitle}>첫 랠리, 오늘 시작해 볼까요?</h2>
            <Button to="/rules" variant="volt">
              규칙 가이드부터 보기
            </Button>
          </div>

          <nav aria-label="푸터 메뉴" className={styles.nav}>
            {footerGroups.map((group) => (
              <div key={group.title} className={styles.group}>
                <b className={styles.groupTitle}>{group.title}</b>
                {group.links.map((link) => (
                  <Link key={link.to} to={link.to} className={styles.link}>
                    {link.label}
                  </Link>
                ))}
              </div>
            ))}
          </nav>
        </div>

        <div className={styles.bottom}>
          <p>규칙 내용은 세계스쿼시연맹(WSF) 단식 규칙을 입문자 눈높이로 정리했습니다.</p>
          <p>© 2026 FIRST RALLY · 퍼블리셔 이미자 포트폴리오</p>
        </div>
      </div>

      {/* 장식용 대형 워드마크라서 화면 낭독기에서는 숨겨요 */}
      <p className={`display ${styles.wordmark}`} aria-hidden="true">
        FIRST RALLY
      </p>
    </footer>
  )
}

export default Footer
