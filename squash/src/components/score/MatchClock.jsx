import { useEffect, useState } from 'react'
import { formatDuration } from '../../utils/score'

// 경기 시작부터 흐른 시간 (1초마다 다시 그려요)
function MatchClock({ startedAt }) {
  const [now, setNow] = useState(() => Date.now())

  useEffect(() => {
    // 1초마다 현재 시각을 갱신
    const timerId = setInterval(() => setNow(Date.now()), 1000)
    // 화면에서 사라질 때 타이머 정리 (안 하면 계속 돌아요)
    return () => clearInterval(timerId)
  }, [])

  return <time aria-label="경기 시간">{formatDuration(now - startedAt)}</time>
}

export default MatchClock
