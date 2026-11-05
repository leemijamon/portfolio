import PageHeader from '../components/PageHeader'
import styles from './Placeholder.module.scss'

function GlossaryPage() {
  return (
    <>
      <PageHeader
        watermark="SHOTS"
        title="샷 용어 사전"
        description="드라이브, 보스트, 드롭… 한글과 영문으로 찾아보세요."
      />
      <div className="container">
        <div className={styles.box}>
          <strong>5단계에서 만들 페이지예요</strong>
          지금은 주소 연결만 확인해요.
        </div>
      </div>
    </>
  )
}

export default GlossaryPage
