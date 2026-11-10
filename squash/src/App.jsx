import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import HomePage from './pages/HomePage'
import RulesPage from './pages/RulesPage'
import GearPage from './pages/GearPage'
import GlossaryPage from './pages/GlossaryPage'
import GlossaryDetailPage from './pages/GlossaryDetailPage'
import ScorePage from './pages/ScorePage'
import GuidePage from './pages/GuidePage'
import NotFoundPage from './pages/NotFoundPage'

// 주소와 페이지를 연결하는 '지도' 역할
function App() {
  return (
    <Routes>
      {/* Layout 안에 있는 페이지들은 공통 헤더와 푸터를 함께 써요 */}
      <Route element={<Layout />}>
        <Route path="/" element={<HomePage />} />
        <Route path="/rules" element={<RulesPage />} />
        <Route path="/gear" element={<GearPage />} />
        <Route path="/glossary" element={<GlossaryPage />} />
        {/* :id 자리에 오는 값은 상세 페이지에서 useParams로 꺼내 써요 */}
        <Route path="/glossary/:id" element={<GlossaryDetailPage />} />
        <Route path="/score" element={<ScorePage />} />
        <Route path="/guide" element={<GuidePage />} />
        {/* 위에 없는 주소는 모두 여기로 */}
        <Route path="*" element={<NotFoundPage />} />
      </Route>
    </Routes>
  )
}

export default App
