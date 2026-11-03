import PageHeader from '../components/PageHeader'
import styles from './Placeholder.module.css'

function RulesPage() {
  return (
    <>
      <PageHeader
        label="/ RULES"
        title="규칙 알아보기"
        description="경기 전에 꼭 알아야 할 코트 구조, 서브, 득점 방식을 정리했어요."
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
