// 서브 3단계 카드 그림 (장식이라 aria-hidden)
function ServeStepArt({ type }) {
  if (type === 'box') {
    return (
      <svg viewBox="0 0 200 180" width="200" height="180" aria-hidden="true">
        <rect x="30" y="10" width="140" height="160" fill="#fff" stroke="#0B1220" strokeWidth="2" />
        <line x1="30" y1="96" x2="170" y2="96" stroke="#D42F25" strokeWidth="3" />
        <line x1="100" y1="96" x2="100" y2="170" stroke="#D42F25" strokeWidth="3" />
        <rect x="30" y="96" width="36" height="36" fill="#D7FF3F" stroke="#D42F25" strokeWidth="3" />
        <rect x="134" y="96" width="36" height="36" fill="none" stroke="#D42F25" strokeWidth="3" />
        <ellipse cx="46" cy="114" rx="7" ry="11" fill="#1F4BFF" />
        <ellipse cx="80" cy="120" rx="7" ry="11" fill="#1F4BFF" opacity=".45" />
      </svg>
    )
  }
  if (type === 'wall') {
    return (
      <svg viewBox="0 0 240 180" width="240" height="180" aria-hidden="true">
        <rect x="20" y="10" width="200" height="160" fill="#fff" stroke="#CDD3DE" strokeWidth="2" />
        <rect x="20" y="34" width="200" height="72" fill="#D7FF3F" opacity=".6" />
        <line x1="20" y1="34" x2="220" y2="34" stroke="#D42F25" strokeWidth="4" />
        <line x1="20" y1="106" x2="220" y2="106" stroke="#D42F25" strokeWidth="4" />
        <rect x="20" y="152" width="200" height="18" fill="#D42F25" />
        <circle cx="150" cy="66" r="11" fill="#0B1220" />
        <path d="M100 60l8 8 14-16" stroke="#0B1220" strokeWidth="3" fill="none" />
      </svg>
    )
  }
  // 'diagonal'
  return (
    <svg viewBox="0 0 200 180" width="200" height="180" aria-hidden="true">
      <rect x="30" y="10" width="140" height="160" fill="#fff" stroke="#0B1220" strokeWidth="2" />
      <rect x="100" y="96" width="70" height="74" fill="#D7FF3F" />
      <line x1="30" y1="96" x2="170" y2="96" stroke="#D42F25" strokeWidth="3" />
      <line x1="100" y1="96" x2="100" y2="170" stroke="#D42F25" strokeWidth="3" />
      <rect x="30" y="96" width="36" height="36" fill="none" stroke="#D42F25" strokeWidth="3" />
      <polyline points="48,114 110,12 140,142" fill="none" stroke="#1F4BFF" strokeWidth="3" strokeDasharray="6 5" />
      <circle cx="140" cy="142" r="8" fill="#0B1220" />
    </svg>
  )
}

export default ServeStepArt
