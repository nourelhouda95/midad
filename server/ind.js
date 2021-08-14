const express = require('express')
const bodyparser = require('body-parser')
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


const app = express()
app.use(bodyparser.json)
app.use(bodyparser.urlencoded({ extended: false }))

app.get('/', (req, res)=>{
  let aff = [];
  let sql = 'select * from enum_formation where id = 2';
  db.query(sql, (err, rows)=>{
    if(err) return console.log(err);

    console.log(rows);
    console.log(rows.length);
    rows.forEach(row => {
      aff.push(row.titre)
      console.log(aff);
    });
    res.send(aff)
  })
})



// app.post('/inscription',(req, res)=>{
//   let nom = req.body.nom;
//   let prenom = req.body.prenom;
//   // let dateNes = req.body.dateNes;
//   // let adress = req.body.adress;
//   let telephone = req.body.telephone;
//   let formation = req.body.formation;

// console.log(nom, prenom,telephone,formation);

//   let id_inserted_user,id_inserted_formation

//   // first check if user exists in the db if not, add it :
//   let sql_user =  "select * from utilisateur where nom = '" + nom + "' and prenom = '" + prenom + "'"
//   // db.query(sql_user, (err, rows)=>{
//   //   if(err) return console.log(err);
//   //   // check if the user !exists 
//   //   if(rows.length == 0){
     
//       // let sql_insert = 'INSERT INTO utilisateur (nom, prenom, numero_tel,type) VALUES ('+nom+','+prenom+','+telephone+',0)'
//       // db.query(sql_insert, (err1, result)=>{
//       //   if(err1) return console.log("error insert N1: "+err1);

//       //   id_inserted_user = result.insertedId

//       //   // user inserted now we need to get the id of the "formation" : 
//       //   let sql_formation = "select id,prix from enum_formation where titre = '"+formation+"'"
//       //   db.query(sql_formation, (err2, rows_formation)=>{
//       //     if(err2) return console.log("error select N2: " + err2)

//       //     if(rows_formation.length > 0){
//       //       // insert into table formation : 
//       //       let sql_formation = 'insert INTO formation (titre_formation, prix_formation) VALUES ('+rows_formation.titre+','+rows_formation.prix+')'
//       //       db.query(sql_formation, (err3, result3)=>{
//       //         if(err3) return log.error('error insert3 :'+err3)
              
//       //         id_inserted_formation = result3.insertedId

//       //         // insert into inscription using the inserted ids:
//       //         let dateTime = new Date()
//       //         let sql_inscription = 'INSERT INTO inscription (date_insc,id_formation,id_user) VALUES ('+dateTime+','+id_inserted_formation+','+id_inserted_user+')'
//       //         db.query(sql_inscription,(err4,result4 )=>{
//       //           if (err4) return console.log('Error insert N4 : '+err4)

//       //           res.send(result4)
//       //         })

//       //       })

//       //     }else{
//       //       console.log("there is no 'formation' with this name : "+formation);
//       //     }
//       //   })

//       // })

//   //   }else{
//   //     // check if the user is unique
//   //   }
//   // })

// })




app.listen(5000, () => {
    console.log('listening to PORT 5000');
})


/* --------------------------------
GET : 
 getFormation
 getUser
 getInscriptions

POST :
 createUser
 creatFormation
 createInscription

PUT :
 putUser
 putFormation
 putInscription

DELETE :
 deleteFormation
 deleteInscription


 */