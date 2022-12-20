const express = require("express");
const mongoose =  require("mongoose");
const { DefaultAzureCredential } = require('@azure/identity');
const { BlobServiceClient } = require("@azure/storage-blob");
const { TableServiceClient, odata } = require("@azure/data-tables");


const port = process.env.port || 8080;
const app = express();

// connection string::::: --> mongodb://newdatabase:EgDowmgrMcSkfcLjcQZn5s9xZ1E1NrGsAFATbae0SmriAUzi65heVodicf50S1Nn5KS6f4PaC3zDACDbkOPuWw%3D%3D@newdatabase.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@newdatabase@
mongoose.connect('mongodb+srv://jayathrimr:test@clusterauthentication.zuqekpl.mongodb.net/Healthwatch_patients?retryWrites=true&w=majority');

//connection string--> (for storage) DefaultEndpointsProtocol=https;AccountName=storage3yp;AccountKey=r4AK7sikq6YjgsmhvYnsUp4VYwDketz2HrpKIoG/HzGDoqifsuQUkejWm8WGPlG9/80Yqkp4ahHM+ASt8twUOQ==;EndpointSuffix=core.windows.net
const connection = mongoose.connection;


connection.once("open", ()=>{
    console.log("MongoDb connected");
});


const account = "storage3yp";
const sas = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-02-02T01:46:46Z&st=2022-12-17T17:46:46Z&spr=https&sig=ZfncjtcQF7HT6E8kWezAt9z9Xq1HU9%2BsubZ2pZHlVvg%3D";

const blobSasUrl = `https://${account}.blob.core.windows.net${sas}`;
const blobServiceClient = new BlobServiceClient(blobSasUrl);

const containerName = "container1";
const containerClient = blobServiceClient.getContainerClient(containerName);
//console.log(containerClient);

const listFiles = async() =>{
  try {
    
    let i = 1;
    for await (const blob of containerClient.listBlobsFlat()) {
      console.log(`Blob ${i++}: ${blob.name}`);
      // https://storage3yp.blob.core.windows.net/container1/
      // import data from './data.json';
      //   console.log(data);
    }
    fetch("https://storage3yp.blob.core.windows.net/container1/0_bdc8dc3668ff4f608ad4a3f8c6c1f8b9_1.json?sp=r&st=2022-12-18T12:42:32Z&se=2022-12-18T20:42:32Z&spr=https&sv=2021-06-08&sr=b&sig=wpKsGCyUkd4DNWWFeNHgWz7eaNmFdhVl%2F4bkd85ElYQ%3D")
        .then((response) => response.json())
        .then((json) => console.log(json['temperature']));
    //https://storage3yp.blob.core.windows.net/container1/0_88c608327bb840d7b4e1b8a658397d6e_1.json
  } catch (error) {
    console.log("error: the container does not contain any files")
  }
};


app.use(express.json());
const userRoute = require("./routes/user");
const userRoute2 = require("./routes/userTemp");

app.use("/user",userRoute);
app.use("/user/userTemp",userRoute2);

app.route("/").get((request, response)=>response.send("First Rest API: updated"));


app.listen(port, ()=>console.log(`port:${port} -> Server is running...`));