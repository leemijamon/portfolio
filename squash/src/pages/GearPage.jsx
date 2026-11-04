import PageHeader from '../components/PageHeader'
import styles from './Placeholder.module.css'

function GearPage() {
  return (
    <>
      <PageHeader
        watermark="GEAR"
        title="장비 가이드"
        description="처음엔 라켓, 공, 실내화, 고글만 있으면 충분해요."
      />
      <div className="container">
        <div className={styles.box}>
          <strong>4단계에서 만들 페이지예요</strong>
          지금은 주소 연결만 확인해요.
        </div>
      </div>
    </>
  )
}

export default GearPage
