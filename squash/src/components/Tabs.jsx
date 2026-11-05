import { useRef } from 'react'
import styles from './Tabs.module.scss'

// 재사용 탭 버튼 묶음
// - 어떤 탭이 선택됐는지(activeId)는 부모가 state로 갖고 있어요
// - 탭을 누르면 onChange(탭 id)로 부모에게 알려 줘요
// - 내용(패널)은 부모가 activeId를 보고 직접 보여줘요
function Tabs({ label, tabs, activeId, onChange, idPrefix = 'tab' }) {
  // 키보드 화살표로 이동할 때 다음 버튼에 포커스를 주려고 버튼들을 기억해요
  const tabRefs = useRef([])

  const handleKeyDown = (event, index) => {
    if (event.key !== 'ArrowRight' && event.key !== 'ArrowLeft') return

    const direction = event.key === 'ArrowRight' ? 1 : -1
    // 마지막에서 → 누르면 처음으로, 처음에서 ← 누르면 마지막으로
    const nextIndex = (index + direction + tabs.length) % tabs.length

    onChange(tabs[nextIndex].id)
    tabRefs.current[nextIndex].focus()
  }

  return (
    <div role="tablist" aria-label={label} className={styles.tablist}>
      {tabs.map((tab, index) => {
        const isSelected = tab.id === activeId
        return (
          <button
            key={tab.id}
            ref={(element) => (tabRefs.current[index] = element)}
            type="button"
            role="tab"
            id={`${idPrefix}-${tab.id}`}
            aria-selected={isSelected}
            aria-controls={`${idPrefix}-panel-${tab.id}`}
            tabIndex={isSelected ? 0 : -1}
            className={`${styles.tab} ${isSelected ? styles.selected : ''}`}
            onClick={() => onChange(tab.id)}
            onKeyDown={(event) => handleKeyDown(event, index)}
          >
            {tab.label}
          </button>
        )
      })}
    </div>
  )
}

export default Tabs
