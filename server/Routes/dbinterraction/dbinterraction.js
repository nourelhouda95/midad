

export const getformationList =  (req, res)=>{
    let sql = "select * from enum_formation"
    db.query(sql, (err, rows)=>{
      if(err) return console.log(err);
  
      res.send(rows)
    })
  }
