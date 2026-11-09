// 점수 계산 규칙만 모아 둔 '순수 함수'들
// - 순수 함수: 같은 값을 넣으면 항상 같은 결과가 나오고, 넘겨받은 값을 직접 바꾸지 않아요
// - 화면(React)과 분리돼 있어서 규칙만 따로 읽고 고치기 쉬워요
// 규칙 출처: World Squash Federation 단식 규칙 (PAR 11)

export const POINTS_TO_WIN = 11 // 11점 먼저
export const WIN_BY = 2 // 10:10부터는 2점 차가 나야 끝나요

// 3게임 → 2게임, 5게임 → 3게임 먼저 이기면 경기 승리
export const gamesNeeded = (bestOf) => Math.ceil(bestOf / 2)

// 상대 선수 번호 (0 ↔ 1)
export const other = (player) => (player === 0 ? 1 : 0)

// 새 경기 만들기
// firstServer: 0 | 1 (첫 서브 선수)
export function createMatch({ players, bestOf, firstServer }) {
  return {
    players, // ['김도윤', '이서연']
    bestOf, // 3 | 5
    scores: [0, 0], // 지금 게임 점수
    games: [], // 끝난 게임 기록 [{ scores: [12, 10], winner: 0 }]
    server: firstServer, // 지금 서브하는 선수
    side: 'R', // 서브 박스 'R'(오른쪽) | 'L'(왼쪽)
    rallies: [], // 지금 게임의 랠리 승자 순서 [0, 1, 1, ...]
    status: 'playing', // 'playing' | 'gameOver' | 'matchOver'
    startedAt: Date.now(),
    endedAt: null,
  }
}

// 게임이 끝났는지: 11점 이상 + 2점 차
export function isGameOver([a, b]) {
  return Math.max(a, b) >= POINTS_TO_WIN && Math.abs(a - b) >= WIN_BY
}

// 끝난 게임 중 각 선수가 이긴 게임 수 → [1, 0]
export function getGamesWon(games) {
  return [0, 1].map((player) => games.filter((game) => game.winner === player).length)
}

// 랠리 1번 = 이긴 선수 1점 (서브권과 상관없이)
export function addPoint(match, player) {
  if (match.status !== 'playing') return match

  const scores = [...match.scores]
  scores[player] += 1

  // 서브: 서버가 이기면 계속 서브하면서 박스만 바꾸고,
  //       리시버가 이기면 서브권이 넘어가요 (새 서버는 박스를 고를 수 있어서 기본값 R)
  const keepsServe = player === match.server
  const server = keepsServe ? match.server : player
  const side = keepsServe ? (match.side === 'R' ? 'L' : 'R') : 'R'

  const next = { ...match, scores, server, side, rallies: [...match.rallies, player] }

  if (!isGameOver(scores)) return next

  // 게임 종료 → 기록 남기기
  const games = [...match.games, { scores, winner: player }]
  const matchOver = getGamesWon(games)[player] >= gamesNeeded(match.bestOf)

  return {
    ...next,
    games,
    status: matchOver ? 'matchOver' : 'gameOver',
    endedAt: matchOver ? Date.now() : null,
  }
}

// 다음 게임 시작: 점수 0:0, 직전 게임을 이긴 선수가 먼저 서브
export function startNextGame(match) {
  const lastGame = match.games[match.games.length - 1]
  return { ...match, scores: [0, 0], server: lastGame.winner, side: 'R', rallies: [], status: 'playing' }
}

// 서브 박스 직접 바꾸기 (새 서버가 왼쪽에서 서브하고 싶을 때)
export function toggleSide(match) {
  return { ...match, side: match.side === 'R' ? 'L' : 'R' }
}

// 지금 상황 안내
// → { type: 'matchPoint' | 'gamePoint' | 'deuce' | null, player, afterDeuce }
export function getSituation(match) {
  const { scores, games, bestOf } = match
  const gamesWon = getGamesWon(games)
  const afterDeuce = Math.min(...scores) >= POINTS_TO_WIN - 1 // 둘 다 10점 이상

  for (const player of [0, 1]) {
    const nextScores = [...scores]
    nextScores[player] += 1
    // 1점만 더 따면 게임이 끝나는 선수 → 게임 포인트
    if (isGameOver(nextScores)) {
      const winsMatch = gamesWon[player] + 1 >= gamesNeeded(bestOf)
      return { type: winsMatch ? 'matchPoint' : 'gamePoint', player, afterDeuce }
    }
  }

  // 둘 다 10점 이상이고 같은 점수 → 듀스
  if (afterDeuce && scores[0] === scores[1]) return { type: 'deuce', player: null, afterDeuce }

  return { type: null, player: null, afterDeuce }
}

// 경기 전체 총 득점 → [31, 28]
export function getTotalPoints(games) {
  return [0, 1].map((player) => games.reduce((sum, game) => sum + game.scores[player], 0))
}

// 밀리초 → '14:32' (분:초)
export function formatDuration(ms) {
  const totalSeconds = Math.max(0, Math.floor(ms / 1000))
  const minutes = Math.floor(totalSeconds / 60)
  const seconds = String(totalSeconds % 60).padStart(2, '0')
  return `${minutes}:${seconds}`
}
