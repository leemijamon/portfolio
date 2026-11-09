import { useEffect, useRef } from 'react'
import BreakTimer from './BreakTimer'
import { getGamesWon, POINTS_TO_WIN } from '../../utils/score'
import styles from './ResultScreens.module.scss'

// 게임 하나가 끝났을 때 (경기는 아직 진행 중)
function GameEnd({ match, onNext, onUndo }) {
  const { players, games } = match
  const lastGame = games[games.length - 1]
  const winner = players[lastGame.winner]
  const gamesWon = getGamesWon(games)
  // 11점을 넘겨서 끝났다면 = 10:10 듀스를 거친 게임
  const wasDeuce = Math.max(...lastGame.scores) > POINTS_TO_WIN

  // 화면이 바뀌면 제목으로 포커스를 옮겨, 화면 낭독기가 결과를 바로 읽게 해요
  const titleRef = useRef(null)
  useEffect(() => {
    titleRef.current.focus()
  }, [])

  return (
    <div className={`container ${styles.screen}`}>
      <section className={styles.hero}>
        <p className={styles.eyebrow}>GAME {games.length} 종료</p>
        {wasDeuce && <p className={styles.sub}>듀스 접전 끝에</p>}
        <h1 ref={titleRef} tabIndex={-1} className={styles.title}>
          {winner} 승리
        </h1>
        <p className={`display ${styles.bigScore}`}>
          {lastGame.scores[0]} : {lastGame.scores[1]}
        </p>
      </section>

      <section className={styles.panel}>
        <p className={styles.gameScore}>
          <span>게임 스코어</span>
          <b>
            {players[0]} <span className="display">{gamesWon[0]} : {gamesWon[1]}</span> {players[1]}
          </b>
        </p>
        <BreakTimer className={styles.break} />
        <p className={styles.small}>다음 게임은 이긴 {winner} 선수가 원하는 박스에서 먼저 서브해요.</p>

        <div className={styles.actions}>
          <button type="button" className={styles.primary} onClick={onNext}>
            GAME {games.length + 1} 시작 <span aria-hidden="true">→</span>
          </button>
          <button type="button" className={styles.textButton} onClick={onUndo}>
            마지막 득점 되돌리기
          </button>
        </div>
      </section>
    </div>
  )
}

export default GameEnd
