const User = require("../models/user")
const jwt = require("jsonwebtoken")

const checkUser = (req, res, next) => {
  const token = req.cookies.token
  if (token) {
    jwt.verify(token, process.env.JWT_SECRET, async (err, decodedToken) => {
      const { userName } = decodedToken
      if (err) {
        console.log(err.message);
    res.statusCode(404).send({ error: "User not found" });
        next();
      } else {
        let user = await User.findOne({userName});
        
        res.send(user);
        next();
      }
    });
  } else {
    res.statusCode(404).send({error: "User not found"})
    
    next();
  }

};

module.exports = checkUser; 