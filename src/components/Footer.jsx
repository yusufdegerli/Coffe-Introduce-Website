import {
  FaInstagram,
  FaFacebookF,
  FaTwitter,
  FaWhatsapp,
} from "react-icons/fa";
import "./Footer.css";

function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="footer" id="contact">
      <div className="footer-content">
        <div className="footer-main">
          <div className="footer-column brand-column">
            <div className="footer-logo">
              <span className="logo-icon">☕</span>
              <span className="logo-text">Coffee Paradise</span>
            </div>
            <p className="footer-description">
              Dünyanın en kaliteli kahvelerini, doğrudan çiftçilerden sizlere
              ulaştırıyoruz. Kahve tutkunları için özel.
            </p>
            <div className="footer-social">
              <h4 className="footer-social-title">Bizi Takip Edin</h4>
              <div className="social-links">
                <a
                  href="https://instagram.com"
                  className="social-link instagram"
                  aria-label="Instagram"
                  title="Instagram"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FaInstagram />
                </a>
                <a
                  href="https://facebook.com"
                  className="social-link facebook"
                  aria-label="Facebook"
                  title="Facebook"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FaFacebookF />
                </a>
                <a
                  href="https://twitter.com"
                  className="social-link twitter"
                  aria-label="Twitter"
                  title="Twitter (X)"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FaTwitter />
                </a>
                <a
                  href="https://wa.me/905551234567"
                  className="social-link whatsapp"
                  aria-label="WhatsApp"
                  title="WhatsApp"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <FaWhatsapp />
                </a>
              </div>
            </div>
          </div>

          <div className="footer-column">
            <h4 className="footer-title">Hızlı Linkler</h4>
            <ul className="footer-links">
              <li>
                <a href="#home">Ana Sayfa</a>
              </li>
              <li>
                <a href="#categories">Kategoriler</a>
              </li>
              <li>
                <a href="#products">Ürünler</a>
              </li>
              <li>
                <a href="#about">Hakkımızda</a>
              </li>
              <li>
                <a href="#contact">İletişim</a>
              </li>
            </ul>
          </div>

          <div className="footer-column">
            <h4 className="footer-title">Müşteri Hizmetleri</h4>
            <ul className="footer-links">
              <li>
                <a href="#">Sipariş Takibi</a>
              </li>
              <li>
                <a href="#">İade & Değişim</a>
              </li>
              <li>
                <a href="#">SSS</a>
              </li>
              <li>
                <a href="#">Kargo Bilgileri</a>
              </li>
              <li>
                <a href="#">Gizlilik Politikası</a>
              </li>
            </ul>
          </div>

          <div className="footer-column">
            <h4 className="footer-title">İletişim</h4>
            <ul className="footer-contact">
              <li>
                <span className="contact-icon">📍</span>
                <span>İstanbul, Türkiye</span>
              </li>
              <li>
                <span className="contact-icon">📧</span>
                <span>info@coffeeparadise.com</span>
              </li>
              <li>
                <span className="contact-icon">📱</span>
                <span>+90 (212) 555 0123</span>
              </li>
              <li>
                <span className="contact-icon">🕐</span>
                <span>Pzt-Cum: 09:00 - 18:00</span>
              </li>
            </ul>
          </div>

          <div className="footer-column newsletter-column">
            <h4 className="footer-title">Bülten</h4>
            <p className="newsletter-text">
              Yeni ürünler ve özel fırsatlardan haberdar olun!
            </p>
            <form className="newsletter-form">
              <input
                type="email"
                placeholder="E-posta adresiniz"
                className="newsletter-input"
              />
              <button type="submit" className="newsletter-btn">
                Abone Ol →
              </button>
            </form>
            <div className="payment-methods">
              <span className="payment-icon">💳</span>
              <span className="payment-icon">💰</span>
              <span className="payment-icon">🏦</span>
            </div>
          </div>
        </div>

        <div className="footer-bottom">
          <p className="copyright">
            © {currentYear} Coffee Paradise. Tüm hakları saklıdır.
          </p>
          <div className="footer-bottom-links">
            <a href="#">Kullanım Koşulları</a>
            <span className="separator">•</span>
            <a href="#">Gizlilik</a>
            <span className="separator">•</span>
            <a href="#">Çerezler</a>
          </div>
        </div>
      </div>
    </footer>
  );
}

export default Footer;
