import { useEffect, useRef } from 'react'
import { getGamesWon, getTotalPoints, gamesNeeded, formatDuration, POINTS_TO_WIN } from '../../utils/score'
import styles from './ResultScreens.module.scss'

// 3단계: 경기 결과
function MatchResult({ match, onRematch, onNewSetup, onUndo }) {
  const { players, games, bestOf } = match
  const winnerIndex = games[games.length - 1].winner
  const gamesWon = getGamesWon(games)
  const totals = getTotalPoints(games)
  const minutes = Math.max(1, Math.round((match.endedAt - match.startedAt) / 60000))

  const titleRef = useRef(null)
  useEffect(() => {
    titleRef.current.focus()
  }, [])

  // 게임마다 한마디 메모
  const gameNote = (game, index) => {
    if (index === games.length - 1) return '매치 포인트 성공'
    if (Math.max(...game.scores) > POINTS_TO_WIN) return '듀스'
    return `${players[game.winner]} 승`
  }

  return (
    <div className={`container ${styles.screen}`}>
      <section className={`${styles.hero} ${styles.winnerHero}`}>
        <p className={styles.eyebrow}>MATCH WINNER</p>
        <h1 ref={titleRef} tabIndex={-1} className={styles.title}>
          {players[winnerIndex]}
        </h1>
        <p className={`display ${styles.bigScore}`}>
          {gamesWon[0]} : {gamesWon[1]}
        </p>
        <p className={styles.sub}>
          {bestOf}게임 {gamesNeeded(bestOf)}선승 · vs {players[1 - winnerIndex]}
        </p>
        <dl className={styles.stats}>
          <div>
            <dt>총 득점</dt>
            <dd>
              {totals[0]} : {totals[1]}
            </dd>
          </div>
          <div>
            <dt>경기 시간</dt>
            <dd>{minutes}분</dd>
          </div>
        </dl>
      </section>

      <section className={styles.panel}>
        <h2 className={styles.panelTitle}>게임별 점수</h2>
        <table className={styles.table}>
          <thead>
            <tr>
              <th scope="col">게임</th>
              <th scope="col" className={styles.colA}>
                {players[0]}
              </th>
              <th scope="col">{players[1]}</th>
              <th scope="col">
                <span className="sr-only">메모</span>
              </th>
            </tr>
          </thead>
          <tbody>
            {games.map((game, index) => (
              <tr key={index}>
                <th scope="row" className="display">
                  GAME {index + 1}
                </th>
                <td className={game.winner === 0 ? styles.won : ''}>{game.scores[0]}</td>
                <td className={game.winner === 1 ? styles.won : ''}>{game.scores[1]}</td>
                <td className={styles.note}>{gameNote(game, index)}</td>
              </tr>
            ))}
          </tbody>
        </table>

        <div className={styles.actions}>
          <button type="button" className={styles.primary} onClick={onRematch}>
            같은 선수로 다시 하기
          </button>
          <button type="button" className={styles.secondary} onClick={onNewSetup}>
            새 경기 설정
          </button>
          <button type="button" className={styles.textButton} onClick={onUndo}>
            마지막 득점 되돌리기
          </button>
        </div>
      </section>
    </div>
  )
}

export default MatchResult
