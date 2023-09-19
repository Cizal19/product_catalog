const mongoose = require('mongoose')
const {Schema} = mongoose

const userSchema = new Schema({
  userName: String,
  email: {
    type: String,
    unique: true
  },
  password: String,
  confirmPassword: String,
});

const UserModel = mongoose.model("User", userSchema)  // User -> collection

module.exports = UserModel