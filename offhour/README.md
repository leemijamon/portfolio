# OFF HOUR V3 — Retro Pop Edition (Portfolio Concept)

클룹 오프아워 탄산음료를 주제로 한 **웹 퍼블리셔 포트폴리오용 비공식 브랜드 랜딩 페이지**입니다.
카피는 창작 문구이며 CLOOP의 공식 광고 문구가 아닙니다.

## 콘셉트
캔 패키지의 금색 레트로 레터링과 코랄·라임·핑크 컬러에서 출발한 **70년대 소다 광고 × 팝아트** 무드.
선버스트, 하프톤 도트, 물결 띠, 굵은 외곽선 + 오프셋 그림자(스티커 느낌)를 디자인 시스템으로 통일했습니다.

## 섹션
| 섹션 | 포인트 |
|---|---|
| Hero | 캔 클릭 → 가운데로 이동 + 맛별 배경·선버스트·강조색 전환(`@property` 색 보간), 유리 기포 + 탄산 줄기 |
| 01 What is Off Hour? | 워홀식 3단 아치 패널, 핵심 정보 4종 원형 스티커 |
| 02 Ingredients | 버건디 + 회전 선버스트, 성분 카드 2종 |
| 03 Zero | 대형 레트로 타이포 ZERO + 캔 + 리본 배지 |
| 04 Flavors | 동일 카드 3개, hover 시 카드 들썩·캔 회전·과일 튀어나옴·선버스트 회전 |
| Final CTA | 5색 회전 선버스트, 캔 3종, 눌리는 레트로 버튼 |

## 기술 포인트
- 시맨틱 HTML5, CSS 변수 토큰, Grid/Flex, `clamp()` 유동 타이포, 브레이크포인트 1100 / 860 / 560px
- 캔 선택: `<button>` + `data-pos`(center/left/right) 전환, `aria-pressed`·`aria-live` 상태 안내, 키보드 지원
- 테마 전환: `@property`로 등록한 색상 변수를 `data-theme`별로 바꿔 배경/선버스트/강조색이 부드럽게 보간
- 그래픽은 이미지 없이 CSS로 구현: `repeating-conic-gradient`(선버스트), `radial-gradient`(하프톤), 인라인 SVG(물결)
- IntersectionObserver 스크롤 리빌, rAF 패럴랙스, `prefers-reduced-motion` 대응
- 폰트: Pretendard v1.3.9 (jsDelivr), Shrikhand · Inter Tight (Google Fonts)

## 실행
`index.html`을 브라우저로 열거나 로컬 서버(`npx serve .`, VS Code Live Server)로 실행합니다.

## 교체할 것
- CTA 버튼 `href="#top"` → 공식 상품 페이지 URL
- 성분·함량(5mg, 250mg)은 공식 상세페이지와 대조 후 공개
