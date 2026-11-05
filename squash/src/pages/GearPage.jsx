import { useState } from 'react'
import PageHeader from '../components/PageHeader'
import ChipGroup from '../components/ChipGroup'
import Modal from '../components/Modal'
import Button from '../components/Button'
import GearCard from '../components/gear/GearCard'
import GearDetail from '../components/gear/GearDetail'
import { Ball } from '../components/gear/GearArt'
import { gearTypes, gearLevels, gearItems, ballGuide, ballTips, getTypeLabel, getLevelLabel } from '../data/gear'
import styles from './GearPage.module.scss'

function GearPage() {
  // state 1, 2: 필터 (처음엔 둘 다 '전체')
  const [type, setType] = useState('all')
  const [level, setLevel] = useState('all')
  // state 3: 상세 창에 보여줄 장비 id (null이면 창이 닫힌 상태)
  const [selectedId, setSelectedId] = useState(null)

  // 필터 결과는 state로 따로 저장하지 않고, 그릴 때마다 계산해요
  // (type, level이 바뀌면 화면이 다시 그려지면서 자동으로 새로 계산돼요)
  const filteredItems = gearItems.filter((item) => {
    const matchType = type === 'all' || item.type === type
    const matchLevel = level === 'all' || item.levels.includes(level)
    return matchType && matchLevel
  })

  const isFiltered = type !== 'all' || level !== 'all'
  const resetFilters = () => {
    setType('all')
    setLevel('all')
  }

  // 지금 열린 장비가 목록에서 몇 번째인지
  const selectedIndex = filteredItems.findIndex((item) => item.id === selectedId)
  const selectedItem = filteredItems[selectedIndex]

  const closeDetail = () => setSelectedId(null)
  // 다음 장비: 마지막 다음은 처음으로 (% 나머지 연산)
  const showNext = () => {
    const nextIndex = (selectedIndex + 1) % filteredItems.length
    setSelectedId(filteredItems[nextIndex].id)
  }

  return (
    <>
      <PageHeader
        theme="volt"
        watermark="GEAR"
        crumb="장비 가이드"
        title="내 수준에 맞는 첫 장비 고르기"
        description="라켓, 공, 신발, 고글만 있으면 시작할 수 있어요. 종류와 수준으로 걸러 보고, 카드를 눌러 자세한 선택 기준을 확인하세요."
      >
        {/* 배너 오른쪽 장식 공 3개 (블루 · 레드 · 더블 옐로) */}
        <div className={styles.heroBalls} aria-hidden="true">
          <Ball dots={['blue']} />
          <Ball dots={['red']} />
          <Ball dots={['yellow', 'yellow']} />
        </div>
      </PageHeader>

      {/* ===== 필터 + 카드 목록 ===== */}
      <section className={`container ${styles.list}`}>
        <h2 className="sr-only">장비 목록</h2>

        <div className={styles.filters}>
          <ChipGroup label="종류" options={gearTypes} value={type} onChange={setType} />
          <span className={styles.divider} aria-hidden="true" />
          <ChipGroup label="수준" options={gearLevels} value={level} onChange={setLevel} tone="blue" />
        </div>

        {/* 결과 개수: aria-live로 바뀐 개수를 화면 낭독기에도 알려 줘요 */}
        <div className={styles.result}>
          <p aria-live="polite">
            <b>{filteredItems.length}개</b> <span className={styles.muted}>장비</span>
          </p>
          {type !== 'all' && (
            <button type="button" className={`${styles.activeTag} ${styles.tagDark}`} onClick={() => setType('all')}>
              {getTypeLabel(type)} <span aria-hidden="true">✕</span>
              <span className="sr-only"> 필터 해제</span>
            </button>
          )}
          {level !== 'all' && (
            <button type="button" className={`${styles.activeTag} ${styles.tagBlue}`} onClick={() => setLevel('all')}>
              {getLevelLabel(level)} <span aria-hidden="true">✕</span>
              <span className="sr-only"> 필터 해제</span>
            </button>
          )}
          {isFiltered && (
            <button type="button" className={styles.reset} onClick={resetFilters}>
              필터 초기화
            </button>
          )}
        </div>

        {/* 조건부 렌더링: 결과가 있으면 카드, 없으면 안내 */}
        {filteredItems.length > 0 ? (
          <ul className={styles.grid}>
            {filteredItems.map((item) => (
              <li key={item.id}>
                <GearCard item={item} onOpen={setSelectedId} />
              </li>
            ))}
          </ul>
        ) : (
          <div className={styles.empty}>
            <b>조건에 맞는 장비가 없어요</b>
            <p>종류나 수준을 바꿔 보세요.</p>
            <Button variant="dark" size="sm" onClick={resetFilters}>
              필터 초기화
            </Button>
          </div>
        )}

        <p className={styles.note}>
          * 특정 제품이 아니라 고르는 기준을 보여주는 예시예요. 무게·크기는 일반적인 범위예요.
          <br />
          출처: England Squash 장비 안내, Dunlop 공 규격
        </p>
      </section>

      {/* ===== BALL GUIDE ===== */}
      <section className={styles.ballGuide}>
        <div className="container">
          <p className={`eyebrow ${styles.eyebrowVolt}`}>BALL GUIDE</p>
          <div className={styles.ballHead}>
            <h2 className={styles.sectionTitle}>
              공의 점 색깔,
              <br />
              무엇이 다를까?
            </h2>
            <p>
              점 색깔은 공이 얼마나 잘 튀는지를 알려줘요. 잘 튈수록 공이 오래 떠 있어 받기 쉽고, 덜 튈수록 빠른
              승부가 나요.
            </p>
          </div>

          <ul className={styles.balls}>
            {ballGuide.map((ball) => (
              // CSS 변수로 막대 길이를 넘겨요 → SCSS에서 var(--bar)로 써요
              <li key={ball.name} className={styles.ballItem} style={{ '--bar': ball.bar }}>
                <div className={styles.meter} aria-hidden="true">
                  <span className={styles.trail} />
                  <span className={styles.meterBall}>
                    <Ball dots={ball.dots} size="md" />
                  </span>
                </div>
                <span className={styles.smallBall}>
                  <Ball dots={ball.dots} size="sm" />
                </span>
                <div className={styles.ballInfo}>
                  <div className={styles.ballName}>
                    <b>{ball.name}</b>
                    <span className={ball.badge === '입문 추천' ? styles.badgeVolt : styles.badge}>{ball.badge}</span>
                  </div>
                  <span className={styles.bar} aria-hidden="true" />
                  <p className={styles.hangTime}>체공 시간 {ball.hangTime}</p>
                  <p className={styles.ballDesc}>{ball.description}</p>
                </div>
              </li>
            ))}
          </ul>

          <div className={styles.scale} aria-hidden="true">
            <span>더 잘 튐 · 쉬움</span>
            <i />
            <span>덜 튐 · 빠른 승부</span>
          </div>

          <ul className={styles.tips}>
            {ballTips.map((tip) => (
              <li key={tip.title}>
                <b>{tip.title}</b>
                <p>{tip.description}</p>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* 상세 창: 선택된 장비가 있을 때만 그려요 */}
      {selectedItem && (
        <Modal labelledBy="gear-detail-title" onClose={closeDetail}>
          <GearDetail
            item={selectedItem}
            position={selectedIndex + 1}
            total={filteredItems.length}
            onNext={showNext}
            onClose={closeDetail}
          />
        </Modal>
      )}
    </>
  )
}

export default GearPage
