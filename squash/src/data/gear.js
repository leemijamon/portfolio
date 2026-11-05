// 장비 가이드 데이터
// 특정 브랜드 제품이 아니라 '이런 특징의 장비'를 보여주는 예시예요.
// 출처: England Squash 장비 안내, Dunlop 공 규격, r/squash 입문 라켓 가이드

// 필터 버튼 목록 (id: 'all'이면 전체)
export const gearTypes = [
  { id: 'all', label: '전체' },
  { id: 'racket', label: '라켓' },
  { id: 'ball', label: '공' },
  { id: 'shoes', label: '신발' },
  { id: 'goggles', label: '고글' },
]

export const gearLevels = [
  { id: 'all', label: '전체' },
  { id: 'beginner', label: '입문' },
  { id: 'intermediate', label: '중급' },
  { id: 'advanced', label: '상급' },
]

// 공의 점 색깔 (공 그림과 BALL GUIDE에서 함께 써요)
export const dotColors = {
  blue: '#2e8bff',
  red: '#ff5247',
  yellow: '#ffd400',
}

// 장비 목록
// - type / levels: 필터에 쓰는 값 (levels는 여러 개일 수 있어요)
// - recommended: '입문 추천' 표시
// - tone: 카드 그림 배경색 이름 (GearCard.module.scss의 클래스와 같아요)
// - art: 그림 종류 (GearArt 컴포넌트에 넘겨요)
// - specs: 카드와 상세 창의 사양 / highlight: 상세 창 왼쪽에 크게 보이는 값
export const gearItems = [
  {
    id: 'racket-power',
    type: 'racket',
    levels: ['beginner'],
    recommended: true,
    name: '파워형 라켓',
    summary: '무게가 헤드 쪽에 실려 있어 짧게 휘둘러도 공이 앞벽까지 쭉 나가요.',
    tone: 'blue',
    art: { kind: 'racket', variant: 'power' },
    specs: [
      { label: '무게', value: '140~155g' },
      { label: '밸런스', value: '헤드 헤비' },
      { label: '헤드', value: '500cm² 안팎' },
    ],
    highlight: { value: '140~155G', caption: '입문자에게 권하는 135~155g 범위 안이에요' },
    forWho: ['라켓 운동이 처음이라 스윙이 아직 작은 분', '공을 맞히는 것 자체가 어려운 첫 1~2개월'],
    checkpoints: ['무게는 135~155g 사이에서 시작', '헤드가 큰 오벌형이 공 맞히기 쉬워요', '매장이나 클럽의 체험 라켓으로 먼저 쳐 보기'],
  },
  {
    id: 'racket-control',
    type: 'racket',
    levels: ['beginner', 'intermediate'],
    name: '컨트롤형 라켓',
    summary: '무게가 고르게 퍼진 이븐 밸런스라 드롭·보스트 같은 섬세한 샷을 연습하기 좋아요.',
    tone: 'ink',
    art: { kind: 'racket', variant: 'control' },
    specs: [
      { label: '무게', value: '130~145g' },
      { label: '밸런스', value: '이븐' },
      { label: '헤드', value: '500cm² 안팎' },
    ],
    highlight: { value: 'EVEN', caption: '힘과 조작감의 균형이 맞는 밸런스예요' },
    forWho: ['기본 스윙이 잡혀 랠리가 이어지기 시작한 분', '세게 치기보다 정확하게 치는 연습을 하고 싶은 분'],
    checkpoints: ['지금 쓰는 라켓과 무게 차이가 10g 안쪽인지', '그립이 손에 미끄럽지 않은 굵기인지', '헤드 크기가 갑자기 작아지지 않았는지'],
  },
  {
    id: 'racket-speed',
    type: 'racket',
    levels: ['advanced'],
    name: '스피드형 라켓',
    summary: '가볍고 헤드가 가벼워 스윙이 빨라요. 발리 싸움에 유리하지만 힘은 스스로 실어야 해요.',
    tone: 'wall',
    art: { kind: 'racket', variant: 'speed' },
    specs: [
      { label: '무게', value: '115~130g' },
      { label: '밸런스', value: '헤드 라이트' },
      { label: '헤드', value: '470~490cm²' },
    ],
    highlight: { value: '115~130G', caption: '빠른 스윙에 맞춘 가벼운 라켓이에요' },
    forWho: ['스윙 자세가 안정된 동호인', '앞쪽에서 빠른 발리로 승부하는 스타일'],
    checkpoints: ['너무 가벼우면 손목만 쓰는 습관이 생겨요', '기본 스윙이 잡힌 뒤에 바꾸기', '헤드가 작을수록 정확히 맞혀야 해요'],
  },
  {
    id: 'ball-blue',
    type: 'ball',
    levels: ['beginner'],
    recommended: true,
    name: '블루 닷 · 인트로 볼',
    summary: '네 가지 공 중 가장 크고 잘 튀어요. 공이 오래 떠 있어 랠리가 길게 이어져요.',
    tone: 'blueSoft',
    art: { kind: 'ball', dots: ['blue'] },
    specs: [
      { label: '지름', value: '45mm' },
      { label: '체공 시간', value: '프로 볼보다 40%↑' },
      { label: '워밍업', value: '짧게' },
    ],
    highlight: { value: '+40%', caption: '프로 볼보다 공이 40% 더 오래 떠 있어요' },
    forWho: ['첫 레슨, 첫 코트 방문', '랠리가 자꾸 끊겨 재미를 못 느낄 때'],
    checkpoints: ['랠리가 10번 넘게 이어지면 레드 닷으로', '함께 치는 사람과 같은 공 쓰기', '오래 쓰면 덜 튀니 너무 낡으면 바꾸기'],
  },
  {
    id: 'ball-red',
    type: 'ball',
    levels: ['beginner', 'intermediate'],
    name: '레드 닷 · 프로그레스 볼',
    summary: '블루 볼에 익숙해지면 다음 단계예요. 조금 작고 덜 튀어서 랠리가 빨라져요.',
    tone: 'redSoft',
    art: { kind: 'ball', dots: ['red'] },
    specs: [
      { label: '지름', value: '42.5mm' },
      { label: '체공 시간', value: '프로 볼보다 20%↑' },
      { label: '워밍업', value: '보통' },
    ],
    highlight: { value: '+20%', caption: '프로 볼보다 공이 20% 더 오래 떠 있어요' },
    forWho: ['블루 볼로 랠리가 편하게 이어지는 분', '취미로 꾸준히 치는 동호인'],
    checkpoints: ['랠리가 3번을 못 넘기면 블루로 돌아가기', '추운 코트에서는 평소보다 오래 데우기', '파트너와 실력 차가 크면 낮은 쪽에 맞추기'],
  },
  {
    id: 'ball-single',
    type: 'ball',
    levels: ['intermediate'],
    name: '싱글 옐로 · 컴피티션 볼',
    summary: '클럽에서 정기적으로 치는 사람을 위한 공이에요. 프로 볼보다 조금 더 튀어요.',
    tone: 'yellowSoft',
    art: { kind: 'ball', dots: ['yellow'] },
    specs: [
      { label: '지름', value: '40mm' },
      { label: '체공 시간', value: '프로 볼보다 최대 10%↑' },
      { label: '워밍업', value: '충분히' },
    ],
    highlight: { value: '40MM', caption: '프로 볼과 같은 공식 크기예요' },
    forWho: ['클럽 리그나 정기 모임에 나가는 분', '레드 볼이 너무 쉽게 느껴지는 분'],
    checkpoints: ['치기 전에 공을 충분히 데우기', '공이 금방 죽으면 레드로 돌아가기', '실내 온도가 낮으면 더 덜 튀어요'],
  },
  {
    id: 'ball-double',
    type: 'ball',
    levels: ['advanced'],
    name: '더블 옐로 · 프로 볼',
    summary: '대회에서 쓰는 공식 공이에요. 가장 덜 튀어서 충분히 데워야 랠리가 돼요.',
    tone: 'yellowSoft',
    art: { kind: 'ball', dots: ['yellow', 'yellow'] },
    specs: [
      { label: '지름', value: '40mm' },
      { label: '바운스', value: '가장 낮음' },
      { label: '워밍업', value: '오래' },
    ],
    highlight: { value: 'PRO', caption: '대회 공식구로 쓰이는 공이에요' },
    forWho: ['대회에 나가거나 준비하는 분', '실력이 좋은 클럽 상위권 선수'],
    checkpoints: ['경기 전 워밍업으로 공을 충분히 데우기', '입문자와 칠 때는 더 잘 튀는 공으로', '차가운 공은 거의 튀지 않아요'],
  },
  {
    id: 'shoes-court',
    type: 'shoes',
    levels: ['beginner'],
    recommended: true,
    name: '실내 코트화',
    summary: '바닥에 자국이 남지 않는 밑창의 실내용 신발이에요. 나무 코트에서 미끄러지지 않아요.',
    tone: 'wall',
    art: { kind: 'shoe', variant: 'court' },
    specs: [
      { label: '밑창', value: '논마킹 고무' },
      { label: '높이', value: '로우컷' },
      { label: '용도', value: '실내 전용' },
    ],
    highlight: { value: 'NON-MARKING', caption: '논마킹 밑창이 아니면 입장을 막는 구장도 있어요' },
    forWho: ['처음 코트에 가는 모든 분', '배드민턴·탁구용 실내화가 이미 있는 분'],
    checkpoints: ['밑창이 검은 자국을 남기지 않는지', '러닝화는 옆으로 움직일 때 미끄러워요', '밖에서 신지 않고 코트에서만 신기'],
  },
  {
    id: 'shoes-support',
    type: 'shoes',
    levels: ['intermediate', 'advanced'],
    name: '측면 보강 코트화',
    summary: '옆쪽 지지대가 단단해서 좌우로 크게 뻗는 동작이 많은 랠리에서 발을 잡아 줘요.',
    tone: 'blue',
    art: { kind: 'shoe', variant: 'support' },
    specs: [
      { label: '밑창', value: '논마킹 고무' },
      { label: '측면', value: '보강' },
      { label: '쿠션', value: '보통~두꺼움' },
    ],
    highlight: { value: 'SUPPORT', caption: '방향을 바꿀 때 발이 신발 안에서 밀리지 않아요' },
    forWho: ['일주일에 2번 이상 치는 분', '런지 동작이 많아진 분'],
    checkpoints: ['발볼에 맞는 넓이인지 신어 보기', '밑창이 닳아 미끄러우면 바꾸기', '쿠션이 너무 두꺼우면 발 감각이 둔해져요'],
  },
  {
    id: 'goggles',
    type: 'goggles',
    levels: ['beginner', 'intermediate', 'advanced'],
    recommended: true,
    name: '스쿼시 보호 고글',
    summary: '빠른 공과 라켓으로부터 눈을 지켜요. 주니어 대회와 복식 대회에서는 반드시 써야 해요.',
    tone: 'ink',
    art: { kind: 'goggles' },
    specs: [
      { label: '규격', value: 'BS EN ISO 18527-2' },
      { label: '필수', value: '주니어·복식 대회' },
      { label: '연습', value: '착용 강력 권장' },
    ],
    highlight: { value: 'SAFETY', caption: '모든 수준에서 연습할 때도 써 주세요' },
    forWho: ['수준과 상관없이 모든 분', '19세 미만 주니어 선수'],
    checkpoints: ['스쿼시용 규격 표시가 있는지', '일반 안경은 보호구가 아니에요', '안경을 쓰면 위에 쓰는 고글이나 도수 고글로'],
  },
]

// BALL GUIDE: 체공 시간이 길수록 바가 길어요 (프로 볼 대비)
// bar는 그림용 상대 길이(%)예요
export const ballGuide = [
  { name: '블루', dots: ['blue'], badge: '입문 추천', hangTime: '+40%', bar: 100, description: '가장 크고 잘 튀어요. 첫 레슨과 랠리 연습용.' },
  { name: '레드', dots: ['red'], badge: '입문 추천', hangTime: '+20%', bar: 66, description: '블루가 익숙해진 다음 단계예요.' },
  { name: '싱글 옐로', dots: ['yellow'], badge: '중급', hangTime: '최대 +10%', bar: 40, description: '클럽에서 정기적으로 치는 동호인용.' },
  { name: '더블 옐로', dots: ['yellow', 'yellow'], badge: '상급 · 대회', hangTime: '기준', bar: 18, description: '가장 덜 튀는 대회 공식구. 충분히 데워야 해요.' },
]

export const ballTips = [
  { title: '랠리가 3번을 못 넘긴다면', description: '한 단계 더 잘 튀는 공으로 바꿔 보세요. 공이 바닥에서 너무 빨리 죽고 있다는 신호예요.' },
  { title: '추운 코트에선 덜 튀어요', description: '겨울철이나 이른 아침에는 같은 공도 덜 튀어요. 평소보다 오래 데워 주세요.' },
  { title: '함께 치는 사람과 맞추기', description: '실력 차이가 크면 낮은 수준에 맞춘 공을 쓰는 게 둘 다 즐거워요.' },
]

// id로 화면에 보일 이름 찾기 (예: 'racket' → '라켓')
export const getTypeLabel = (id) => gearTypes.find((type) => type.id === id)?.label
export const getLevelLabel = (id) => gearLevels.find((level) => level.id === id)?.label
