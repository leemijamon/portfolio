import { useParams } from 'react-router-dom'
import PageHeader from '../components/PageHeader'
import Button from '../components/Button'
import styles from './Placeholder.module.css'

function GlossaryDetailPage() {
  // 주소 /glossary/boast 에서 :id 자리의 'boast'를 꺼내요
  const { id } = useParams()

  return (
    <>
      <PageHeader watermark={id.toUpperCase()} title={`용어 상세: ${id}`} />
      <div className="container">
        <div className={styles.box}>
          <strong>5단계에서 만들 페이지예요</strong>
          주소창의 마지막 단어를 바꿔 보면 제목도 같이 바뀌어요.
          <div className={styles.actions}>
            <Button to="/glossary" variant="outline">
              목록으로 돌아가기
            </Button>
          </div>
        </div>
      </div>
    </>
  )
}

export default GlossaryDetailPage
