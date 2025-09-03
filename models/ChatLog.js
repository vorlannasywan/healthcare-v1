import { DataTypes } from "sequelize";
import sequelize from "./index.js";

const ChatLog = sequelize.define("ChatLog", {
  userMessage: DataTypes.TEXT,
  botReply: DataTypes.TEXT
});

export default ChatLog;
