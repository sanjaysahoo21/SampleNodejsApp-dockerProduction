import express from 'express'

const app = express();

const port = process.env.PORT || 5000;

app.get('/', (req,res) => {
    res.send('Node js app running....')
});

app.listen(port, () => {
    console.log(`server is running at ${port}`);
});