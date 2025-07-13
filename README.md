# Smart Retail ERP

A modern ERP system built using **Flutter**, **Supabase**, and **Riverpod** for managing product inventory, billing, and sales with real-time dashboard insights — styled with an intuitive, e-commerce-like interface.

---

## Features

- **Product Management** – Add, view, and update products with stock tracking and low-stock alerts  
- **Store Page** – Scroll through products, add items to a cart, review cart contents, and generate bills  
- **Billing System** – Records purchase history with bill ID, product details, and quantities  
- **Dashboard Analytics** – Displays key metrics such as total products, current stock levels, total sales, and generated bills  
- **Theme Support** – Toggle between light and dark modes using Riverpod  
- **Real-Time Sync** – Pull-to-refresh updates using Supabase and Riverpod integration  

---

## Tech Stack

| Layer             | Technology           |
|-------------------|----------------------|
| UI                | Flutter              |
| Backend           | Supabase (PostgreSQL)|
| State Management  | Riverpod             |
| Authentication    | Supabase Auth        |
| Date Formatting   | `intl` package       |

---

## Project Structure
'''
lib/
├── app/
│ └── theme/ # Light and dark themes
├── core/
│ └── widgets/ # Reusable components (sidebar, buttons, etc.)
├── data/
│ ├── models/ # Product, CartItem, Bill models
│ └── repositories/ # Supabase database interaction logic
├── features/
│ ├── auth/ # Login and registration UI
│ ├── dashboard/ # Dashboard page and controller
│ ├── product/ # Product listing, add/edit functionality
│ └── store/ # Store cart, billing, and checkout logic

'''
---

## Supabase Tables

### `products`
- `id`, `name`, `price`, `stock`, `created_at`

### `bills`
- `bill_id`, `total`, `date`

### `purchase_history`
- `id`, `bill_id` (foreign key), `product_id` (foreign key), `quantity`, `price`, `total`, `date`

---

## UI Previews

### Authentication

| Login Page | Register Page | Dark Mode |
|------------|---------------|-----------|
| ![](assets/screenshots/mobile%20login%20pg.png) | ![](assets/screenshots/mobile%20register%20pg.png) | ![](assets/screenshots/darkmode.png) |

### Product Management

| Product List (Mobile) | Inventory Page (Mobile) | Product List (Web) | Inventory (Web) |
|------------------------|--------------------------|---------------------|------------------|
| ![](assets/screenshots/mobile%20product%20list%20pg.png) | ![](assets/screenshots/mobile%20inventory%20pg.png) | ![](assets/screenshots/web%20product%20list.png) | ![](assets/screenshots/web%20inventory.png) |

### Dashboard

| Mobile Dashboard | Web Dashboard |
|------------------|----------------|
| ![](assets/screenshots/mobile%20dashboard.png) | ![](assets/screenshots/web%20dashboard.png) |

---

## Future Enhancements

- Generate and export printable bills as PDF  
- Role-based access control (Admin and Staff)  
- Interactive charts with monthly and yearly filters  
- Offline cart support for enhanced reliability  
