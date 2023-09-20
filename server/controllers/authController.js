const User = require('../models/user')
const { hashPassword, comparePassword } = require("../helpers/auth")
const jwt = require('jsonwebtoken') 

const test = (req, res) => {
  res.json("test is working")
}

// Register endpoint
const registerUser = async (req, res) => {
  try {
    const { userName, email, password, confirmPassword } = req.body;

    // Check if userName was entered
    if (!userName) {
      return res.json({
        error: "Username is required",
      });
    }
    const oldUser = await User.findOne({ userName });
    if (oldUser) {
      return res.json({
        error: "Username already taken",
      });
    }

    // Check if userName was entered
    if (!email) {
      return res.json({
        error: "Email is required",
      });
    }

    // Check if password is good
    if (!password || password.length < 8) {
      return res.json({
        error: "Password is required and should be at least 8 characters long",
      });
    }

    // Check if password and confirmPassword match
    if (!confirmPassword || password != confirmPassword) {
      return res.json({
        error: "Password and Confirm Password do not match",
      });
    }

    //Check email
    const exist = await User.findOne({ email });
    if (exist) {
      return res.json({
        error: "Email already taken",
      });
    }

    const hashedPassword = await hashPassword(password);

    const user = await User.create({
      userName,
      email,
      password: hashedPassword,
    });

    return res.json(user);
  } catch (error) {
    console.log(error)
  }
}

// Login endpoint
const loginUser = async (req, res) =>{
 try {
  const {userName, password} = req.body

  // Check if user exists
  const user = await User.findOne({userName})
  if(!user){
    return res.json({
      error: "No user found"
    })
  }

  // Check if password match
  const match = await comparePassword(password, user.password)
  if(match) {
    jwt.sign({userName: user.userName, id: user._id }, process.env.JWT_SECRET, {}, (err, token) => {
      if(err) throw err;
      res.cookie('token', token).json(user)
    })
  }
 } catch (error) {
   console.log(error)
 }
}


module.exports = {
  test,
  registerUser, 
  loginUser
}