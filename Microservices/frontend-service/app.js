const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send(process.env.MESSAGE || 'Frontend Service Running');
});

app.listen(port, () => {
  console.log(`Service listening on port ${port}`);
});
