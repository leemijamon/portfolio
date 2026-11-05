import { useState } from 'react'
import styles from './Accordion.module.scss'

// 재사용 아코디언: 한 번에 하나만 펼쳐져요
// items: [{ id, question, answer, note? }]
function Accordion({ items, defaultOpenId = items[0]?.id }) {
  // state: 지금 펼쳐진 항목의 id (모두 닫혀 있으면 null)
  const [openId, setOpenId] = useState(defaultOpenId)

  // 열린 걸 다시 누르면 닫고(null), 다른 걸 누르면 그걸 열어요
  const toggle = (id) => setOpenId(openId === id ? null : id)

  return (
    <div className={styles.list}>
      {items.map((item, index) => {
        const isOpen = openId === item.id
        return (
          <div key={item.id} className={`${styles.item} ${isOpen ? styles.open : ''}`}>
            <h3 className={styles.heading}>
              <button
                type="button"
                id={`acc-${item.id}`}
                aria-expanded={isOpen}
                aria-controls={`acc-panel-${item.id}`}
                className={styles.trigger}
                onClick={() => toggle(item.id)}
              >
                <span className={`display ${styles.number}`}>Q{index + 1}</span>
                <span className={styles.question}>{item.question}</span>
                <svg className={styles.icon} width="22" height="22" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                  {/* 열리면 −, 닫히면 + */}
                  {isOpen ? (
                    <path d="M5 12h14" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" />
                  ) : (
                    <path d="M12 5v14M5 12h14" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" />
                  )}
                </svg>
              </button>
            </h3>

            {/* 조건부 렌더링: 열려 있을 때만 답변을 그려요 */}
            {isOpen && (
              <div id={`acc-panel-${item.id}`} role="region" aria-labelledby={`acc-${item.id}`} className={styles.panel}>
                <p>{item.answer}</p>
                {item.note && <p className={styles.note}>{item.note}</p>}
              </div>
            )}
          </div>
        )
      })}
    </div>
  )
}

export default Accordion
