import express from 'express';
// import {CosmosClient}from '@azure/cosmos';
import {MongoClient} from 'mongodb';
import { createRequire } from "module"; //https://stackoverflow.com/questions/69099763/referenceerror-require-is-not-defined-in-es-module-scope-you-can-use-import-in
const require = createRequire(import.meta.url);

const bodyPar = require('body-parser'); 
const app = express();
const port = 3000; // Set desired port number

// const mongoDBURI ="mongodb://";  // here should input the link get from the DB
app.use(bodyPar.json());

// create a get api for get all member
// app.get('/api/checkMember', async(req, res) => {
//     try{

//         // const client =awiat MongoClient.connect(mongoDBURI);
//         const client = new MongoClient(mongoDBURI);
//         await client.connect();

//         // const database = client.db('fypscarnqrcode');
//         const database = client.db('FypDataCollection');
//         const collection = database.collection('MemberList');

//         const result = await collection.find({}).toArray();
//         res.json(result);
//         client.close();
//     }catch(error){
//         console.error('Error retrieving data from Azure Cosmos DB: ', error);
//         res.status(500).json({error: 'Internal server error'});
//     }
// });
//http://localhost:3000/api/checkMember
//for check the above result

//Create a post api for Login
app.post('/api/loginRequest', async(req, res) => {
    const{email, password} = req.body;
    console.log('Received email:', email);
    console.log('Received password:', password);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');

        const findUser = await collection.findOne({email});

        if (findUser && findUser.password === password){
            if(findUser.state == "unavailable"){
                res.status(401).json({error: 'Your account is unavailable'});
            }else{
                res.status(200).json({message: 'Login succcessful!', name: findUser.name, memberType : findUser.memberType, company : findUser.company, contactNumber: findUser.contactNumber });
                // res.json({name: findUser.name, memberType : findUser.memberType});
            }
            console.log("found");
            console.log(findUser.state);
        }else{
            res.status(401).json({error: 'Invalid email or password!'});
            console.log("Not found");
        }
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//Create a post api for getting the time limit
app.post('/api/getTimeLimitByType', async(req, res) => {
    const{staffTypeIs} = req.body;
    console.log('Received member type:', staffTypeIs);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('staffAttendanceLimit');

        const findLimit = await collection.findOne({staffTypeIs});
        res.status(200).json({lateLimit: findLimit.lateLimit, elaryLeaveLimit : findLimit.elaryLeaveLimit});
        console.log(findLimit);
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//for Boss Check Time Limit
app.post('/api/changeTimeLimitByBoss', async(req, res) => {
    const{staffTypeIs, changedLateLimit, changedEarlyLeaveLimit, changedRemarks} = req.body;
    console.log('Received type:', staffTypeIs);
    console.log('Received Late Limit:', changedLateLimit);
    console.log('Received Early Leave Limit:', changedEarlyLeaveLimit);
    console.log('Received remarks:', changedRemarks);

    // const needChangeAccountDetails ={
    //     lateLimit : changedLateLimit,
    //     elaryLeaveLimit : changedEarlyLeaveLimit,
    //     reMark : changedRemarks,
    // }
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('staffAttendanceLimit');
        
        // const staffTypeIs = needChangedType;
        //use email to find the record first
        const changeResult = await collection.updateMany({staffTypeIs: staffTypeIs}, {$set: {lateLimit : changedLateLimit, elaryLeaveLimit: changedEarlyLeaveLimit, reMark: changedRemarks}});
        console.log(changeResult);

        res.status(200).json({message: 'Change succcessful!'});//, name: vsResult.name, memberType : vsResult.memberType});
        //const findUser = await collection.findOne({email});
        await client.close();
    }catch(error){
        console.error('Error changing account details: ', error);
        // if(error.code === 409){
        //     res.status(409).json({error : "Email already exists" })
        // }else{
        //     res.status(500).json({error: 'Error creating'});
        // }
        res.json(error);

    }
});


//for SignUP and IT support create account
app.post('/api/createNewAccount', async(req, res) => {
    const{vsEmail, vsPassword, vsName, vsAge,vsContactNumber, vsMemberType, vsCompany, vsState} = req.body;
    console.log('Received email:', vsEmail);
    console.log('Received password:', vsPassword);
    console.log('Received name:', vsName);
    console.log('Received age:', vsAge);
    console.log('Received contact number:', vsContactNumber);
    console.log('Received memberType:', vsMemberType);
    console.log('Received company:', vsCompany);
    console.log('Received state:', vsState);

    const newVisitorUser ={
        email : vsEmail,
        password : vsPassword,
        name : vsName,
        age : vsAge,
        contactNumber : vsContactNumber,
        memberType : vsMemberType,
        company : vsCompany,
        state : vsState
    }
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');
        
        const email = vsEmail;
        const existingUser = await collection.findOne({email});
        console.log(existingUser);
        console.log("Need Check is "+vsEmail);
        if(existingUser){
            res.status(409).json({error : "Email already exists" });
        }else{
            const vsResult = await collection.insertOne(newVisitorUser);
            console.log("User created:", vsResult.insertedId);
            res.status(200).json({message: 'Sign Up succcessful!'});//, name: vsResult.name, memberType : vsResult.memberType});
        }
        //const findUser = await collection.findOne({email});
        await client.close();
    }catch(error){
        console.error('Error creating user: ', error);
        if(error.code === 409){
            res.status(409).json({error : "Email already exists" })
        }else{
            res.status(500).json({error: 'Error creating'});
        }

    }
});

//other api for different function

//Create a post api for check staff Attendance Record in Date Range need staff Email
app.post('/api/checkStaffInRangeDate', async(req, res) => {
    const{checkingTheEmail, checkStartDate, checkEndDate} = req.body;
    console.log('Received checkingkeyWords:', checkingTheEmail);
    console.log('Received checkStartDate:', checkStartDate);
    console.log('Received checkEndDate:', checkEndDate);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('StaffAttendanceList');

        if(checkingTheEmail== "All"){
            const result = await collection.find({date:{
                $gte : checkStartDate,
                $lte : checkEndDate
            }}).toArray();   
            console.log(result);
            res.status(200).json(result); 
        }else{
            const result = await collection.find({date:{
                $gte : checkStartDate,
                $lte : checkEndDate
            },
            accountEmail : {$regex : checkingTheEmail, $options:"i"
            }}).toArray();   
            console.log(result);
            res.status(200).json(result); 
        }
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//Create a post api for check staff Attendance Record in staff show all or boss check in date to show the staff
app.post('/api/checkStaffAttendance', async(req, res) => {
    const{checkWordsForWhat, checkingType} = req.body;
    console.log('Received checkingWords:', checkWordsForWhat);
    console.log('Received checkingType:', checkingType);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('StaffAttendanceList');

        // const query ={title:{$}}
        if(checkingType == "checkStaff"){
            const result = await collection.find({accountEmail:{
                $regex:checkWordsForWhat, $options:"i"
            }}).toArray();
            console.log(result);
            // res.json(result);
            res.status(200).json(result);
        }else if(checkingType == "checkingDate"){
            const result = await collection.find({date:{
                $regex:checkWordsForWhat, $options:"i"
            }}).toArray();   
            console.log(result);
            // res.json(result);
            res.status(200).json(result);         
        }else{
            throw error;
        }
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//Create a post api for return all staff name without Boss and Visitors for checking attendance 
app.post('/api/getStaffName', async(req, res) => {
    // const{checkingkeyWords, checkingType} = req.body;
    
    try{
        const exclueType =['Boss', 'Visitors'];
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');

        // const query ={title:{$}}
        const result = await collection.find({memberType:{
            $nin: exclueType
        }}).toArray();
        console.log(result);
        // res.json(result);
        const staffNames = result.map(getDataFromDB => getDataFromDB.name);
        console.log(staffNames);
        res.status(200).json(staffNames);
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//for insert staff take in or out attendance  
app.post('/api/insertAttendanceRecord', async(req, res) => {
    const{sDate, sTime, sStaffName, sEmail, sAttendanceRecord, sSituation, sRemarks} = req.body;
    console.log('Received Date:', sDate);
    console.log('Received Time:', sTime);
    console.log('Received Staff name:', sStaffName);
    console.log('Received accountEmail:',sEmail)
    console.log('Received Attendance Record:', sAttendanceRecord);
    console.log('Received Situation:', sSituation);
    console.log('Received reMarks:', sRemarks);

    const newStaffAttendanceRecord ={
        date : sDate,
        time : sTime,
        staffName : sStaffName,
        accountEmail : sEmail,
        attendanceRecord : sAttendanceRecord,
        situation : sSituation,
        // reMarks: sRemarks
        reMarks: "No Remarks"
    }
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('StaffAttendanceList');

        const vsResult = await collection.insertOne(newStaffAttendanceRecord);

        console.log("Record created:", vsResult.insertedId);
        res.status(200).json({message: 'Inserted Record succcessful!'});//, name: vsResult.name, memberType : vsResult.memberType});
        //const findUser = await collection.findOne({email});
        await client.close();
    }catch(error){
        console.error('Error insertRecord: ', error);
        // if(error.code === 409){
        //     res.status(409).json({error : "Email already exists" })
        // }else{
        //     res.status(500).json({error: 'Error creating'});
        // }
    }
});

//Create a post api for return user email in type for select account 
app.post('/api/getAccountEmailByType', async(req, res) => {
    const{memberType} = req.body;
    console.log(memberType);
    try{
        // const exclueType =['Boss', 'Visitors'];
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');

        // const query ={title:{$}}
        const result = await collection.find({memberType:{
            $eq: memberType
        }}).toArray();
        console.log(result);
        // res.json(result);
        const accountEmail = result.map(getDataFromDB => getDataFromDB.email);
        console.log(accountEmail);
        res.status(200).json(accountEmail);
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//get the account details form email
app.post('/api/findAccountDetailsByEmail', async(req, res) => {
    const{email} = req.body;
    console.log('Received email:', email);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');

        const findUser = await collection.findOne({email});
        console.log(findUser);

        if (findUser){
            // res.status(200).json({message: 'Find succcessful!', email: findUser.email, password: findUser.password, name: findUser.name, age: findUser.age, contactNumber: findUser.contactNumber, memberType : findUser.memberType, company : findUser.company, state: findUser.state});
            res.status(200).json({email: findUser.email, password: findUser.password, name: findUser.name, age: findUser.age, contactNumber: findUser.contactNumber, memberType : findUser.memberType, company : findUser.company, state: findUser.state});
            console.log("found");
        }else{
            res.status(401).json({error: 'Invalid email!'});
            console.log("Not found");
        }
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//for IT support and user change account details 
app.post('/api/changeAccountDetails', async(req, res) => {
    const{chaEmail, chaPassword, chaName, chaAge, chaContactNumber, chaMemberType, chaCompany, chaState} = req.body;
    console.log('Received email:', chaEmail);
    console.log('Received password:', chaPassword);
    console.log('Received name:', chaName);
    console.log('Received age:', chaAge);
    console.log('Received contact number:', chaContactNumber);
    console.log('Received memberType:', chaMemberType);
    console.log('Received company:', chaCompany);
    console.log('Received state:', chaState);

    const needChangeAccountDetails ={
        //email : chaEmail,
        password : chaPassword,
        name : chaName,
        age : chaAge,
        contactNumber : chaContactNumber,
        memberType : chaMemberType,
        company : chaCompany,
        state : chaState
    }
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('MemberList');
        
        const email = chaEmail;
        //use email to find the record first
        const chaResult = await collection.updateMany({email: chaEmail}, {$set: {password : chaPassword, password: chaPassword, name: chaName, age: chaAge, contactNumber: chaContactNumber, memberType : chaMemberType, company : chaCompany, state: chaState}});
        console.log(chaResult);

        res.status(200).json({message: 'Change succcessful!'});//, name: vsResult.name, memberType : vsResult.memberType});
        //const findUser = await collection.findOne({email});
        await client.close();
    }catch(error){
        console.error('Error changing account details: ', error);
        // if(error.code === 409){
        //     res.status(409).json({error : "Email already exists" })
        // }else{
        //     res.status(500).json({error: 'Error creating'});
        // }
        res.json(error);

    }
});

//for visitor form insert
app.post('/api/insertVisitRequest', async(req, res) => {
    const{newVisitDate, newVisitTime, newBookerEmail, newBookerName, newBookerContactNumber,newBookerCompany, newBookingDate, newRequestState} = req.body;
    console.log('Received newVisitDate:', newVisitDate);
    console.log('Received newVisitTime:', newVisitTime);
    console.log('Received newVisitEmail:', newBookerEmail);
    console.log('Received newVisitName:', newBookerName);
    console.log('Received newVisitContactNumber:', newBookerContactNumber);
    console.log('Received newVisitCompany', newBookerCompany);
    console.log('Received newBookingDay:', newBookingDate);
    console.log('Received newVisitState:', newRequestState);

    const newVisitorRequest ={
        visitDate : newVisitDate,
        visitTime : newVisitTime,
        bookerEmail : newBookerEmail,
        bookerName : newBookerName,
        bookerContactNumber : newBookerContactNumber,
        bookerCompany : newBookerCompany,
        bookingDate : newBookingDate,
        requestState : newRequestState
    }
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('VisitRequestRecord');
        
        const vsResult = await collection.insertOne(newVisitorRequest);
        console.log("Request created:", vsResult.insertedId);
        res.status(200).json({message: 'Request succcessful!'});
        await client.close();
    }catch(error){
        console.error('Error creating user: ', error);
            res.status(500).json({error: 'Error request'});
    }
});

//Create a post api for check visitor record
app.post('/api/checkVisitRecord', async(req, res) => {
    const{whoChecking} = req.body;
    console.log('Received whoChecking:', whoChecking);
    try{
        // const client =awiat MongoClient.connect(mongoDBURI);
        const client = new MongoClient(mongoDBURI);
        await client.connect();

        // const database = client.db('fypscarnqrcode');
        const database = client.db('FypDataCollection');
        const collection = database.collection('VisitRequestRecord');

        // const query ={title:{$}}
        if(whoChecking == "Boss"){
            const result = await collection.find({}).toArray();
            console.log(result);
            // res.json(result);
            res.status(200).json(result);
        }else{
            const result = await collection.find({bookerEmail:{
                $regex:whoChecking, $options:"i"
            }}).toArray();  
            console.log(result);
            // res.json(result);
            res.status(200).json(result);         
        }
        await client.close();
    }catch(error){
        console.error('Error retrieving data from Azure Cosmos DB: ', error);
        res.status(500).json({error: 'Internal server error'});
    }
});

//Start server
app.listen(port, () => {
    console.log('Server is listening on port ${port}');
});

app.get('/', (req,res)=>
{
        res.send('Opened in Mac')
    }
)