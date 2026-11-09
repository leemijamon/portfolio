import { useEffect, useState } from 'react'
import Modal from '../components/Modal'
import ScoreSetup from '../components/score/ScoreSetup'
import ScoreBoard from '../components/score/ScoreBoard'
import GameEnd from '../components/score/GameEnd'
import MatchResult from '../components/score/MatchResult'
import { createMatch, addPoint, startNextGame, toggleSide, getGamesWon } from '../utils/score'
import styles from './ScorePage.module.scss'

const STORAGE_KEY = 'first-rally-score'

const defaultSettings = { players: ['', ''], bestOf: 3, firstServer: 'random' }

// 브라우저에 저장해 둔 경기 불러오기 (없거나 읽을 수 없으면 null)
function loadSaved() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY))
  } catch {
    return null
  }
}

function ScorePage() {
  // useState에 함수를 넘기면 처음 한 번만 실행돼요 (매번 localStorage를 읽지 않게)
  const [saved] = useState(loadSaved)

  // state 1: 경기 설정 (이름, 게임 수, 첫 서브)
  const [settings, setSettings] = useState(saved?.settings ?? defaultSettings)
  // state 2: 진행 중인 경기 (null이면 아직 시작 전 → 설정 화면)
  const [match, setMatch] = useState(saved?.match ?? null)
  // state 3: 되돌리기용 기록. 바뀌기 '전' 경기 상태를 차곡차곡 쌓아 둬요
  const [history, setHistory] = useState(saved?.history ?? [])
  // state 4: 초기화 확인 창
  const [isResetOpen, setIsResetOpen] = useState(false)

  // 세 값 중 하나라도 바뀌면 브라우저에 저장 → 새로고침해도 경기가 이어져요
  useEffect(() => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify({ settings, match, history }))
    } catch {
      // 저장이 막힌 환경(사생활 보호 모드 등)에서는 그냥 넘어가요
    }
  }, [settings, match, history])

  // 경기 상태를 바꿀 때는 항상 이 함수로: 바뀌기 전 상태를 기록에 넣고 → 새 상태로 교체
  const record = (nextMatch, label) => {
    setHistory([...history, { match, label }])
    setMatch(nextMatch)
  }

  const startMatch = () => {
    const players = [settings.players[0].trim() || '선수 A', settings.players[1].trim() || '선수 B']
    // 라켓 스핀: 0 또는 1 무작위
    const firstServer = settings.firstServer === 'random' ? Math.round(Math.random()) : settings.firstServer
    setMatch(createMatch({ players, bestOf: settings.bestOf, firstServer }))
    setHistory([])
  }

  const handleScore = (player) => record(addPoint(match, player), `${match.players[player]} +1`)
  const handleNextGame = () => record(startNextGame(match), `GAME ${match.games.length + 1} 시작`)

  // 되돌리기: 기록의 마지막 상태로 돌아가고, 기록에서는 빼요
  const handleUndo = () => {
    const last = history[history.length - 1]
    if (!last) return
    setMatch(last.match)
    setHistory(history.slice(0, -1))
  }

  const handleReset = () => {
    setMatch(null)
    setHistory([])
    setIsResetOpen(false)
  }

  const lastLabel = history[history.length - 1]?.label

  // 지금 단계에 맞는 화면 고르기
  let screen
  if (!match) {
    screen = <ScoreSetup settings={settings} onChange={setSettings} onStart={startMatch} />
  } else if (match.status === 'matchOver') {
    screen = <MatchResult match={match} onRematch={startMatch} onNewSetup={handleReset} onUndo={handleUndo} />
  } else if (match.status === 'gameOver') {
    screen = <GameEnd match={match} onNext={handleNextGame} onUndo={handleUndo} />
  } else {
    screen = (
      <ScoreBoard
        match={match}
        undoLabel={lastLabel}
        onScore={handleScore}
        onUndo={handleUndo}
        onToggleSide={() => setMatch(toggleSide(match))}
        onReset={() => setIsResetOpen(true)}
      />
    )
  }

  return (
    <div className={styles.page}>
      {screen}

      {isResetOpen && match && (
        <Modal size="sm" labelledBy="reset-title" onClose={() => setIsResetOpen(false)}>
          <div className={styles.confirm}>
            <h2 id="reset-title">경기를 초기화할까요?</h2>
            <p>
              현재 점수 <b>{match.scores.join(' : ')}</b>와 게임 기록 <b>{getGamesWon(match.games).join(' : ')}</b>이 모두
              지워지며 되돌릴 수 없어요.
            </p>
            <p className={styles.confirmTip}>점수를 한 번 잘못 눌렀다면 초기화 대신 ‘되돌리기’를 사용하세요.</p>
            <div className={styles.confirmActions}>
              <button type="button" className={styles.cancel} onClick={() => setIsResetOpen(false)}>
                취소
              </button>
              <button type="button" className={styles.danger} onClick={handleReset}>
                초기화
              </button>
            </div>
          </div>
        </Modal>
      )}
    </div>
  )
}

export default ScorePage
