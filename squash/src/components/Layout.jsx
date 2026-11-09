import { useEffect } from 'react'
import { Outlet, useLocation } from 'react-router-dom'
import Header from './Header'
import Footer from './Footer'

// 모든 페이지에 공통으로 들어가는 틀
function Layout() {
  const { pathname, hash } = useLocation()

  // 점수 계산기는 앱처럼 쓰는 화면이라 푸터를 숨겨요
  const hideFooter = pathname === '/score'

  // 페이지를 옮기면 스크롤 위치를 정리해요
  // - 주소에 #이 있으면(예: /#checklist) 그 요소로 이동
  // - 없으면 맨 위로 (React Router는 화면만 바꾸기 때문에 직접 올려 줘야 해요)
  useEffect(() => {
    if (hash) {
      const target = document.getElementById(hash.slice(1))
      if (target) {
        target.scrollIntoView({ behavior: 'smooth' })
        return
      }
    }
    window.scrollTo(0, 0)
  }, [pathname, hash])

  return (
    <>
      <a href="#main" className="sr-only">
        본문 바로가기
      </a>
      <Header />
      {/* Outlet: 지금 주소에 맞는 페이지가 이 자리에 들어와요 */}
      <main id="main">
        <Outlet />
      </main>
      {!hideFooter && <Footer />}
    </>
  )
}

export default Layout
