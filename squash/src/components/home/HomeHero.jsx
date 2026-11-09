import Button from '../Button'
import athlete from '../../assets/images/home/squash-human.webp'
import styles from './HomeHero.module.scss'

// 단어별로 나눠요: PC에서는 한 줄, 모바일에서는 두 줄 (글자마다 등장 순서 order를 매겨요)
let order = 0
const words = ['PLAY', 'SQUASH'].map((word) =>
  word.split('').map((letter) => ({ letter, order: order++ })),
)

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
        <div className={styles.skyClip} aria-hidden="true">
          <div className={styles.sky} />
        </div>

        {/* canvas: 헤더 아래 실제 그림 영역. 글자·사진의 위치는 이 안에서 계산해요 */}
        <div className={styles.canvas}>
          <div className={`display ${styles.word}`} aria-hidden="true">
            {words.map((word, wordIndex) => (
              <span key={wordIndex} className={styles.wordLine}>
                {word.map(({ letter, order }) => (
                  // style에 CSS 변수(--i)를 넘겨서 글자마다 등장 시간을 다르게
                  <span key={order} className={styles.letter} style={{ '--i': order }}>
                    {letter}
                  </span>
                ))}
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

          {/*
            같은 사진을 두 장 겹쳐요 (PC)
            - back: 하늘 아래쪽 선에서 잘라 → 뒷발은 선 아래로 가려짐
            - front: 앞발 부분만 잘라서 → 선 아래로 튀어나옴
          */}
          <div className={styles.athlete}>
            <img
              className={`${styles.athleteImg} ${styles.athleteBack}`}
              src={athlete}
              alt="스쿼시 선수가 낮게 런지하며 라켓을 뻗어 공을 받아치는 모습"
              width="1671"
              height="941"
            />
            <img className={`${styles.athleteImg} ${styles.athleteFront}`} src={athlete} alt="" aria-hidden="true" />
          </div>
        </div>
      </div>

      <div className={styles.copy}>
        <h1 className={styles.title}>
          <span className={styles.line}>
            <span style={{ animationDelay: '1.3s' }}>규칙부터 장비까지,</span>
          </span>
          <span className={styles.line}>
            <span style={{ animationDelay: '1.42s' }}>스쿼시 입문은 여기서</span>
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
