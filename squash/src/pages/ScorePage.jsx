import PageHeader from '../components/PageHeader'
import styles from './Placeholder.module.css'

function ScorePage() {
  return (
    <>
      <PageHeader
        label="/ SCOREBOARD"
        title="점수 기록하기"
        description="PAR 11점제 규칙으로 경기 점수를 기록해요."
      />
      <div className="container">
        <div className={styles.box}>
          <strong>6단계에서 만들 페이지예요</strong>
          지금은 주소 연결만 확인해요.
        </div>
      </div>
    </>
  )
}

export default ScorePage
