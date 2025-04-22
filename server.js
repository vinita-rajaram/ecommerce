const express = require("express"); // Imports the Express.js framework to create a web server.
const mysql = require("mysql2");//Imports the MySQL2 library to connect and interact with a MySQL database
const cors = require("cors");  //access all node api's in our react app
const multer = require("multer"); // Import Multer for file uploads
const path = require("path"); // Import Path for handling file extensions
require("dotenv").config();  // environment variables from a .env file for configuration.
const bcrypt = require("bcrypt"); // Import Bcrypt for password hashing
const jwt = require("jsonwebtoken"); // Import JWT for authentication




const app = express();  
app.use(cors());
app.use(express.json());
app.use("/uploads", express.static("uploads")); // Serve images statically


app.get('/',(req,res)=>{
  return res.json("From backend side");
})


// MySQL Database Connection
const db = mysql.createConnection({
  host: "localhost",
  user: "root", // Change if needed
  password: "", // Change if needed
  database: "ecommerce_db",
});

db.connect((err) => {
  if (err) {
    console.log("Database connection failed!", err);
  } else {
    console.log("Connected to MySQL Database");
  }
});



// 🔹 Admin Login Route
app.post("/admin/login", (req, res) => {
  const { email, password } = req.body;

  db.query("SELECT * FROM admins WHERE email = ?", [email], async (err, results) => {
    if (err) return res.status(500).json({ success: false, message: "Database error" });
    if (results.length === 0) return res.status(401).json({ success: false, message: "Invalid credentials" });

    const admin = results[0];

    // Compare hashed password
    const isMatch = await bcrypt.compare(password, admin.password);
    if (!isMatch) return res.status(401).json({ success: false, message: "Invalid credentials" });

    const token = jwt.sign({ id: admin.id, email: admin.email }, "secret_key", { expiresIn: "1h" });

    res.json({ success: true, message: "Login successful", token });
  });
});

// Payment API Endpoint
app.post("/api/payments", (req, res) => {
  const { name, cardNumber, expiry, cvv, totalAmount } = req.body;
  
  if (!name || !cardNumber || !expiry || !cvv || !totalAmount) {
    return res.status(400).json({ success: false, error: "All fields are required" });
  }
  
  const orderId = Math.floor(Math.random() * 1000000);
  const transactionId = `TXN${Date.now()}`;

  const sql = `INSERT INTO payment_details (order_id, total_amount, cardholder_name, payment_method, payment_status, transaction_id) VALUES (?, ?, ?, ?, ?, ?)`;
  
  db.query(sql, [orderId, totalAmount, name, "Card", "Success", transactionId], (err) => {
    if (err) {
      console.error("Payment error:", err);
      return res.status(500).json({ success: false, error: "Database error" });
    }
    res.json({ success: true, message: "Payment successful", transactionId });
  });
});



//  Customer Signup 
app.post("/customers/signup", async (req, res) => {
  const { name, email, password } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10); // Hash password

    const sql = "INSERT INTO customers (name, email, password) VALUES (?, ?, ?)";
    db.query(sql, [name, email, hashedPassword], (err, result) => {
      if (err) {
        console.error("❌ Error inserting customer:", err);
        return res.status(500).json({ success: false, message: "Database error." });
      }
      res.status(201).json({ success: true, message: "Signup successful", id: result.insertId });
    });
  } catch (error) {
    console.error("❌ Password hashing error:", error);
    res.status(500).json({ success: false, message: "Error processing signup." });
  }
});


app.post("/customers/login", (req, res) => {
  const { email, password } = req.body;

  const sql = "SELECT * FROM customers WHERE email = ?";
  db.query(sql, [email], async (err, results) => {
    if (err) return res.json({ success: false, message: "Database error" });

    if (results.length === 0) {
      return res.json({ success: false, message: "Invalid email or password" });
    }

    const customer = results[0];

    // If password is plain text, update it to hashed
    if (!customer.password.startsWith("$2b$")) {
      const hashedPassword = await bcrypt.hash(customer.password, 10);
      db.query("UPDATE customers SET password = ? WHERE id = ?", [hashedPassword, customer.id]);
    }

    // Compare password with hashed password
    const isMatch = await bcrypt.compare(password, customer.password);
    if (!isMatch) {
      return res.json({ success: false, message: "Invalid email or password" });
    }

    // Generate JWT token
    const token = jwt.sign({ id: customer.id, email: customer.email }, "secret_key", { expiresIn: "1h" });

    res.json({ success: true, message: "Login successful", token });
  });
});

// Multer Storage Setup
const storage = multer.diskStorage({
  destination: "uploads/", // Image save location
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Rename image
  },
});
const upload = multer({ storage: storage });

// Add Product with Image Upload
app.post("/products/add", upload.single("image"), (req, res) => {
  const { name, price } = req.body;
  const image = req.file ? `/uploads/${req.file.filename}` : null;

  const sql = "INSERT INTO products (name, price, image) VALUES (?, ?, ?)";
  db.query(sql, [name, price, image], (err, result) => {
    if (err) return res.status(500).json({ error: "Database error" });
    res.json({ id: result.insertId, name, price, image });
  });
});

// Get All Products
app.get("/products", (req, res) => {
  db.query("SELECT * FROM products", (err, results) => {
    if (err) return res.status(500).json({ error: "Database error" });
    res.json(results);
  });
});

// Update Product with Image Upload
app.put("/products/update/:id", upload.single("image"), (req, res) => {
  const { name, price } = req.body;
  const image = req.file ? `/uploads/${req.file.filename}` : req.body.existingImage;

  const sql = "UPDATE products SET name=?, price=?, image=? WHERE id=?";
  db.query(sql, [name, price, image, req.params.id], (err) => {
    if (err) return res.status(500).json({ error: "Database error" });
    res.json({ message: "Product updated successfully" });
  });
});

// Delete Product
app.delete("/products/delete/:id", (req, res) => {
  db.query("DELETE FROM products WHERE id=?", [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: "Database error" });
    res.json({ message: "Product deleted successfully" });
  });
});

// Start Server
app.listen(5000, () => console.log("Server running on port 5000"));
