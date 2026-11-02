import './App.css'
import FeatureCard from './components/FeatureCard'

function App() {
  return (
    <main>
      <h1>Squash 101</h1>
      <p>벽을 향해 치는, 가장 빠른 라켓 스포츠</p>
      <button className="start-btn">스쿼시 알아보기</button>

      <section>
        <h2>스쿼시의 매력</h2>
        <FeatureCard icon="⚡" title="짧고 강한 운동" description="쉴 틈 없는 랠리로 짧은 시간에 높은 운동 효과를 얻어요."></FeatureCard>
        <FeatureCard icon="🏠" title="날씨 걱정 없는 실내 스포츠" description="실내 코트에서 사계절 내내 즐길 수 있어요."></FeatureCard>
        <FeatureCard icon="🧠" title="벽을 이용한 두뇌 싸움" description="네 면의 벽을 활용한 각도와 전략이 승부를 갈라요."></FeatureCard>
      </section>
    </main>
  )
}

export default App