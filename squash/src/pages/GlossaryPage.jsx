import { useRef, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import PageHeader from '../components/PageHeader'
import ChipGroup from '../components/ChipGroup'
import Button from '../components/Button'
import ShotCard from '../components/shots/ShotCard'
import { shots, shotCategories, popularIds, getShot } from '../data/shots'
import { matchShot } from '../utils/search'
import styles from './GlossaryPage.module.scss'

function GlossaryPage() {
  // 주소의 ?q=드롭 부분을 읽고 쓰는 도구 (새로고침하거나 상세에서 돌아와도 검색어가 남아요)
  const [searchParams, setSearchParams] = useSearchParams()
  // state 1: 입력창 글자 (처음 값은 주소의 q에서 가져와요)
  const [query, setQuery] = useState(searchParams.get('q') ?? '')
  // state 2: 선택한 분류
  const [category, setCategory] = useState('all')

  const inputRef = useRef(null)
  const resultsRef = useRef(null)

  // 글자를 입력할 때마다: 입력값 저장 + 분류는 '전체'로 + 주소에도 반영
  const changeQuery = (value) => {
    setQuery(value)
    setCategory('all')
    // replace: 글자마다 방문 기록이 쌓이지 않게 현재 기록을 바꿔치기해요
    setSearchParams(value ? { q: value } : {}, { replace: true })
  }

  const clearQuery = () => {
    changeQuery('')
    inputRef.current.focus()
  }

  // 검색 버튼(또는 엔터): 결과는 이미 바뀌어 있으니, 키보드를 닫고 결과로 이동만 해요
  const handleSubmit = (event) => {
    event.preventDefault() // 폼 제출 시 페이지가 새로고침되는 기본 동작 막기
    inputRef.current.blur()
    resultsRef.current.scrollIntoView({ behavior: 'smooth' })
  }

  // ① 검색어로 거르고 → ② 분류로 한 번 더 걸러요
  const searchResults = shots.filter((shot) => matchShot(shot, query))
  const visibleShots = category === 'all' ? searchResults : searchResults.filter((shot) => shot.category === category)

  // 분류 버튼에 개수 붙이기 (결과가 0개인 분류는 버튼을 숨겨요)
  const categoryOptions = shotCategories
    .map((item) => {
      const count =
        item.id === 'all' ? searchResults.length : searchResults.filter((shot) => shot.category === item.id).length
      return { id: item.id, label: `${item.label} ${count}`, count }
    })
    .filter((item) => item.id === 'all' || item.count > 0)

  const keyword = query.trim()
  // 상세 페이지에 넘겨 줄 '돌아올 주소' (예: '?q=드롭')
  const from = keyword ? `?${searchParams.toString()}` : ''
  const basicShots = shots.filter((shot) => shot.basic)

  return (
    <>
      <PageHeader
        theme="ink"
        watermark="SHOTS"
        crumb="샷 용어 사전"
        title="코치가 말한 그 샷, 뭐였지?"
        description="한글이나 영어로 검색하면 뜻, 쓰는 상황, 초보자 팁을 그림과 함께 알려드려요."
      >
        <form role="search" className={styles.search} onSubmit={handleSubmit}>
          <label className={styles.field}>
            <span className="sr-only">샷 용어 검색</span>
            <svg className={styles.searchIcon} width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" aria-hidden="true">
              <circle cx="11" cy="11" r="6.5" />
              <path d="M16 16l4.5 4.5" />
            </svg>
            <input
              ref={inputRef}
              type="search"
              value={query}
              onChange={(event) => changeQuery(event.target.value)}
              placeholder="예) 보스트, Boast, 드롭"
              autoComplete="off"
              className={styles.input}
            />
            {/* 글자가 있을 때만 지우기 버튼 */}
            {query && (
              <button type="button" aria-label="검색어 지우기" className={styles.clear} onClick={clearQuery}>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" aria-hidden="true">
                  <path d="M6 6l12 12M18 6L6 18" />
                </svg>
              </button>
            )}
          </label>
          <button type="submit" className={styles.submit}>
            검색
          </button>
        </form>

        <div className={styles.popular}>
          <span>많이 찾는 용어</span>
          {popularIds.map((id) => (
            <Link key={id} to={`/glossary/${id}`} className={styles.popularLink}>
              {getShot(id).name}
            </Link>
          ))}
        </div>
      </PageHeader>

      {/* ===== 검색 결과 ===== */}
      <section id="results" ref={resultsRef} className={`container ${styles.results}`}>
        <div className={styles.resultHead}>
          <h2 className={styles.resultTitle} aria-live="polite">
            {keyword ? `‘${keyword}’ 검색 결과` : '전체 용어'} <span>{searchResults.length}개</span>
          </h2>
          {searchResults.length > 0 && (
            <ChipGroup label="분류" options={categoryOptions} value={category} onChange={setCategory} />
          )}
        </div>

        {/* 조건부 렌더링: 결과가 있으면 카드 목록, 없으면 안내 */}
        {searchResults.length > 0 ? (
          <ul className={styles.resultGrid}>
            {visibleShots.map((shot) => (
              <li key={shot.id}>
                <ShotCard shot={shot} query={keyword} from={from} />
              </li>
            ))}
          </ul>
        ) : (
          <div className={styles.empty}>
            {/* 앞벽 + 물음표 공 그림 */}
            <div className={styles.emptyArt} aria-hidden="true">
              <span className={styles.emptyWall} />
              <span className={styles.emptyBall}>?</span>
            </div>
            <p className={styles.emptyTitle}>‘{keyword}’ 검색 결과가 없어요</p>
            <p className={styles.emptyText}>
              철자를 확인하거나 영어로 검색해 보세요. 예) 보스트 → Boast
            </p>
            <div className={styles.suggest}>
              <b>이런 용어를 찾으셨나요?</b>
              <div>
                {popularIds.slice(0, 4).map((id) => {
                  const shot = getShot(id)
                  return (
                    <Link key={id} to={`/glossary/${id}`} className={styles.suggestLink}>
                      {shot.name} <span className="display">{shot.en}</span>
                    </Link>
                  )
                })}
              </div>
            </div>
            <Button variant="dark" size="sm" onClick={clearQuery}>
              검색어 지우고 전체 보기
            </Button>
          </div>
        )}
      </section>

      {/* ===== 기본 샷 8 ===== */}
      <section className={`container ${styles.basic}`}>
        <div className={styles.basicHead}>
          <div>
            <p className="eyebrow">BASIC SHOTS</p>
            <h2 className={styles.sectionTitle}>입문자가 먼저 알아야 할 기본 샷 {basicShots.length}</h2>
          </div>
          <p className={styles.legend}>
            <span className={styles.legendPlayer} /> 치는 사람
            <span className={styles.legendPath} /> 공의 궤적
            <span className={styles.legendWall} /> 앞벽
          </p>
        </div>
        <ul className={styles.basicGrid}>
          {basicShots.map((shot) => (
            <li key={shot.id}>
              <ShotCard shot={shot} variant="tile" />
            </li>
          ))}
        </ul>
        <p className={styles.source}>참고: squashclub.org 입문 레슨, England Squash</p>
      </section>
    </>
  )
}

export default GlossaryPage
