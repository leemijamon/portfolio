// 글자 안에서 검색어 부분만 <mark>로 강조해요
// 예) text '스트레이트 드롭', query '드롭' → 스트레이트 <mark>드롭</mark>
function Highlight({ text, query }) {
  const keyword = query.trim()
  const start = keyword ? text.toLowerCase().indexOf(keyword.toLowerCase()) : -1

  // 못 찾으면 그냥 글자 그대로
  if (start === -1) return text

  const end = start + keyword.length
  return (
    <>
      {text.slice(0, start)}
      <mark>{text.slice(start, end)}</mark>
      {text.slice(end)}
    </>
  )
}

export default Highlight
