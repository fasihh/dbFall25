#### Q1
```js
> use inventoryDB;

> db.createCollection("furniture");

> db.furniture.insertMany([
    { name: "Table", color: "Brown", dimensions: [40, 90] },
    { name: "Chair", color: "Black", dimensions: [20, 40] },
    { name: "Shelf", color: "White", dimensions: [60, 120] }
  ]);
```
![alt text](image.png)

#### Q2
```js
> db.furniture.insertOne({
    name: "Desk",
    color: "Brown",
    dimensions: [50, 100]
  });
```
![alt text](image-1.png)

#### Q3
```js
> db.furniture.find({ "dimensions.0": { $gt: 30 } });
```
![alt text](image-2.png)

#### Q4
```js
> db.furniture.find({
    color: "Brown",
    name: { $in: ["Table", "Chair"] }
  });
```
![alt text](image-3.png)

#### Q5
```js
> db.furniture.updateOne(
    { name: "Table" },
    { $set: { color: "Ivory" } }
  );
```
![alt text](image-4.png)

#### Q6
```js
> db.furniture.updateMany(
    { color: "Brown" },
    { $set: { color: "Dark Brown" } }
  );
```
![alt text](image-5.png)

#### Q7
```js
> db.furniture.deleteOne({ name: "Chair" });
```
![alt text](image-6.png)

#### Q8
```js
> db.furniture.deleteMany({ dimensions: [12, 18] });
```
![alt text](image-7.png)

#### Q9
```js
> db.furniture.aggregate([
    { $group: { _id: "$color", count: { $sum: 1 } } }
  ]);
```
![alt text](image-8.png)

#### Q10
```js
> db.furniture.createIndex({ name: "text" });

> db.furniture.find({ $text: { $search: "table" } });
```
![alt text](image-9.png)