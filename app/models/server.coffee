schema = new mongoose.Schema
  name: String
  apikey: String

module.exports = mongoose.model 'Server', schema
