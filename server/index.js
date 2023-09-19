const express = require("express");
const dotenv = require("dotenv").config;
const cors = require("cors");
const {mongoose} = require("mongoose");
// const { MONGO_URL } = process.env; 


//database connection
mongoose
  .connect("mongodb+srv://gautamcizal:mpp0g9sxJwxPNcWD@cluster0.pzblnty.mongodb.net/?retryWrites=true&w=majority&appName=AtlasApp")
  .then(() => console.log("Connected to the database"))
  .catch((err) => console.log("Connection to database failed", err))

const app = express();

app.use("/", require("./routes/authRoutes"));

const port = 8000;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
