import { useEffect, useState } from 'react'
import { formatDuration } from '../../utils/score'

const BREAK_SECONDS = 90 // 게임 사이 휴식은 최대 90초

// 게임 사이 휴식 카운트다운
function BreakTimer({ className }) {
  const [secondsLeft, setSecondsLeft] = useState(BREAK_SECONDS)

  useEffect(() => {
    const timerId = setInterval(() => {
      // 이전 값을 받아 1씩 줄여요 (0 밑으로는 안 내려가요)
      setSecondsLeft((prev) => Math.max(prev - 1, 0))
    }, 1000)
    return () => clearInterval(timerId)
  }, [])

  return (
    <span className={className}>
      <span className="display">{formatDuration(secondsLeft * 1000)}</span>
      {secondsLeft > 0 ? '게임 사이 휴식 (최대 90초)' : '휴식 끝! 다음 게임을 시작하세요'}
    </span>
  )
}

export default BreakTimer
