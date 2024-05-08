const express = require('express')
const mongoose = require('mongoose')

var app = express()
var Data = require('./noteScema')
const { Console } = require('console')

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", function() {
    console.log("Connected to Database")
}).on ("error", function (error) {

    console.log("Failed to connect" + error)

})

//CREATE NOTE
//POST request

app.post("/create", (req,res) =>  {

    var note = new Data ({
        
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")

    })

    note.save().then(() => {
        if (note.isNew === false) {
            console.log("Saved Data!")
            res.send("Saved Data!")
        }else {
            console.log("Failed to save data")
        }
    })
})

//Fetch Data
app.get('/fetch',(req, res) => {
    Data.find({}).then ((DBitemss) => {

        res.send(DBitemss)

    })

})

//Delete a note
// app.post("/delete", (req, res) => {

//     Data.findOneAndDelete({

//         _id: req.get("id")
//     }, (err) => {
//         console.log("Failed" + err)

//     })
//     res.send("Deleted!")

// })
app.post("/delete", (req, res) => {
    Data.findOneAndDelete({ _id: req.get("id") }) // Filter by ID and delete
        .then(deletedNote => {
            if (deletedNote) {
                console.log("Deleted:", deletedNote);
                res.send("Note deleted successfully"); // Send success response
            } else {
                console.log("Note not found");
                res.status(404).send("Note not found"); // Send 404 if note was not found
            }
        })
        .catch(err => {
            console.log("Error:", err);
            res.status(500).send("Failed to delete note"); // Send error response
        });
});

//Update Note
// app.post('/update', (req,res) => {

//     Data.findOneAndUpdate({

//         id: req.get("id")

//     }, {
//         note: req.get("note"),
//         title: req.get("title"),
//         date: req.get("date")
//     }, (err) => {
//         console.log("Faile to update" + err)
//     } )
//     res.send("Updated!")

// })



//http://192.168.68.109:8081/create
//sonumartin@Sonus-MacBook-Air-2 ~ % mongosh
// // Update Note
app.post('/update', async (req, res) => {
    try {
        const updatedData = await Data.findOneAndUpdate(
            { _id: req.get("id") },
            {
                note: req.get("note"),
                title: req.get("title"),
                date: req.get("date")
            }
        );
        if (updatedData) {
            console.log("Updated!");
            res.send("Updated!");
        } else {
            console.log("Note not found");
            res.status(404).send("Note not found");
        }
    } catch (err) {
        console.error("Failed to update:", err);
        res.status(500).send("Failed to update data");
    }
});


var server = app.listen(8081, "192.168.68.109", () => {
    console.log("Server Running")
})