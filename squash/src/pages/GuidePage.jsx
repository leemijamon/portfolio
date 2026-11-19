import { useState } from 'react'
import Logo from '../components/Logo'
import PageHeader from '../components/PageHeader'
import { guideColor } from '../data/guide'
import { FrontWallDiagram, CourtFloorDiagram } from '../components/rules/CourtDiagram'
import styles from './GuidePage.module.scss'

function GuidePage() {
    return(
        <>
            <PageHeader 
                title="디자인 가이드"
                description="컬러·타이포그래피·컴포넌트로 정리한 디자인 시스템"
                watermark="GUIDE"
                crumb="디자인 가이드"
                theme="blue"    
            />

            {/* 디자인 컨셉 */}
            <section className={`container ${styles.sectionWrap}`}>
                <p className="eyebrow">01 디자인 컨셉</p>
                <div className={styles.sectionHead}>
                    <h2 className={styles.sectionTitle}>공과 코트에서 가져온 디자인</h2>
                    <p className={styles.hint}>앞벽 라인 = 섹션 라인 </p>
                </div>
                <div className={`${styles.gridCol2} ${styles.conceptWrap}`}>
                    <div className={styles.lineButton}>
                        <Logo size='big'/>
                    </div>
                    <div>
                        <FrontWallDiagram />
                    </div>
                </div>
            </section>

            {/* 벤치마킹 분석 */}

            {/* 컬러 */}
            <section className={styles.serve}>
                <div className="container">
                    <p className="eyebrow">02 컬러</p>
                    <div className={styles.sectionHead}>
                        <h2 className={styles.sectionTitle}>가장 느린 공에서 시작했어요</h2>
                        <p className={styles.hint}>앞벽 라인 = 섹션 라인 </p>
                    </div>
                    <ul className={styles.gridCol4}>
                        {guideColor.map((color) => (
                            <li key={color.token} className={styles.colorCard}>
                                <span style={{background: `var(${color.token})`}} className={styles.colorSwatch}></span>
                                <div className={styles.colorCardText}>
                                    <b>{color.name}</b>
                                    <span className={styles.colorUse}>{color.use}</span>
                                </div>
                            </li>
                        ))}
                    </ul>
                </div>
            </section>

            {/* 타이포그래피 */}
            <section className={`container ${styles.sectionWrap} ${styles.seve}`}>
                    <h2 className="eyebrow">03. 타이포그래피</h2>
            </section>
                    
            {/* 컴포넌트 */}

            {/* 카드, 아이콘, 그리드 */}
        </>
    )
}

export default GuidePage
