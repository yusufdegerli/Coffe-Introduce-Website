// API Configuration
const API_BASE_URL =
  import.meta.env.VITE_API_URL || "http://localhost:8000/api";

/**
 * Fetch wrapper with error handling
 */
async function fetchAPI(endpoint, options = {}) {
  try {
    const response = await fetch(`${API_BASE_URL}${endpoint}`, {
      headers: {
        "Content-Type": "application/json",
        ...options.headers,
      },
      ...options,
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error("API Error:", error);
    throw error;
  }
}

/**
 * Get all categories
 */
export async function getCategories() {
  return fetchAPI("/categories/");
}

/**
 * Get all products
 */
export async function getProducts(params = {}) {
  const queryString = new URLSearchParams(params).toString();
  const endpoint = queryString ? `/products/?${queryString}` : "/products/";
  return fetchAPI(endpoint);
}

/**
 * Get products by category
 */
export async function getProductsByCategory(categoryId) {
  if (categoryId === "all") {
    return getProducts();
  }
  return fetchAPI(`/products/by_category/?category=${categoryId}`);
}

/**
 * Get single product
 */
export async function getProduct(productId) {
  return fetchAPI(`/products/${productId}/`);
}

/**
 * Get featured products
 */
export async function getFeaturedProducts() {
  return fetchAPI("/products/featured/");
}

/**
 * Get in-stock products
 */
export async function getInStockProducts() {
  return fetchAPI("/products/in_stock/");
}
