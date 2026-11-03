import Button from '../components/Button'
import FeatureCard from '../components/FeatureCard'
import features from '../data/feature'
import styles from './HomePage.module.css'

// 홈 (2단계에서 피그마 시안대로 히어로·가이드·점수 계산기 소개를 완성해요)
function HomePage() {
  return (
    <>
      <section className={`container ${styles.hero}`}>
        <p className={styles.eyebrow}>SQUASH GUIDE FOR BEGINNERS</p>
        <h1 className={styles.title}>
          벽을 향해 치는,
          <br />
          <em>가장 빠른</em> 라켓 스포츠
        </h1>
        <p className={styles.lead}>처음 라켓을 잡는 사람을 위한 스쿼시 입문 가이드</p>
        <div className={styles.buttons}>
          <Button to="/rules">규칙부터 알아보기</Button>
          <Button to="/score" variant="outline">
            점수 기록하기
          </Button>
        </div>
      </section>

      <section className={`container ${styles.section}`}>
        <p className={styles.label}>/ WHY SQUASH</p>
        <h2 className={styles.sectionTitle}>스쿼시가 매력적인 3가지 이유</h2>
        <div className={styles.featureList}>
          {features.map((feature) => (
            <FeatureCard
              key={feature.id}
              icon={feature.icon}
              title={feature.title}
              description={feature.description}
            />
          ))}
        </div>
      </section>
    </>
  )
}

export default HomePage
