import { Link, useLocation, useParams } from 'react-router-dom'
import Button from '../components/Button'
import ShotDiagram from '../components/shots/ShotDiagram'
import LevelDots from '../components/shots/LevelDots'
import { shots, getShot, getCategoryLabel } from '../data/shots'
import styles from './GlossaryDetailPage.module.scss'

function GlossaryDetailPage() {
  // 주소 /glossary/boast 에서 :id 자리의 'boast'를 꺼내요
  const { id } = useParams()
  // 목록에서 Link의 state로 넘겨 준 '돌아갈 검색어' (예: '?q=드롭')
  const { state } = useLocation()
  const from = state?.from ?? ''
  const backTo = `/glossary${from}`

  const shot = getShot(id)

  // 없는 용어 주소로 들어온 경우 (예: /glossary/abc)
  if (!shot) {
    return (
      <section className={`container ${styles.notFound}`}>
        <p className="eyebrow">NOT FOUND</p>
        <h1>‘{id}’ 용어를 찾을 수 없어요</h1>
        <p>주소가 바뀌었거나 아직 사전에 없는 용어예요.</p>
        <Button to="/glossary" variant="dark">
          샷 용어 사전으로
        </Button>
      </section>
    )
  }

  // 목록 순서에서 앞뒤 용어 (처음/마지막이면 undefined → 버튼을 안 그려요)
  const index = shots.indexOf(shot)
  const prev = shots[index - 1]
  const next = shots[index + 1]
  const relatedShots = shot.related.map(getShot)

  return (
    <>
      {/* ===== 상단: 이름과 뜻 + 궤적 그림 ===== */}
      <section className={`container ${styles.hero}`}>
        <div className={styles.topBar}>
          <Link to={backTo} className={styles.back}>
            <span aria-hidden="true">←</span> {from ? '검색 결과로' : '샷 용어 사전'}
          </Link>
          <p className={styles.breadcrumb}>
            샷 용어 사전 / {getCategoryLabel(shot.category)} / <b>{shot.name}</b>
          </p>
        </div>

        <div className={styles.heroGrid}>
          <div className={styles.intro}>
            <div className={styles.tags}>
              <span className={styles.tag}>{getCategoryLabel(shot.category)}</span>
              {shot.basic && <span className={`${styles.tag} ${styles.tagVolt}`}>기본 샷</span>}
            </div>
            <div className={styles.nameRow}>
              <h1 className={styles.name}>{shot.name}</h1>
              <span className={`display ${styles.en}`} lang="en">
                {shot.en}
              </span>
            </div>
            <p className={styles.definition}>
              {shot.definition.before}
              <mark>{shot.definition.mark}</mark>
              {shot.definition.after}
            </p>
            <dl className={styles.meta}>
              <div>
                <dt>난이도</dt>
                <dd>
                  <LevelDots level={shot.level} showText />
                </dd>
              </div>
              <div>
                <dt>주로 치는 위치</dt>
                <dd>{shot.where}</dd>
              </div>
              {shot.kinds && (
                <div>
                  <dt>종류</dt>
                  <dd>{shot.kinds}</dd>
                </div>
              )}
            </dl>
          </div>

          <figure className={styles.figure}>
            <div className={styles.figureArt}>
              <ShotDiagram diagram={shot.diagram} label={`${shot.name}의 공 궤적을 위에서 본 그림`} />
            </div>
            <figcaption className={styles.steps}>
              <span className={`display ${styles.stepsLabel}`}>BALL PATH</span>
              <ol>
                {shot.path.map((step, stepIndex) => (
                  <li key={step.title}>
                    <span className={styles.stepNumber}>{stepIndex + 1}</span>
                    <span>
                      <b>{step.title}</b>
                      <span>{step.description}</span>
                    </span>
                  </li>
                ))}
              </ol>
            </figcaption>
          </figure>
        </div>
      </section>

      {/* ===== 언제 쓰나 + 팁 + 실수 ===== */}
      <section className={styles.usage}>
        <div className="container">
          <p className="eyebrow">WHEN TO USE</p>
          <h2 className={styles.sectionTitle}>{shot.name}, 이럴 때 써요</h2>
          <div className={styles.useGrid}>
            {shot.uses.map((use, useIndex) => (
              <article key={use.title} className={styles.useCard}>
                <span className={`display ${styles.useNumber}`}>{String(useIndex + 1).padStart(2, '0')}</span>
                <h3>{use.title}</h3>
                <p>{use.description}</p>
              </article>
            ))}
          </div>

          <div className={styles.tipGrid}>
            <div className={styles.tips}>
              <p className={`eyebrow ${styles.eyebrowVolt}`}>BEGINNER TIPS</p>
              <h3>초보자 팁 {shot.tips.length}가지</h3>
              <ol>
                {shot.tips.map((tip) => (
                  <li key={tip.title}>
                    <b>{tip.title}</b>
                    <p>{tip.description}</p>
                  </li>
                ))}
              </ol>
            </div>
            <div className={styles.mistakes}>
              <p className="eyebrow">자주 하는 실수</p>
              <ul>
                {shot.mistakes.map((mistake) => (
                  <li key={mistake}>{mistake}</li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* ===== 함께 알아두면 좋은 용어 + 이전/다음 ===== */}
      <section className={`container ${styles.more}`}>
        <h2 className={styles.moreTitle}>함께 알아두면 좋은 용어</h2>
        <div className={styles.moreGrid}>
          {relatedShots.map((item) => (
            <Link key={item.id} to={`/glossary/${item.id}`} state={{ from }} className={styles.relatedCard}>
              <span className={`display ${styles.relatedEn}`} lang="en">
                {item.en}
              </span>
              <b>{item.name}</b>
              <span className={styles.relatedSummary}>{item.summary}</span>
            </Link>
          ))}

          <nav aria-label="이전·다음 용어" className={styles.pager}>
            {prev && (
              <Link to={`/glossary/${prev.id}`} state={{ from }} className={styles.prev}>
                <span>이전</span>
                <b>← {prev.name}</b>
              </Link>
            )}
            {next && (
              <Link to={`/glossary/${next.id}`} state={{ from }} className={styles.next}>
                <span>다음</span>
                <b>{next.name} →</b>
              </Link>
            )}
          </nav>
        </div>
      </section>
    </>
  )
}

export default GlossaryDetailPage
