import { useEffect } from 'react'
import { Outlet, useLocation } from 'react-router-dom'
import Header from './Header'
import Footer from './Footer'

// 모든 페이지에 공통으로 들어가는 틀
function Layout() {
  const { pathname } = useLocation()

  // 페이지를 옮기면 스크롤을 맨 위로 올려요
  // (React Router는 화면만 바꾸기 때문에, 이걸 안 하면 이전 스크롤 위치가 그대로 남아요)
  useEffect(() => {
    window.scrollTo(0, 0)
  }, [pathname])

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
      <Footer />
    </>
  )
}

export default Layout
