const bcrypt = require('bcryptjs');
bcrypt.hash('care', 10).then(hash => console.log(hash));