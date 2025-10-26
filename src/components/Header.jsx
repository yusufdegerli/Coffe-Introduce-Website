import { useState, useEffect, useRef } from "react";
import { getCategories } from "../services/api";
import "./Header.css";

function Header({ onSelectCategory }) {
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [categoryDropdownOpen, setCategoryDropdownOpen] = useState(false);
  const [categories, setCategories] = useState([]);
  const dropdownRef = useRef(null);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  // Fetch categories from API
  useEffect(() => {
    async function fetchCategories() {
      try {
        const data = await getCategories();
        // API paginated response döndürüyor, results array'ini al
        setCategories(data.results || data);
      } catch (err) {
        console.error("Kategoriler yüklenirken hata:", err);
        // Fallback kategoriler
        setCategories([
          { id: "all", name: "Tümü", icon: "☕" },
          { id: "beans", name: "Kahve Çekirdekleri", icon: "🫘" },
          { id: "ground", name: "Öğütülmüş Kahve", icon: "🌰" },
        ]);
      }
    }
    fetchCategories();
  }, []);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setCategoryDropdownOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleCategoryClick = (categoryId) => {
    onSelectCategory(categoryId);
    setCategoryDropdownOpen(false);
    setMenuOpen(false);
    // Scroll to products section
    const productsSection = document.getElementById("products");
    if (productsSection) {
      productsSection.scrollIntoView({ behavior: "smooth" });
    }
  };

  return (
    <header className={`header ${scrolled ? "scrolled" : ""}`}>
      <div className="header-container">
        <div className="logo">
          <span className="logo-icon">☕</span>
          <span className="logo-text">Coffee Paradise</span>
        </div>

        <nav className={`nav ${menuOpen ? "open" : ""}`}>
          <a href="#home" className="nav-link">
            Ana Sayfa
          </a>

          <div className="nav-dropdown" ref={dropdownRef}>
            <button
              className="nav-link dropdown-trigger"
              onClick={() => setCategoryDropdownOpen(!categoryDropdownOpen)}
            >
              Kategoriler
              <span
                className={`dropdown-icon ${
                  categoryDropdownOpen ? "open" : ""
                }`}
              >
                ▼
              </span>
            </button>

            {categoryDropdownOpen && (
              <div className="nav-dropdown-menu">
                {categories.map((category) => (
                  <button
                    key={category.id}
                    className="nav-dropdown-item"
                    onClick={() => handleCategoryClick(category.id)}
                  >
                    <span className="dropdown-item-icon">{category.icon}</span>
                    <div className="dropdown-item-content">
                      <span className="dropdown-item-name">
                        {category.name}
                      </span>
                      {category.description && (
                        <span className="dropdown-item-desc">
                          {category.description}
                        </span>
                      )}
                    </div>
                  </button>
                ))}
              </div>
            )}
          </div>

          <a href="#products" className="nav-link">
            Ürünler
          </a>
          <a href="#about" className="nav-link">
            Hakkımızda
          </a>
          <a href="#contact" className="nav-link">
            İletişim
          </a>
        </nav>

        <div className="header-actions">
          <a
            href="#contact"
            className="contact-btn-header"
            aria-label="İletişim"
          >
            <span>📞</span>
            <span className="btn-text">Bilgi Al</span>
          </a>
        </div>

        <button
          className="mobile-menu-btn"
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Menü"
        >
          {menuOpen ? "✕" : "☰"}
        </button>
      </div>
    </header>
  );
}

export default Header;
