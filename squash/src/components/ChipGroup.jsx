import styles from './ChipGroup.module.scss'

// 재사용 필터 버튼 묶음 (하나만 선택)
// - label: 묶음 이름 (예: '종류') · 화면과 화면 낭독기 모두에 보여요
// - options: [{ id, label }] / value: 선택된 id / onChange(id): 눌렀을 때
// - tone: 선택된 버튼 색 'dark'(기본) | 'blue'
function ChipGroup({ label, options, value, onChange, tone = 'dark' }) {
  return (
    <div role="group" aria-label={label} className={styles.group}>
      <b className={styles.label}>{label}</b>
      {options.map((option) => {
        const isSelected = option.id === value
        return (
          <button
            key={option.id}
            type="button"
            aria-pressed={isSelected}
            className={`${styles.chip} ${isSelected ? styles[tone] : ''}`}
            onClick={() => onChange(option.id)}
          >
            {option.label}
          </button>
        )
      })}
    </div>
  )
}

export default ChipGroup
