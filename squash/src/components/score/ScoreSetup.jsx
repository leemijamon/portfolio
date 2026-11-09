import Segmented from './Segmented'
import { gamesNeeded } from '../../utils/score'
import styles from './ScoreSetup.module.scss'

// 1단계: 경기 설정
// settings 값은 부모(ScorePage)가 갖고 있고, 바뀔 때마다 onChange로 새 값을 알려 줘요
function ScoreSetup({ settings, onChange, onStart }) {
  const { players, bestOf, firstServer } = settings
  const nameA = players[0] || '선수 A'
  const nameB = players[1] || '선수 B'

  // 바꿀 값만 덮어써서 새 settings 만들기 (예: update({ bestOf: 5 }))
  const update = (changes) => onChange({ ...settings, ...changes })

  const changeName = (index, name) => {
    const next = [...players]
    next[index] = name
    update({ players: next })
  }

  // 선수 순서 바꾸기 (첫 서브로 고른 선수도 함께 따라가요)
  const swapPlayers = () => {
    const swappedServer = firstServer === 'random' ? 'random' : 1 - firstServer
    update({ players: [players[1], players[0]], firstServer: swappedServer })
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    onStart()
  }

  return (
    <div className={`container ${styles.setup}`}>
      <form className={styles.form} onSubmit={handleSubmit}>
        <div>
          <p className={styles.step}>STEP 1 · 경기 설정</p>
          <h1 className={styles.title}>새 경기 설정</h1>
          <p className={styles.lead}>선수 이름과 경기 방식만 정하면 바로 시작할 수 있어요.</p>
        </div>

        <div className={styles.players}>
          {[0, 1].map((index) => (
            <label key={index} className={styles.field}>
              <span className={styles.label}>선수 {index === 0 ? 'A' : 'B'}</span>
              <span className={styles.inputWrap}>
                <span className={`${styles.swatch} ${index === 0 ? styles.swatchA : styles.swatchB}`} aria-hidden="true" />
                <input
                  value={players[index]}
                  onChange={(event) => changeName(index, event.target.value)}
                  placeholder={`선수 ${index === 0 ? 'A' : 'B'}`}
                  maxLength={10}
                  className={`${styles.input} ${index === 0 ? styles.inputA : ''}`}
                />
              </span>
            </label>
          ))}
          <button type="button" aria-label="선수 순서 바꾸기" className={styles.swap} onClick={swapPlayers}>
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" aria-hidden="true">
              <path d="M7 7h12l-3-3M17 17H5l3 3" />
            </svg>
          </button>
        </div>

        <Segmented
          legend="경기 방식"
          value={bestOf}
          onChange={(value) => update({ bestOf: value })}
          options={[
            { value: 3, label: '3게임 2선승', sub: '동호회 추천' },
            { value: 5, label: '5게임 3선승', sub: '공식 경기' },
          ]}
        />

        <div>
          <p className={styles.label}>점수 방식</p>
          <div className={styles.par}>
            <span className={`display ${styles.parName}`}>PAR 11</span>
            <span className={styles.parText}>
              모든 랠리 득점 · 11점 선취 · 10:10부터는 2점 차가 날 때까지 계속
            </span>
          </div>
        </div>

        <Segmented
          legend="첫 서브"
          value={firstServer}
          onChange={(value) => update({ firstServer: value })}
          options={[
            { value: 0, label: nameA },
            { value: 1, label: nameB },
            { value: 'random', label: '라켓 스핀', sub: '시작할 때 무작위' },
          ]}
        />

        <button type="submit" className={styles.start}>
          경기 시작 <span aria-hidden="true">→</span>
        </button>
      </form>

      {/* 오른쪽: 미리보기 + 안내 */}
      <aside className={styles.aside}>
        <div className={styles.preview} aria-hidden="true">
          <div className={styles.previewA}>
            <span>{nameA}</span>
            <b className="display">0</b>
          </div>
          <div className={styles.previewB}>
            <span>{nameB}</span>
            <b className="display">0</b>
          </div>
          <p className={styles.previewCaption}>
            미리보기 · GAME 1 · {bestOf}게임 {gamesNeeded(bestOf)}선승
          </p>
        </div>
        <div className={styles.notes}>
          <b>경기 전 알아두기</b>
          <ul>
            <li>이긴 쪽 화면을 누르면 1점이 올라가요</li>
            <li>서브 선수와 서비스 박스(R/L)를 자동으로 알려줘요</li>
            <li>잘못 눌렀다면 ‘되돌리기’로 직전 득점을 취소해요</li>
            <li>새로고침해도 진행 중인 경기가 이어져요</li>
          </ul>
        </div>
      </aside>
    </div>
  )
}

export default ScoreSetup
