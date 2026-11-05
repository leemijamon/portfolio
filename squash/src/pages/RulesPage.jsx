import { useState } from 'react'
import PageHeader from '../components/PageHeader'
import Tabs from '../components/Tabs'
import Accordion from '../components/Accordion'
import Button from '../components/Button'
import ServeStepArt from '../components/rules/ServeStepArt'
import { FrontWallDiagram, CourtFloorDiagram } from '../components/rules/CourtDiagram'
import {
  jumpLinks,
  courtLines,
  serveTabs,
  serveSteps,
  serveFaults,
  scoringFlow,
  letCases,
  faqs,
} from '../data/rules'
import styles from './RulesPage.module.scss'

function RulesPage() {
  // state 1: 코트 그림에서 강조할 라인 번호 (처음엔 서비스 라인)
  const [activeLine, setActiveLine] = useState(2)
  // state 2: 서브와 득점 섹션에서 선택된 탭
  const [activeTab, setActiveTab] = useState('serve')

  // 선택된 라인 정보 (그림 아래 요약 문구에 써요)
  const selectedLine = courtLines.find((line) => line.id === activeLine)

  return (
    <>
      <PageHeader
        watermark="RULES"
        crumb="규칙 가이드"
        title="5분이면 이해하는 스쿼시 규칙"
        description="코트 라인 6개, 서브 3단계, 득점 1가지 원칙만 알면 첫 경기를 할 수 있어요."
      >
        <nav aria-label="페이지 안 이동" className={styles.jumpNav}>
          {jumpLinks.map((link) => (
            <a key={link.href} href={link.href} className={styles.jumpLink}>
              {link.label}
            </a>
          ))}
        </nav>
      </PageHeader>

      {/* ===== 01 코트 구조 ===== */}
      <section id="court" className={`container ${styles.court}`}>
        <p className="eyebrow">01 코트 구조</p>
        <div className={styles.sectionHead}>
          <h2 className={styles.sectionTitle}>라인 6개만 기억하세요</h2>
          <p className={styles.hint}>번호를 누르면 그림에서 해당 라인이 강조돼요</p>
        </div>

        <div className={styles.courtGrid}>
          <div className={styles.figures}>
            <figure className={styles.figure}>
              <figcaption className={styles.figCaption}>
                <span>앞벽 FRONT WALL</span>
                <span className={styles.muted}>폭 6.4m</span>
              </figcaption>
              <FrontWallDiagram active={activeLine} />
            </figure>

            <figure className={`${styles.figure} ${styles.floorFigure}`}>
              <div className={styles.floorSvg}>
                <CourtFloorDiagram active={activeLine} />
              </div>
              <figcaption className={styles.floorCaption}>
                <b>바닥 FLOOR · 위에서 본 모습</b>
                <div className={styles.sizes}>
                  <div className={styles.sizeBox}>
                    <span className={`display ${styles.sizeValue}`}>9.75m</span>
                    <span className={styles.muted}>코트 길이</span>
                  </div>
                  <div className={styles.sizeBox}>
                    <span className={`display ${styles.sizeValue}`}>6.40m</span>
                    <span className={styles.muted}>코트 폭</span>
                  </div>
                </div>
                <p className={styles.muted}>
                  옆벽의 아웃 라인은 앞벽 4.57m에서 뒷벽 2.13m까지 비스듬히 내려와요. 라인에 맞아도 아웃이에요.
                </p>
              </figcaption>
            </figure>

            {/* 선택된 라인 요약: aria-live로 화면 낭독기에도 바뀐 내용을 알려 줘요 */}
            <p className={styles.callout} aria-live="polite">
              {selectedLine.id} {selectedLine.name} · {selectedLine.value}
            </p>
          </div>

          <ol className={styles.lineList}>
            {courtLines.map((line) => {
              const isActive = line.id === activeLine
              return (
                <li key={line.id}>
                  <button
                    type="button"
                    aria-pressed={isActive}
                    className={`${styles.lineButton} ${isActive ? styles.lineActive : ''}`}
                    onClick={() => setActiveLine(line.id)}
                  >
                    <span className={styles.lineNumber}>{line.id}</span>
                    <span className={styles.lineText}>
                      <b>{line.name}</b> <span className={styles.lineEn}>{line.en}</span>
                      <span className={styles.lineDesc}>{line.description}</span>
                      {/* 선택됐고 tip이 있을 때만 보여줘요 */}
                      {isActive && line.tip && <span className={styles.lineTip}>{line.tip}</span>}
                    </span>
                  </button>
                </li>
              )
            })}
          </ol>
        </div>
      </section>

      {/* ===== 02 서브와 득점 ===== */}
      <section id="serve" className={styles.serve}>
        <div className="container">
          <p className="eyebrow">02 서브와 득점</p>
          <div className={styles.sectionHead}>
            <h2 className={styles.sectionTitle}>서브는 3단계, 득점은 매 랠리마다</h2>
            <Tabs label="서브와 득점" tabs={serveTabs} activeId={activeTab} onChange={setActiveTab} idPrefix="rules" />
          </div>

          <div
            role="tabpanel"
            id={`rules-panel-${activeTab}`}
            aria-labelledby={`rules-${activeTab}`}
            className={styles.panel}
          >
            {/* 선택된 탭에 맞는 내용만 그려요 (조건부 렌더링) */}
            {activeTab === 'serve' && (
              <>
                <div className={styles.grid3}>
                  {serveSteps.map((step) => (
                    <article key={step.step} className={styles.stepCard}>
                      <div className={styles.stepArt}>
                        <ServeStepArt type={step.art} />
                      </div>
                      <span className={`display ${styles.stepLabel}`}>{step.step}</span>
                      <h3 className={styles.cardTitle}>{step.title}</h3>
                      <p className={styles.cardDesc}>{step.description}</p>
                    </article>
                  ))}
                </div>

                <div className={styles.serveInfo}>
                  <div className={styles.infoCard}>
                    <b className={styles.infoTitle}>서브 순서</b>
                    <p className={styles.cardDesc}>
                      랠리를 이긴 사람이 다음 서브를 넣어요. 서브권을 지키는 동안은 좌우 박스를 번갈아 사용해요.
                    </p>
                    <div className={styles.order}>
                      <span className={styles.boxDark}>R 오른쪽</span>
                      <span className={styles.muted}>→ 득점 →</span>
                      <span className={styles.boxBlue}>L 왼쪽</span>
                      <span className={styles.muted}>→ 득점 →</span>
                      <span className={styles.boxDark}>R</span>
                    </div>
                  </div>
                  <div className={styles.infoCard}>
                    <b className={styles.infoTitle}>이럴 땐 폴트 → 상대 득점</b>
                    <ul className={styles.faults}>
                      {serveFaults.map((fault) => (
                        <li key={fault}>{fault}</li>
                      ))}
                    </ul>
                    <p className={styles.small}>서브 기회는 한 번뿐이에요. 테니스처럼 두 번째 서브가 없어요.</p>
                  </div>
                </div>
              </>
            )}

            {activeTab === 'scoring' && (
              <div className={styles.scoring}>
                <div className={styles.scoringText}>
                  <span className={`display ${styles.scoringLabel}`}>SCORING · PAR 11</span>
                  <h3 className={styles.scoringTitle}>랠리를 이기면 무조건 1점</h3>
                  <p>
                    서브권과 상관없이 매 랠리 득점해요. 11점을 먼저 따면 게임 승리. 보통 3게임 중 2게임, 또는 5게임 중
                    3게임을 먼저 이기면 경기에서 이겨요.
                  </p>
                </div>
                <ol className={styles.flow}>
                  {scoringFlow.map((item) => (
                    <li key={item.score} className={`${styles.flowItem} ${styles[item.tone]}`}>
                      <span className={`display ${styles.flowScore}`}>{item.score}</span>
                      <span className={styles.flowLabel}>{item.label}</span>
                    </li>
                  ))}
                </ol>
              </div>
            )}

            {activeTab === 'let' && (
              <>
                <div className={styles.grid3}>
                  {letCases.map((item) => (
                    <article key={item.en} className={styles.letCard}>
                      <span className={`display ${styles.letEn}`}>{item.en}</span>
                      <h3 className={styles.cardTitle}>
                        {item.call} <span className={styles.letResult}>{item.result}</span>
                      </h3>
                      <p className={styles.cardDesc}>{item.description}</p>
                    </article>
                  ))}
                </div>
                <p className={styles.letNote}>
                  심판이 없는 친선 경기에서는 두 선수가 대화로 정해요. 애매하면 렛으로 다시 하는 게 일반적이에요.
                </p>
              </>
            )}
          </div>
        </div>
      </section>

      {/* ===== 03 헷갈리는 규칙 ===== */}
      <section id="faq" className={`container ${styles.faq}`}>
        <div className={styles.faqIntro}>
          <p className="eyebrow">03 헷갈리는 규칙</p>
          <h2 className={styles.sectionTitle}>
            입문자가 가장
            <br />
            많이 묻는 5가지
          </h2>
          <p className={styles.muted}>항목을 누르면 답이 펼쳐져요.</p>
          <Button to="/score">점수 계산기로 연습하기</Button>
        </div>
        <div className={styles.faqList}>
          <Accordion items={faqs} />
          <p className={styles.source}>출처: World Squash Federation 단식 규칙(2025), England Squash</p>
        </div>
      </section>
    </>
  )
}

export default RulesPage
