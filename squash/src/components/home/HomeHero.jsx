import Button from '../Button'
import athlete from '../../assets/squash-human.webp'
import styles from './HomeHero.module.css'

const letters = ['S', 'Q', 'U', 'A', 'S', 'H']

// 공이 지나가는 속도선 (위치·지연·길이만 다름 → 데이터로 반복)
const streaks = [
  { top: '42%', delay: '1.7s', width: '24%' },
  { top: '49%', delay: '2.1s', width: '18%', volt: true },
  { top: '59%', delay: '2.5s', width: '30%' },
  { top: '35%', delay: '3s', width: '13%', volt: true },
]

function HomeHero() {
  return (
    <section className={styles.hero}>
      <div className={styles.stage}>
        {/* ↓ 장식 요소들은 화면 낭독기가 읽지 않도록 aria-hidden */}
        <div className={styles.sky} aria-hidden="true" />

        <div className={`display ${styles.word}`} aria-hidden="true">
          {letters.map((letter, index) => (
            // style에 CSS 변수(--i)를 넘겨서 글자마다 등장 시간을 다르게
            <span key={index} className={styles.letter} style={{ '--i': index }}>
              {letter}
            </span>
          ))}
        </div>

        <div className={styles.floor} aria-hidden="true" />
        <span className={styles.floorShadow} aria-hidden="true" />

        <div className={styles.streaks} aria-hidden="true">
          {streaks.map((streak) => (
            <span
              key={streak.top}
              className={`${styles.streak} ${streak.volt ? styles.streakVolt : ''}`}
              style={{ top: streak.top, width: streak.width, animationDelay: streak.delay }}
            />
          ))}
        </div>

        <img
          className={styles.athlete}
          src={athlete}
          alt="스쿼시 선수가 낮게 런지하며 라켓을 뻗어 공을 받아치는 모습"
          width="1671"
          height="941"
        />

        {/* 라켓에 맞고 튀어나가는 공 */}
        <span className={styles.trail} aria-hidden="true" />
        <span className={styles.ring} aria-hidden="true" />
        <span className={styles.ball} aria-hidden="true">
          <i />
          <i />
        </span>

        <p className={styles.vertical} aria-hidden="true">
          SQUASH FOR BEGINNERS · 입문 가이드
        </p>
      </div>

      <div className={styles.copy}>
        <h1 className={styles.title}>
          <span className={styles.line}>
            <span style={{ animationDelay: '1.3s' }}>벽을 향해 치는,</span>
          </span>
          <span className={styles.line}>
            <span style={{ animationDelay: '1.42s' }}>가장 빠른 라켓 스포츠</span>
          </span>
        </h1>
        <div className={styles.buttons}>
          <Button to="/rules" variant="outline" className={styles.startButton}>
            스쿼시 시작하기
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.6" aria-hidden="true">
              <path d="M7 17L17 7M9 7h8v8" />
            </svg>
          </Button>
          <Button to="/score" variant="volt">
            점수 계산기 열기
          </Button>
        </div>
      </div>
    </section>
  )
}

export default HomeHero
