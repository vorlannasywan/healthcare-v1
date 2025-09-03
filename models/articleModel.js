import { DataTypes } from "sequelize";
import sequelize from "./index.js";

const Article = sequelize.define("Article", {
  title: DataTypes.STRING,
  content: DataTypes.TEXT,
  category: DataTypes.STRING,
  embedding: DataTypes.TEXT // untuk RAG (dummy)
});

export default Article;
