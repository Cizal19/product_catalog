const express = require("express");
const dotenv = require("dotenv").config();
const cors = require("cors");
const {mongoose} = require("mongoose");
const { MONGO_URL } = process.env; 
const cookieParser = require('cookie-parser')
const app = express();

//database connection
mongoose
  .connect(MONGO_URL)
  .then(() => console.log("Connected to the database"))
  .catch((err) => console.log("Connection to database failed", err))


// middleware
app.use(express.json())
app.use(cookieParser())
app.use(express.urlencoded({extended: false}))
app.use("/", require("./routes/authRoutes"));

const port = 8000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
