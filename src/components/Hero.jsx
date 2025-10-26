import './Hero.css'

function Hero() {
  return (
    <section className="hero" id="home">
      <div className="hero-background">
        <div className="hero-shape shape-1"></div>
        <div className="hero-shape shape-2"></div>
        <div className="hero-shape shape-3"></div>
      </div>
      
      <div className="hero-content">
        <div className="hero-badge">
          <span className="badge-icon">✨</span>
          <span>Premium Kahve Deneyimi</span>
        </div>
        
        <h1 className="hero-title">
          Dünyanın En İyi
          <span className="highlight"> Kahvelerini </span>
          Keşfedin
        </h1>
        
        <p className="hero-description">
          Özenle seçilmiş, taze kavrulmuş kahve çekirdeklerinden 
          profesyonel ekipmanlara kadar her şey burada. 
          Kahve tutkunları için özel koleksiyon.
        </p>
        
        <div className="hero-actions">
          <button className="btn btn-primary">
            <span>Alışverişe Başla</span>
            <span className="btn-icon">→</span>
          </button>
          <button className="btn btn-secondary">
            <span className="btn-icon">▶</span>
            <span>Hikayemiz</span>
          </button>
        </div>

        <div className="hero-stats">
          <div className="stat">
            <div className="stat-value">500+</div>
            <div className="stat-label">Kahve Çeşidi</div>
          </div>
          <div className="stat">
            <div className="stat-value">50K+</div>
            <div className="stat-label">Mutlu Müşteri</div>
          </div>
          <div className="stat">
            <div className="stat-value">4.9★</div>
            <div className="stat-label">Ortalama Puan</div>
          </div>
        </div>
      </div>

      <div className="hero-image">
        <div className="coffee-cup">
          <div className="cup-body">☕</div>
          <div className="steam steam-1">~</div>
          <div className="steam steam-2">~</div>
          <div className="steam steam-3">~</div>
        </div>
        <div className="floating-bean bean-1">🫘</div>
        <div className="floating-bean bean-2">🫘</div>
        <div className="floating-bean bean-3">🫘</div>
      </div>
    </section>
  )
}

export default Hero

