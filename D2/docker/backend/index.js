const express = require('express');
const { Client } = require('pg');

const app = express();
const port = 3000;

const client = new Client({
  user: process.env.POSTGRES_USER || 'user',
  host: process.env.POSTGRES_HOST || 'database',
  database: process.env.POSTGRES_DB || 'mydatabase',
  password: process.env.POSTGRES_PASSWORD || 'password',
  port: 5432,
});

client.connect();

app.get('/', async (req, res) => {
  try {
    const result = await client.query('SELECT NOW()');
    res.send(`Hello from Backend! DB Time: ${result.rows[0].now}`);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error connecting to database');
  }
});

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});

