const { MongoClient } = require('mongodb');
const fs = require('fs');

const uri = "mongodb://localhost:27017";
const dbName = "productDB";
const collectionName = "products";

async function main() {
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log("Connected to MongoDB");

        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        // Operation 1: Load Data
        const productsData = JSON.parse(fs.readFileSync('products_catalog.json', 'utf-8'));
        await collection.deleteMany({});
        await collection.insertMany(productsData);
        console.log("Operation 1: Data loaded");

        // Operation 2: Basic Query
        const electronics = await collection.find(
            { category: "Electronics", price: { $lt: 50000 } },
            { projection: { name: 1, price: 1, stock: 1, _id: 0 } }
        ).toArray();
        console.log("Operation 2: Electronics under 50000", electronics);

        // Operation 3: Review Analysis
        const highRated = await collection.aggregate([
            { $unwind: "$reviews" },
            { $group: { _id: "$_id", name: { $first: "$name" }, avgRating: { $avg: "$reviews.rating" } } },
            { $match: { avgRating: { $gte: 4.0 } } },
            { $project: { name: 1, avgRating: 1, _id: 0 } }
        ]).toArray();
        console.log("Operation 3: Products with avg rating >= 4", highRated);

        // Operation 4: Update Operation
        const newReview = { user: "U999", rating: 4, comment: "Good value", date: new Date() };
        await collection.updateOne({ product_id: "ELEC001" }, { $push: { reviews: newReview } });
        console.log("Operation 4: Added review to ELEC001");

        // Operation 5: Complex Aggregation
        const categoryStats = await collection.aggregate([
            { $group: { _id: "$category", avg_price: { $avg: "$price" }, product_count: { $sum: 1 } } },
            { $project: { _id: 0, category: "$_id", avg_price: 1, product_count: 1 } },
            { $sort: { avg_price: -1 } }
        ]).toArray();
        console.log("Operation 5: Average price by category", categoryStats);

    } catch (err) {
        console.error(err);
    } finally {
        await client.close();
        console.log("MongoDB connection closed");
    }
}

main();
