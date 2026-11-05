import HomeHero from '../components/home/HomeHero'
import FeatureCard from '../components/FeatureCard'
import GuideCard from '../components/GuideCard'
import Button from '../components/Button'
import Reveal from '../components/Reveal'
import { features, guides, scorePoints, checklist } from '../data/home'
import styles from './HomePage.module.css'

function HomePage() {
  return (
    <>
      <HomeHero />

      {/* 01 왜 스쿼시일까 */}
      <section className={`container ${styles.why}`}>
        <div className={styles.sectionHead}>
          <div>
            <p className="eyebrow">01 왜 스쿼시일까</p>
            <h2 className={styles.sectionTitle}>
              처음이라도 금방 빠져드는
              <br />
              스쿼시의 매력 3가지
            </h2>
          </div>
          <p className={styles.sectionDesc}>
            공이 벽에 맞고 돌아오니 상대가 없어도 혼자 연습할 수 있고, 랠리가 끊기지 않아 첫날부터 땀이 납니다.
          </p>
        </div>
        <div className={styles.grid3}>
          {features.map((feature, index) => (
            // delay로 카드가 순서대로 하나씩 나타나요
            <Reveal key={feature.id} delay={index * 120}>
              <FeatureCard
                number={feature.number}
                image={feature.image}
                imageAlt={feature.imageAlt}
                title={feature.title}
                description={feature.description}
                highlight={feature.highlight}
              />
            </Reveal>
          ))}
        </div>
      </section>

      

      {/* 03 점수 계산기 소개 */}
      <section className={`container ${styles.scoreWrap}`}>
        <div className={styles.score}>
          <div className={styles.scoreText}>
            <p className={`eyebrow ${styles.eyebrowInk}`}>03 점수 계산기</p>
            <h2 className={styles.sectionTitle}>
              경기 중에도 한 손으로,
              <br />
              점수는 스코어보드에
            </h2>
            <p className={styles.scoreDesc}>
              “지금 몇 대 몇이었지?” “누가 서브였더라?” 처음 경기할 때 가장 헷갈리는 순간을 대신 기억해 드려요.
            </p>
            <ul className={styles.scorePoints}>
              {scorePoints.map((point) => (
                <li key={point}>{point}</li>
              ))}
            </ul>
            <Button to="/score" variant="dark" className={styles.scoreButton}>
              점수 계산기 시작하기
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" aria-hidden="true">
                <path d="M5 12h14M13 6l6 6-6 6" />
              </svg>
            </Button>
          </div>

          {/* 휴대폰 화면 미리보기 (장식) */}
          <div className={styles.phoneArea} aria-hidden="true">
            <div className={styles.phone}>
              <div className={styles.screen}>
                <div className={styles.screenTop}>
                  <span>GAME 2</span>
                  <span>김도윤 1 : 0 이서연</span>
                </div>
                <div className={styles.playerA}>
                  <span className={styles.serveTag}>● 서브 · R</span>
                  <span className={`display ${styles.bigScore}`}>10</span>
                  <span className={styles.playerName}>김도윤</span>
                </div>
                <div className={styles.pointBar}>게임 포인트 · 김도윤</div>
                <div className={styles.playerB}>
                  <span className={`display ${styles.bigScore}`}>7</span>
                  <span className={styles.playerName}>이서연</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 04 첫 코트 체크리스트 (푸터의 '첫 코트 체크리스트' 링크가 여기로 와요) */}
      <section id="checklist" className={`container ${styles.checklist}`}>
        <p className="eyebrow">04 첫 코트 체크리스트</p>
        <h2 className={styles.sectionTitle}>처음 코트에 가기 전, 이것만 챙기세요</h2>
        <ol className={styles.checkList}>
          {checklist.map((item, index) => (
            <li key={item.title} className={styles.checkItem}>
              <span className={`display ${styles.checkNumber}`} aria-hidden="true">
                {String(index + 1).padStart(2, '0')}
              </span>
              <h3>{item.title}</h3>
              <p>{item.description}</p>
            </li>
          ))}
        </ol>
      </section>
    </>
  )
}

export default HomePage
