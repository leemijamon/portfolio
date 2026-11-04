import PageHeader from '../components/PageHeader'
import Button from '../components/Button'
import styles from './Placeholder.module.css'

function NotFoundPage() {
  return (
    <>
      <PageHeader watermark="404" title="페이지를 찾을 수 없어요" description="주소가 바뀌었거나 없는 페이지예요." />
      <div className={`container ${styles.section}`}>
        <div className={styles.actions}>
          <Button to="/">홈으로 가기</Button>
        </div>
      </div>
    </>
  )
}

export default NotFoundPage
