// 규칙 가이드 내용 데이터
// 출처: WSF Rules of Singles Squash 2025, WSF Court Specifications, England Squash

// 페이지 안 이동 링크
export const jumpLinks = [
  { href: '#court', label: '01 코트 구조' },
  { href: '#serve', label: '02 서브와 득점' },
  { href: '#faq', label: '03 헷갈리는 규칙' },
]

// 01 코트 라인 6가지 (where: 'wall' 앞벽 그림 / 'floor' 바닥 그림)
export const courtLines = [
  {
    id: 1,
    where: 'wall',
    name: '아웃 라인',
    en: 'Out line',
    value: '높이 4.57m',
    description: '앞벽 4.57m. 공이 이 선에 닿거나 넘어가면 아웃이에요.',
  },
  {
    id: 2,
    where: 'wall',
    name: '서비스 라인',
    en: 'Service line',
    value: '높이 1.78m',
    description: '앞벽 1.78m. 서브한 공은 반드시 이 선보다 위, 아웃 라인보다 아래에 맞아야 해요.',
    tip: 'TIP · 랠리 중에는 이 선 아래로 쳐도 괜찮아요',
  },
  {
    id: 3,
    where: 'wall',
    name: '틴',
    en: 'Tin',
    value: '높이 0.48m',
    description: '앞벽 맨 아래 0.48m 높이의 판. 공이 맞으면 친 사람이 실점해요.',
  },
  {
    id: 4,
    where: 'floor',
    name: '쇼트 라인',
    en: 'Short line',
    value: '뒷벽에서 4.26m',
    description: '코트를 앞뒤로 나누는 선이에요. 서브한 공은 이 선 뒤쪽에 떨어져야 해요.',
  },
  {
    id: 5,
    where: 'floor',
    name: '하프 코트 라인',
    en: 'Half-court line',
    value: '뒤쪽 좌우 구분',
    description: '코트 뒤쪽을 좌우로 나눠요. 서브는 대각선 반대편 칸에 떨어져야 해요.',
  },
  {
    id: 6,
    where: 'floor',
    name: '서비스 박스',
    en: 'Service box',
    value: '1.6m 정사각형',
    description: '서브할 때 한 발은 반드시 이 박스 안 바닥에 닿아 있어야 해요.',
  },
]

// 02 탭 목록
export const serveTabs = [
  { id: 'serve', label: '서브' },
  { id: 'scoring', label: '득점 방식' },
  { id: 'let', label: '렛 & 스트로크' },
]

export const serveSteps = [
  {
    art: 'box',
    step: 'STEP 01',
    title: '서비스 박스에 한 발',
    description: '한 발은 박스 안 바닥에 붙어 있어야 해요. 라인을 밟으면 폴트예요.',
  },
  {
    art: 'wall',
    step: 'STEP 02',
    title: '서비스 라인 위, 아웃 라인 아래',
    description: '공은 앞벽의 초록색 구간에 바로 맞아야 해요. 옆벽에 먼저 맞으면 안 돼요.',
  },
  {
    art: 'diagonal',
    step: 'STEP 03',
    title: '대각선 뒤쪽 칸에 떨어지게',
    description: '쇼트 라인 뒤, 반대편 칸에 떨어져야 해요. 상대가 바운드 전에 발리로 받으면 그대로 인플레이예요.',
  },
]

export const serveFaults = [
  '서비스 라인 아래나 아웃 라인 위에 맞음',
  '앞벽보다 옆벽에 먼저 맞음',
  '쇼트 라인 앞이나 라인 위에 떨어짐',
  '발이 박스 밖에 있거나 라인을 밟음',
  '치기 전에 공을 바닥이나 벽에 떨어뜨림',
]

// 득점 흐름: 10:10 → 11:10 → 12:10
export const scoringFlow = [
  { score: '10 : 10', label: '듀스 · 2점 차가 나야 끝나요', tone: 'deuce' },
  { score: '11 : 10', label: '1점 앞섬 · 게임 포인트', tone: 'point' },
  { score: '12 : 10', label: '2점 차 · 게임 승리', tone: 'win' },
]

export const letCases = [
  {
    call: '렛',
    en: 'LET',
    result: '다시 하기',
    description:
      '상대에게 방해를 받았지만, 방해가 없었어도 공을 잘 받아쳤을지 분명하지 않을 때예요. 점수 변화 없이 같은 서버가 같은 박스에서 다시 서브해요.',
  },
  {
    call: '스트로크',
    en: 'STROKE',
    result: '방해받은 선수 득점',
    description:
      '상대가 길을 비켜 주지 않았거나, 방해가 없었다면 위닝샷이 될 수 있었을 때예요. 방해받은 선수가 1점을 얻어요.',
  },
  {
    call: '노 렛',
    en: 'NO LET',
    result: '랠리 결과 그대로',
    description: '방해가 거의 없었거나, 방해가 없었어도 어차피 받을 수 없던 공이면 다시 하지 않아요.',
  },
]

// 03 자주 묻는 질문
export const faqs = [
  {
    id: 'tin',
    question: '공이 틴(Tin)에 맞으면 어떻게 되나요?',
    answer:
      '틴에 맞은 공은 친 사람의 실점이에요. 그 랠리는 상대의 득점이 되고, 다음 서브도 상대가 넣어요. 낮게 깔아 치는 공일수록 틴에 맞기 쉬우니 처음에는 서비스 라인 근처를 목표로 쳐 보세요.',
    note: '틴은 공이 맞으면 소리가 나도록 만들어져 있어서 바로 알 수 있어요.',
  },
  {
    id: 'let',
    question: '상대가 길을 막으면? 렛(Let)과 스트로크(Stroke)',
    answer:
      '공을 치러 가는 길을 상대가 막았다면 랠리를 멈추고 렛을 요청할 수 있어요. 방해 정도에 따라 렛(다시 하기)이나 스트로크(내 득점)가 돼요. 공을 치다가 상대를 맞힐 것 같으면 무리하지 말고 멈추세요. 이것도 렛을 요청할 수 있는 상황이에요.',
  },
  {
    id: 'serve-chance',
    question: '서브 기회는 몇 번인가요?',
    answer: '한 번뿐이에요. 테니스처럼 두 번째 서브가 없어서, 서브가 폴트가 되면 바로 상대가 1점을 얻고 서브권도 넘어가요.',
  },
  {
    id: 'bounce',
    question: '공이 바닥에 두 번 튀면 실점인가요?',
    answer:
      '네. 공이 바닥에 두 번 튀기 전에 앞벽으로 돌려보내야 해요. 바닥에 한 번 튄 뒤에 치거나, 튀기 전에 바로(발리) 쳐도 괜찮아요.',
  },
  {
    id: 'break',
    question: '게임과 게임 사이에 얼마나 쉬나요?',
    answer: '게임 사이에는 최대 90초 쉴 수 있어요. 경기 시작 전에는 최대 4분 동안 번갈아 공을 치며 몸을 풀고 공을 데워요.',
  },
]
