import express from "express";
import session from "express-session";
import path from "path";
import { fileURLToPath } from "url";
import expressLayouts from "express-ejs-layouts";

import articleRoutes from "./routes/article.js";
import authRoutes from "./routes/auth.js";
import chatbotRoutes from "./routes/chatbot.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

app.use(
  session({
    secret: "secret",
    resave: false,
    saveUninitialized: true,
  })
);

// View engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Layout setup
app.use(expressLayouts);
app.set("layout", "layout"); // default layout file: views/layout.ejs

// Routes
app.use("/articles", articleRoutes);
app.use("/auth", authRoutes);
app.use("/chatbot", chatbotRoutes);

// Home
app.get("/", (req, res) => {
  res.render("index", { title: "HealthCare" });
});

export default app;
