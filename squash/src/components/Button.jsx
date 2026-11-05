import { Link } from 'react-router-dom'
import styles from './Button.module.scss'

// 모든 버튼의 모양을 한 곳에서 관리하는 컴포넌트
// - variant: 'primary'(블루) | 'dark'(잉크) | 'volt'(볼트) | 'outline' | 'onDark' | 'danger'
// - size: 'md'(기본 52px) | 'sm'(44px)
// - to가 있으면 페이지 이동 링크(Link), 없으면 일반 버튼(button)으로 그려요
function Button({ variant = 'primary', size = 'md', to, children, className = '', ...rest }) {
  const classNames = `${styles.button} ${styles[variant]} ${styles[size]} ${className}`

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
