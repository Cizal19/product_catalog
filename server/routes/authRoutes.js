const express = require("express");
const router = express.Router();
const cors = require('cors')

const { test, registerUser, loginUser, getUserDetails } = require('../controllers/authController')
const checkUser = require('../middlewares/auth')

router.use(
  cors({
    credentials: true,
    origin: 'http://localhost:3000'
  })
)

router.get("/", test)
router.post("/register", registerUser)
router.post("/login", loginUser);
router.get("/user", checkUser);

module.exports = router