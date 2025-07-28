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

**Login Page**  
<img src="assets/screenshots/mobile%20login%20pg.png" width="300"/>

**Register Page**  
<img src="assets/screenshots/mobile%20rigister%20pg.png" width="300"/>

**Dark Mode**  
<img src="assets/screenshots/darkmode.png" width="600"/>

---

### Product Management

**Product List (Mobile)**  
<img src="assets/screenshots/mobile%20product%20list%20pg.png" width="300"/>

**Inventory Page (Mobile)**  
<img src="assets/screenshots/mobile%20inventory%20pg.png" width="300"/>

**Product List (Web)**  
<img src="assets/screenshots/web%20product%20list.png" width="600"/>

**Inventory (Web)**  
<img src="assets/screenshots/web%20invetory.png" width="600"/>

---

### Dashboard

**Mobile Dashboard**  
<img src="assets/screenshots/mobile%20dashboard.png" width="300"/>

**Web Dashboard**  
<img src="assets/screenshots/web%20dashboard.png" width="600"/>

---
### Anatytics 

**Anatytics Dashboard**  
<img src="assets/screenshots/analtics%20page.png" width="300"/>

---

## Future Enhancements

- Generate and export printable bills as PDF  
- Role-based access control (Admin and Staff)  
- Interactive charts with monthly and yearly filters  
- Offline cart support for enhanced reliability  
