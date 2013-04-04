schema = new mongoose.Schema
  name: String

module.exports = mongoose.model 'Player', schema
