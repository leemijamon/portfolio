import MatchClock from './MatchClock'
import { getGamesWon, gamesNeeded, getSituation } from '../../utils/score'
import styles from './ScoreBoard.module.scss'

// 2단계: 경기 진행 화면
// - onScore(player): 이긴 쪽 버튼을 누르면 부모에게 알려요
// - undoLabel: 되돌릴 동작 이름 (없으면 되돌리기 버튼 비활성화)
function ScoreBoard({ match, undoLabel, onScore, onUndo, onToggleSide, onReset }) {
  const { players, scores, server, side, bestOf, games, rallies } = match
  const gamesWon = getGamesWon(games)
  const need = gamesNeeded(bestOf)
  const gameNumber = games.length + 1
  const isFinalGame = gamesWon[0] === need - 1 && gamesWon[1] === need - 1
  const situation = getSituation(match)

  // 상단 안내 문구 (상황마다 다른 색과 내용)
  const notices = {
    matchPoint: { tag: 'MATCH POINT', text: `${players[situation.player]} · 1점이면 경기 승리` },
    gamePoint: {
      tag: 'GAME POINT',
      text: `${players[situation.player]} · 1점이면 게임 승리${situation.afterDeuce ? ' (듀스 이후 1점 앞섬)' : ''}`,
    },
    deuce: { tag: 'DEUCE', text: '듀스 · 2점 차가 나야 게임이 끝나요' },
  }
  const notice = notices[situation.type] ?? { tag: 'PAR 11', text: '랠리 포인트 · 11점 먼저 따면 승리' }

  // 최근 랠리 6개 (이긴 선수 이름 첫 글자)
  const recentRallies = rallies.slice(-6)

  return (
    <div className={styles.board}>
      <div className={`container ${styles.top}`}>
        <p className={styles.game}>
          <b className="display">GAME {gameNumber}</b>
          <span>{isFinalGame ? '결승 게임' : `${bestOf}게임 ${need}선승 · PAR 11`}</span>
        </p>
        <p className={styles.gameScore} aria-label={`게임 스코어 ${players[0]} ${gamesWon[0]} 대 ${players[1]} ${gamesWon[1]}`}>
          <span className={styles.nameA}>{players[0]}</span>
          <b className="display">
            {gamesWon[0]} : {gamesWon[1]}
          </b>
          <span>{players[1]}</span>
        </p>
        <p className={styles.clock}>
          <MatchClock startedAt={match.startedAt} />
        </p>
      </div>

      {/* role="status": 바뀐 안내를 화면 낭독기가 읽어 줘요 */}
      <div className="container">
        <p role="status" className={`${styles.notice} ${styles[situation.type] ?? ''}`}>
          <span className="display">{notice.tag}</span>
          {notice.text}
        </p>
      </div>

      <div className={`container ${styles.courts}`}>
        {[0, 1].map((player) => {
          const isServer = player === server
          const isPoint = situation.player === player
          let hint = '눌러서 +1'
          if (isPoint) hint = situation.type === 'matchPoint' ? '누르면 경기 승리' : '누르면 게임 승리'

          return (
            <button
              key={player}
              type="button"
              className={`${styles.player} ${player === 0 ? styles.playerA : styles.playerB} ${isPoint ? styles.onPoint : ''}`}
              aria-label={`${players[player]} 득점, 현재 ${scores[player]}점${isServer ? ', 서브 중' : ''}`}
              onClick={() => onScore(player)}
            >
              <span className={styles.playerHead}>
                <b>{players[player]}</b>
                <span className={isServer ? styles.serve : styles.receive}>
                  {isServer ? `서브 · ${side === 'R' ? '오른쪽(R)' : '왼쪽(L)'} 박스` : '리시브'}
                </span>
              </span>
              {/* key가 바뀌면 새로 그려져서 숫자가 바뀔 때마다 애니메이션이 다시 돌아요 */}
              <span key={scores[player]} className={`display ${styles.score}`}>
                {scores[player]}
              </span>
              <span className={styles.hint}>{hint}</span>
            </button>
          )
        })}
      </div>

      <div className={`container ${styles.tools}`}>
        <button type="button" className={styles.tool} onClick={onUndo} disabled={!undoLabel}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" aria-hidden="true">
            <path d="M9 14L4 9l5-5" />
            <path d="M4 9h10a6 6 0 010 12h-3" />
          </svg>
          되돌리기
          {undoLabel && <span className={styles.toolSub}>{undoLabel}</span>}
        </button>
        <button type="button" className={styles.tool} onClick={onToggleSide}>
          서브 박스 바꾸기
        </button>

        {recentRallies.length > 0 && (
          <p className={styles.recent}>
            <span>최근 랠리</span>
            {recentRallies.map((winner, index) => (
              <i key={index} className={winner === 0 ? styles.dotA : styles.dotB}>
                {players[winner].slice(0, 1)}
              </i>
            ))}
          </p>
        )}

        <button type="button" className={`${styles.tool} ${styles.reset}`} onClick={onReset}>
          초기화
        </button>
      </div>
    </div>
  )
}

export default ScoreBoard
