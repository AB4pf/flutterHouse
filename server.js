//serveur express,
const express = require('express')
const app = express()
const port = 3000
const bodyParser= require('body-parser')

//connexion BDD,
const mysql = require('mysql')
const db = mysql.createConnection({
  host: '127.0.0.1',
  port:3306,
  user: 'root',
  password: '',
  database: 'woodycraftv2'
})

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(express.json());

//vérification serveur,
app.listen(port, (err) => {
  console.log('Server On')
} );

//connexion BDD serveur,
db.connect((err) => {
  if (err){
      throw err;
  }
  console.log('Base connecté')
});


// Recuperation des produits dans la BDD
app.get('/products', (req, res) => {
  db.query('SELECT * FROM products',
  (err, results) => {
      if (err){
          throw err;
      }
      res.json(results);
      console.log(results);
  }
  )
});


app.post('/login', (req, res) => {
  const { email, password } = req.body;
  console.log(email)
  console.log(password)
  // Vérifiez les informations d'identification dans la base de données
  db.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, results) => {
    console.log(results)

    if (results.length > 0) {
      // Utilisateur authentifié avec succès
      res.json({ message: 'Login successful' });
    } else {
      // réponse complète lors de l'échec de la connexion
      console.log('Unsuccessful login attempt:', req.body);
      // Informations d'identification incorrectes
      res.status(401).json({ message: 'Invalid email or password' });
    }
  });
});

app.put('/products/modifier/:id', (req, res) => {
  const id = req.params.id;
  const { name, price } = req.body;
  console.log(id)
  console.log(name)
  console.log(price)
  // Vérifiez les informations d'identification dans la base de données
  db.query('UPDATE products SET name = ? , price = ? WHERE id = ?', [name, price, id], (err, results) => {
    console.log(results)
    if(err){
      throw err;
    }
    console.log('Produit mis à jour avec succès')
    res.status(200).json({message: `Le Produit avec l\'id ${id} mis à jour succès`})
  });
});

app.delete('/products/delete/:id', (req, res) => {
  const id = req.params.id;
  console.log(id)
  // Vérifiez les informations d'identification dans la base de données
  db.query('DELETE FROM products WHERE id = ?', [id], (err, results) => {
    console.log(results)
    if(err){
      throw err;
    }
    console.log('Produit supprimer avec succès')
    res.status(200).json({message: `Le Produit avec l\'id ${id} à bien été supprimer`})
  });
});

app.post('/products/create', (req, res) => {
  const { categories_id, name, description, image, price, quantity} = req.body;
  console.log(categories_id)
  console.log(name)
  console.log(description)
  console.log(image)
  console.log(price)
  console.log(quantity)
  // Vérifiez les informations d'identification dans la base de données
  db.query('INSERT INTO products ( categories_id, name, description, image, price, quantity ) VALUES (?,?,?,?,?,?)', 
  [categories_id, name, description, image, price, quantity], (err, results) => {
    console.log(results)

    if(err){
      throw err;
    }
    console.log('Produit créé avec succès')
    res.status(200).json({message: `Le Produit à été creer`})
  });
});



// https://www.loginradius.com/blog/engineering/guest-post/authenticating-flutter-apps/
