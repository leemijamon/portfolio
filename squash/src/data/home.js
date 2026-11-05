import benefit01 from '../assets/images/home/img_benefit01.png'
import benefit02 from '../assets/images/home/img_benefit02.png'
import benefit03 from '../assets/images/home/img_benefit03.png'

// 홈 화면에 들어가는 내용 데이터
// 화면 코드와 내용을 나눠 두면, 문구만 바꿀 때 이 파일만 고치면 돼요

export const features = [
  {
    id: 'intensity',
    number: '01',
    image: benefit01,
    imageAlt: '낮게 몸을 던져 라켓을 뻗어 공을 받아치는 스쿼시 선수',
    title: '짧은 시간, 확실한 운동량',
    description:
      '쉴 틈 없이 이어지는 랠리 덕분에 한 게임만 해도 숨이 찹니다. 퇴근 후 짧게 즐기는 운동으로 제격이에요.',
  },
  {
    id: 'indoor',
    number: '02',
    image: benefit02,
    imageAlt: '비 오는 창밖과 대비되는, 유리문 너머로 보이는 깨끗한 실내 스쿼시 코트',
    highlight: false, // 가운데 카드만 블루로 강조
    title: '날씨 걱정 없는 실내 스포츠',
    description:
      '비·미세먼지·한파와 상관없이 사계절 내내. 코트 예약과 라켓 하나면 1:1로 바로 시작할 수 있어요.',
  },
  {
    id: 'strategy',
    number: '03',
    image: benefit03,
    imageAlt: '앞벽과 옆벽을 맞고 꺾여 돌아오는 공의 궤적을 따라 라켓을 휘두르는 선수',
    title: '힘보다 각도, 벽이 만드는 전략',
    description:
      '앞벽과 옆벽을 이용해 공을 상대에게서 멀리 보내는 게임. 힘이 약해도 위치와 타이밍으로 이길 수 있어요.',
  },
]

export const guides = [
  {
    id: 'rules',
    to: '/rules',
    visual: 'court',
    title: '규칙 가이드',
    en: 'RULES',
    points: ['코트 라인 6가지 한눈에 보기', '서브 순서와 서비스 박스', 'PAR 11 득점과 듀스'],
    linkLabel: '가이드 보기',
  },
  {
    id: 'gear',
    to: '/gear',
    visual: 'balls',
    title: '장비 가이드',
    en: 'GEAR',
    points: ['라켓·공·신발 수준별 추천', '공의 점 색깔이 뜻하는 것', '처음 살 때 체크포인트'],
    linkLabel: '가이드 보기',
  },
  {
    id: 'shots',
    to: '/glossary',
    visual: 'shots',
    title: '샷 용어 사전',
    en: 'SHOTS',
    points: ['한글·영문 용어 검색', '공의 궤적을 그림으로', '상황별 사용법과 초보자 팁'],
    linkLabel: '사전 열기',
  },
]

export const scorePoints = [
  'PAR 11 · 듀스 자동 판정',
  '서브 선수 · 박스 표시',
  '게임·매치 포인트 알림',
  '직전 득점 되돌리기',
]

export const checklist = [
  {
    title: '실내 코트화',
    description: '바닥에 자국이 남지 않는 논마킹 밑창의 실내화를 신어요. 러닝화는 옆으로 미끄러지기 쉬워요.',
  },
  {
    title: '보호 고글',
    description: '작고 빠른 공이 눈 높이로 날아와요. 입문자일수록 고글 착용을 권해요.',
  },
  {
    title: '블루·레드 볼',
    description: '잘 튀고 오래 떠 있는 공으로 시작하면 랠리가 길게 이어져 훨씬 재미있어요.',
  },
  {
    title: '공 데우기',
    description: '스쿼시공은 따뜻해져야 잘 튀어요. 시작 전 몇 분간 번갈아 치며 공을 데워요.',
  },
]
