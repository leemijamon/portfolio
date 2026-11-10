import { useState } from 'react'
import PageHeader from '../components/PageHeader'
import { guideColor } from '../data/guide'
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
            <section className={`container ${styles.sectionWrap}`}>
                <h2 className="eyebrow">02. 컬러</h2>
                <ul className={styles.colorGrid}>
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
            </section>
        </>
    )
}

export default GuidePage
