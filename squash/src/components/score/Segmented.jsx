import styles from './Segmented.module.scss'

// 여러 개 중 하나를 고르는 버튼 묶음 (예: 3게임 / 5게임)
// - options: [{ value, label, sub? }] / value: 선택된 값 / onChange(value)
function Segmented({ legend, options, value, onChange }) {
  return (
    <fieldset className={styles.fieldset}>
      <legend className={styles.legend}>{legend}</legend>
      <div className={styles.group}>
        {options.map((option) => {
          const isSelected = option.value === value
          return (
            <button
              key={option.value}
              type="button"
              aria-pressed={isSelected}
              className={`${styles.option} ${isSelected ? styles.selected : ''}`}
              onClick={() => onChange(option.value)}
            >
              {option.label}
              {option.sub && <span className={styles.sub}>{option.sub}</span>}
            </button>
          )
        })}
      </div>
    </fieldset>
  )
}

export default Segmented
