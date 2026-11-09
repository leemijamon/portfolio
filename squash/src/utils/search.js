// 검색에 쓰는 작은 함수들

// 비교하기 쉽게 바꾸기: 영어는 소문자로, 띄어쓰기와 하이픈(-)은 빼요
// 예) 'Cross-Court' → 'crosscourt', '크로스 코트' → '크로스코트'
export const normalize = (text) => text.toLowerCase().replace(/[\s-]/g, '')

// 한글 이름, 영어 이름, 다른 이름(aliases) 중 하나라도 검색어를 포함하면 true
export function matchShot(shot, query) {
  const keyword = normalize(query)
  if (keyword === '') return true // 검색어가 없으면 전부 보여줘요

  const words = [shot.name, shot.en, ...shot.aliases]
  return words.some((word) => normalize(word).includes(keyword))
}
