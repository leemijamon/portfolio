import { useEffect, useRef } from 'react'
import styles from './Modal.module.scss'

// 재사용 모달(대화 상자) 틀
// - 부모가 열려 있을 때만 그려요: {selected && <Modal ...>}
// - labelledBy: 모달 제목 요소의 id (화면 낭독기가 제목을 읽어요)
// - onClose: 닫기 버튼, 바깥 어두운 영역, Esc 키에서 불러요
function Modal({ labelledBy, onClose, children }) {
  const closeButtonRef = useRef(null)

  // ① 열릴 때 한 번: 뒤 화면 스크롤 막기 + 닫기 버튼으로 포커스 이동
  //    닫힐 때(cleanup): 스크롤 되돌리기 + 원래 누른 버튼으로 포커스 돌려주기
  useEffect(() => {
    const lastFocused = document.activeElement
    document.body.style.overflow = 'hidden'
    closeButtonRef.current.focus()

    return () => {
      document.body.style.overflow = ''
      lastFocused?.focus()
    }
  }, [])

  // ② Esc 키로 닫기
  useEffect(() => {
    const handleKeyDown = (event) => {
      if (event.key === 'Escape') onClose()
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [onClose])

  return (
    <div className={styles.overlay} onClick={onClose}>
      {/* 안쪽을 누를 때는 닫히지 않도록 클릭이 바깥으로 전달되는 걸 막아요 */}
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby={labelledBy}
        className={styles.dialog}
        onClick={(event) => event.stopPropagation()}
      >
        <span className={styles.handle} aria-hidden="true" />
        <button ref={closeButtonRef} type="button" aria-label="닫기" className={styles.close} onClick={onClose}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" aria-hidden="true">
            <path d="M6 6l12 12M18 6L6 18" />
          </svg>
        </button>
        {children}
      </div>
    </div>
  )
}

export default Modal
