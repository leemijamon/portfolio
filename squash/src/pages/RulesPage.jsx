import PageHeader from '../components/PageHeader'
import styles from './Placeholder.module.css'

function RulesPage() {
  return (
    <>
      <PageHeader
        watermark="RULES"
        title="규칙 가이드"
        description="코트 라인 6개, 서브 3단계, 득점 원칙 1가지만 알면 첫 경기를 할 수 있어요."
      />
      <div className="container">
        <div className={styles.box}>
          <strong>3단계에서 만들 페이지예요</strong>
          지금은 주소 연결만 확인해요.
        </div>
      </div>
    </>
  )
}

export default RulesPage
