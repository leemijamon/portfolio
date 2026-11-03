import { Link } from 'react-router-dom'
import styles from './Button.module.css'

// 모든 버튼의 모양을 한 곳에서 관리하는 컴포넌트
// - variant: 'primary' | 'lime' | 'outline' | 'onDark' | 'danger'
// - to가 있으면 페이지 이동 링크(Link), 없으면 일반 버튼(button)으로 그려요
function Button({ variant = 'primary', to, children, className = '', ...rest }) {
  const classNames = `${styles.button} ${styles[variant]} ${className}`

  if (to) {
    return (
      <Link to={to} className={classNames} {...rest}>
        {children}
      </Link>
    )
  }

  return (
    <button type="button" className={classNames} {...rest}>
      {children}
    </button>
  )
}

export default Button
