import './App.css'
import FeatureCard from './components/FeatureCard'
import features from './data/feature'

function App() {
  return (
    <main>
      <h1>Squash 101</h1>
      <p>벽을 향해 치는, 가장 빠른 라켓 스포츠</p>
      <button className="start-btn">스쿼시 알아보기</button>

      <section>
        <h2>스쿼시의 매력</h2>
        <div className="feature-list">
          {features.map((feature) => (
            <FeatureCard
              key={feature.id}
              icon={feature.icon}
              title={feature.title}
              description={feature.description}
            />
          ))}
        </div>
      </section>
    </main>
  )
}

export default App