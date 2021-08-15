const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors')
const mysql = require('mysql');






// create connection : 
const db = mysql.createConnection({
  host: 'localhost',
  user : 'root',
  password :'',
  database :'midad'
});

// connect : 
db.connect((err)=>{
  if(err){
      console.log(err);
  }
  console.log("Mysql Connected");
})



const app = express();

app.use(bodyParser.urlencoded({ extended : true}))
app.use(bodyParser.json())
app.use(cors())

app.get('/',(req, res) => {
  const titre = req.body.titre
  const prix = req.body.prix

  let sql = "insert into enum_formation (titre, prix) values(?,?)"
  db.query(sql, [titre, prix],(err, result) => {
    if(err) return console.log(err);

    console.log(result);
    res.send(result);
  })

})




app.post('/inscription',(req, res)=>{
  let nom = req.body.nom;
  let prenom = req.body.prenom;
  // let dateNes = req.body.dateNes;
  // let adress = req.body.adress;
  let telephone = req.body.telephone;
  let formation = req.body.formation;

console.log(nom, prenom,telephone,formation);

  let id_inserted_user,id_inserted_formation



})



app.get('/getListFormations',  (req, res)=>{
  let sql = "select * from enum_formation"
  db.query(sql, (err, rows)=>{
    if(err) return console.log(err);

    res.send(rows)
  })
}
)

app.get('/fetchcategorie',(req, res)=>{
  
})

app.get('/fetchformations',(req, res)=>{
  const cat = req.body.cat;

  
})

app.post('/creatinscription', (req, res)=>{
  const nom = req.body.nom;
  const prenom = req.body.prenom;
  const telephone = req.body.telephone
  const adress = req.body.adress;
  const dateNes = req.body.dateNes
  const nivo = req.body.nivo
  const formation = req.body.formation


  // first check if user exists in the db if not, add it :
  let sql_user =  "select * from utilisateur where nom = '" + nom + "' and prenom = '" + prenom + "'"
  db.query(sql_user, (err, rows)=>{
    if(err) return console.log(err);
    // check if the user !exists 
    if(rows.length == 0){

      // create the userId : 
      let user_id = nom[0]+ prenom[0]+'002'
     
      let sql_insert = "INSERT INTO utilisateur (id,nom, prenom, numero_tel,type) VALUES (?,?,?,?,0)"
      db.query(sql_insert, [user_id,nom,prenom,telephone],(err1, result)=>{
        if(err1) return console.log("error insert N1: "+err1);

        id_inserted_user = result.insertId

        // user inserted now we need to get the id of the "formation" : 
        let sql_formation = "select titre,prix from enum_formation where id="+formation
        db.query(sql_formation, (err2, rows_formation)=>{
          if(err2) return console.log("error select N2: " + err2)

          // console.log(rows_formation[0].titre)
          // console.log(rows_formation.prix)

          if(rows_formation.length > 0){
            // insert into table formation : 
            let sql_formation = "insert INTO formation (titre_formation, prix_formation) VALUES ('"+rows_formation[0].titre+"','"+rows_formation[0].prix+"')"
            db.query(sql_formation, (err3, result3)=>{
              if(err3) return console.log('error insert3 :'+err3)
              
              id_inserted_formation = result3.insertId

              console.log(id_inserted_formation);
              console.log(id_inserted_user);
              
              // insert into inscription using the inserted ids:
              let dateTime = new Date()
              let sql_inscription = 'INSERT INTO inscription (date_insc,id_formation,id_user) VALUES ("'+dateTime+'",'+id_inserted_formation+',"'+user_id+'")'
              db.query(sql_inscription,(err4,result4 )=>{
                if (err4) return console.log('Error insert N4 : '+err4)

                res.send(result4)
              })

            })

          }else{
            console.log("there is no 'formation' with this name : "+formation);
          }
        })

      })

    }else{
      // check if the user is unique
    }
  })

})



app.listen('5000',()=>{
  console.log("server running on port 5000");
})

