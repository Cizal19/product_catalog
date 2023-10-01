const User = require("../models/user");
const { hashPassword, comparePassword } = require("../helpers/auth");
const jwt = require("jsonwebtoken");

const test = (req, res) => {
  res.status(200).json({ message: "Test is working" });
};

// Register endpoint
const registerUser = async (req, res) => {
  try {
    const { userName, email, password, confirmPassword } = req.body;

    // Check if userName was entered
    if (!userName) {
      return res.status(400).json({ error: "Username is required" });
    }

    const oldUser = await User.findOne({ userName });
    if (oldUser) {
      return res.status(400).json({ error: "Username already taken" });
    }

    // Check if email was entered
    if (!email) {
      return res.status(400).json({ error: "Email is required" });
    }

    // Check if password is good
    if (!password) {
      return res.status(400).json({
        error:
          "Password is required and should contain at least one special character, one number, and one uppercase letter.",
      });
    }

    // const specialCharacterRegex = /[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]/;
    const numberRegex = /[0-9]/;
    // const uppercaseLetterRegex = /[A-Z]/;
    const regex =
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;
    // password.length <= 8 ||
    if (!numberRegex.test(password) || 
      !regex.test(password)) {
      return res.status(400).json({
        error:
          "Password should be at least 8 characters long and contain at least one special character, one number, and one uppercase letter.",
      });
    }

    // Check if password and confirmPassword match
    if (!confirmPassword || password !== confirmPassword) {
      return res
        .status(400)
        .json({ error: "Password and Confirm Password do not match" });
    }

    // Check email
    const exist = await User.findOne({ email });
    if (exist) {
      return res.status(400).json({ error: "Email already taken" });
    }

    const hashedPassword = await hashPassword(password);

    const user = await User.create({
      userName,
      email,
      password: hashedPassword,
    });

    return res.status(201).json(user); // 201 status for resource created
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" }); // 500 status for server error
  }
};

// Login endpoint
const loginUser = async (req, res) => {
  try {
    const { userName, password } = req.body;

    // Check if user exists
    const user = await User.findOne({ userName });
    if (!user) {
      return res.status(404).json({ error: "User not found" }); // 404 status for not found
    }

    // Check if password matches
    const match = await comparePassword(password, user.password);
    if (match) {
      jwt.sign(
        { userName: user.userName, id: user._id },
        process.env.JWT_SECRET,
        {},
        (err, token) => {
          if (err) throw err;
          res.status(200).json(user); // 200 status for success
        }
      );
    } else {
      return res.status(401).json({ error: "Password does not match" }); // 401 status for unauthorized
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" }); // 500 status for server error
  }
};

// get profile endpoint
const getProfile = async (req, res) => {
  try {
    const existingUser = await User.findById(req.params.userId);

    if (!existingUser) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json(existingUser);
  } catch (err) {
    console.error("Error fetching user profile:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};



// update profile endpoint
const updateProfile = async (req, res) => {
 try {
   const updatedUser = await User.findByIdAndUpdate(
     req.params.userId,
     req.body,
     { new: true }
   );
   if (!updatedUser) {
     return res.status(404).json({ error: "User not found" });
   }
   res.json(updatedUser).status(200);
 } catch (err) {
   console.error("Error updating user profile:", err);
   res.status(500).json({ error: "Internal server error" });
 }
}

module.exports = {
  test,
  registerUser,
  loginUser,
  getProfile,
  updateProfile
};
