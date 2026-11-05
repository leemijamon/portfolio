import { useEffect, useRef, useState } from 'react'
import styles from './Reveal.module.scss'

// 화면에 들어오면 아래에서 살짝 떠오르며 나타나는 상자
// - useRef: 실제 DOM 요소를 가리키는 '손잡이'
// - useEffect: 화면이 그려진 뒤에 실행할 일 (여기서는 관찰 시작)
// - IntersectionObserver: 요소가 화면에 보이는지 브라우저가 알려 주는 기능
function Reveal({ children, delay = 0, className = '' }) {
  const ref = useRef(null)
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    const element = ref.current
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsVisible(true)
          observer.disconnect() // 한 번 나타나면 더 볼 필요 없음
        }
      },
      { threshold: 0.15 },
    )

    observer.observe(element)

    // 컴포넌트가 사라질 때 관찰도 정리해요
    return () => observer.disconnect()
  }, [])

  return (
    <div
      ref={ref}
      className={`${styles.reveal} ${isVisible ? styles.visible : ''} ${className}`}
      style={{ transitionDelay: `${delay}ms` }}
    >
      {children}
    </div>
  )
}

export default Reveal
