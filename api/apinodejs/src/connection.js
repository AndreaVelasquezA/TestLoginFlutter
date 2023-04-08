const mongoose = require('mongoose')

mongoose.connect('mongodb://localhost:27017/storedb',{
   
}).then(db => console.log('Connection establishe successfully'))