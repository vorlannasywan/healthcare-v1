const db = require("./db");

async function createArticle(title, category, content, image) {
  const [rows] = await db.query(
    "INSERT INTO articles (title, category, content, image) VALUES (?, ?, ?, ?)",
    [title, category, content, image]
  );
  return rows.insertId;
}

async function getAllArticles() {
  const [rows] = await db.query("SELECT * FROM articles ORDER BY id DESC");
  return rows;
}

async function getArticleById(id) {
  const [rows] = await db.query("SELECT * FROM articles WHERE id = ?", [id]);
  return rows[0];
}

module.exports = { createArticle, getAllArticles, getArticleById };
