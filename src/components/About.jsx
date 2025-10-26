import './About.css'

function About() {
  return (
    <section className="about" id="about">
      <div className="container">
        <div className="about-content">
          <div className="about-image">
            <div className="image-placeholder">
              <div className="coffee-beans">
                <span className="bean">🫘</span>
                <span className="bean">🫘</span>
                <span className="bean">🫘</span>
              </div>
            </div>
            <div className="about-stats-card">
              <div className="stats-item">
                <div className="stats-icon">🌍</div>
                <div className="stats-info">
                  <div className="stats-value">25+</div>
                  <div className="stats-label">Ülkeden Kahve</div>
                </div>
              </div>
              <div className="stats-item">
                <div className="stats-icon">🏆</div>
                <div className="stats-info">
                  <div className="stats-value">15+</div>
                  <div className="stats-label">Yıllık Deneyim</div>
                </div>
              </div>
            </div>
          </div>

          <div className="about-text">
            <span className="section-badge">☕ Hakkımızda</span>
            <h2 className="section-title">Tutku ile Hazırlanan Her Fincan</h2>
            <p className="about-description">
              2008'den beri, dünyanın dört bir yanından en kaliteli kahve çekirdeklerini 
              özenle seçiyor ve kahve tutkunlarına ulaştırıyoruz.
            </p>
            <p className="about-description">
              Çiftçilerle doğrudan çalışarak sürdürülebilir tarım uygulamalarını destekliyor, 
              her kahvenin benzersiz hikayesini sizlerle paylaşıyoruz.
            </p>

            <div className="features-grid">
              <div className="feature-item">
                <div className="feature-icon">✅</div>
                <div className="feature-content">
                  <h4 className="feature-title">%100 Organik</h4>
                  <p className="feature-text">Sertifikalı organik kahveler</p>
                </div>
              </div>
              <div className="feature-item">
                <div className="feature-icon">🚚</div>
                <div className="feature-content">
                  <h4 className="feature-title">Ücretsiz Kargo</h4>
                  <p className="feature-text">500₺ üzeri siparişlerde</p>
                </div>
              </div>
              <div className="feature-item">
                <div className="feature-icon">🔥</div>
                <div className="feature-content">
                  <h4 className="feature-title">Taze Kavurma</h4>
                  <p className="feature-text">Sipariş sonrası kavrum garantisi</p>
                </div>
              </div>
              <div className="feature-item">
                <div className="feature-icon">💯</div>
                <div className="feature-content">
                  <h4 className="feature-title">Memnuniyet Garantisi</h4>
                  <p className="feature-text">30 gün iade hakkı</p>
                </div>
              </div>
            </div>

            <button className="btn btn-primary">
              <span>Daha Fazla Bilgi</span>
              <span className="btn-icon">→</span>
            </button>
          </div>
        </div>
      </div>
    </section>
  )
}

export default About

