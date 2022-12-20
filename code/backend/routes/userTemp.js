const { request, response } = require("express");
const express = require("express");
const User = require("../models/user_model");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware");

const router2 = express.Router();

router2.route("/:username/").get((request, response) => { //getting userdata through get request from the username
    const account = "storage3yp";
    const sas = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-02-02T01:46:46Z&st=2022-12-17T17:46:46Z&spr=https&sig=ZfncjtcQF7HT6E8kWezAt9z9Xq1HU9%2BsubZ2pZHlVvg%3D";
    //request.body.account
    //request.body.token
    const { TableClient, AzureSASCredential, odata} = require("@azure/data-tables");
    
    // const account = "<account name>";
    //const sas = "<service Shared Access Signature Token>";
    const tableName = "temperature";
    const partitionKey = "1";
    const clientWithSAS = new TableClient(
      `https://${account}.table.core.windows.net`,
      tableName,
      new AzureSASCredential(sas)
    );
    async function main() {
      let entitiesIter = clientWithSAS.listEntities({
        queryOptions:{filter: odata `PartitionKey eq ${partitionKey}`,
        select: ["messageNo,temperature"]}
      });
      const iterator = entitiesIter.byPage({maxPageSize: 2}); //for top entry
    
      let topEntry = [];
      for await (const page of iterator) {
        //console.log(`Entity${i}: PartitionKey: ${entity.partitionKey} RowKey: ${entity.rowKey} Temp: ${entity.temperature}`);
        topEntry = page;
        break;
        // Output:
        // Entity1: PartitionKey: P1 RowKey: R1
    
      }
      console.log(`Top entry:${topEntry[1].messageNo} ${topEntry[1].temperature}`);
      User.findOne({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
            temp: topEntry[1].temperature,
        });
        });
      
    }
    
    
    
    main();
    
});


module.exports = router2;