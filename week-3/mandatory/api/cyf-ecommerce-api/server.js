const express = require("express");
const app = express();
const { Pool } = require("pg");
const bodyParser = require("body-parser");
app.use(bodyParser.json());

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "cyf_ecommerce",
  password: "PULIDO",
  port: 5432,
});

app.get("/customers", function (req, res) {
  pool
    .query("SELECT * FROM customers")
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
});

app.get("/suppliers", function (req, res) {
  pool.query("SELECT * FROM suppliers", (error, result) => {
    res.json(result.rows);
  });
});

/*Update the previous GET endpoint /products to filter the list of products by name using a query parameter, for example /products?name=Cup. This endpoint should still work even if you don't use the name query parameter!*/
app.get("/products", function (req, res) {
  pool.query(
    "SELECT product_name, supplier_name FROM products AS p INNER JOIN suppliers AS s ON s.id=supplier_id",
    (error, result) => {
      res.json(result.rows);
    }
  );
});


//Add a new GET endpoint /customers/:customerId to load a single customer by ID.//
app.get("/customers/:customerId", function (req, res) {
  const customerId = req.params.customerId;

pool
    .query('SELECT * FROM customers WHERE id=$1', [customerId])
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
}
  );

//Add a new POST endpoint /customers to create a new customer.//
  app.post("/customers", function (req, res) {
    const newCustomerName = req.body.name;
    const newCustomerAddress = req.body.address;
    const newCustomerCity = req.body.city;
    const newCustomerCountry = req.body.country;
  
    const query =
      "INSERT INTO customers (name, address, city,country) VALUES ($1, $2, $3, $4) returning id";
  
    pool
      .query(query, [
        newCustomerName,
        newCustomerAddress,
        newCustomerCity,
        newCustomerCountry,
      ])
      .then(() => res.send("Customer created!"))
      .catch((e) => console.error(e));
  });

//Add a new POST endpoint /products to create a new product (with a product name, a price and a supplier id). Check that the price is a positive integer and that the supplier ID exists in the database, otherwise return an error.//
  app.post("/products", function (req, res) {
    const newProductName = req.body.product_name;
    const newProductPrice = req.body.unit_price;
    const newProductSupplier = req.body.supplier_id;
   

    if (!Number.isInteger(newProductPrice) || newProductPrice <= 0) {
      return res.status(400).send('The price is a positive integer.');
    }
  
    pool.query(`SELECT * FROM suppliers AS s WHERE s.id=$1`, [newProductSupplier]).then((result) => {
      if (result.rows.length === 0) {
        return res.status(400).send('Suppliers not exists!');
      } else {
        const query = 'INSERT INTO products (product_name, unit_price, supplier_id) VALUES ($1, $2, $3) RETURNING id';
    pool
          .query(query, [newProductName, newProductPrice, newProductSupplier])
          .then((result) => res.status(201).json({ productId: result.rows[0].id }))
          .catch((e) => console.error(e));
      }
    });
  });

  //Add a new POST endpoint /customers/:customerId/orders to create a new order (including an order date, and an order reference) for a customer. Check that the customerId corresponds to an existing customer or return an error.//
  app.post("/customers/:customerId/orders", function (req, res) {
    const newOrderDate = req.body.order_date;
    const newOrderReference = req.body.order_reference;
    const newOrderCustomerId = req.params.customerId;

  pool.query(`SELECT * FROM customers AS c WHERE c.id=$1`, [newOrderCustomerId]).then((result) => {
      if (result.rows.length === 0) {
        return res.status(400).send('Customer doesn´t exists!');
      } else {
        const query = 'INSERT INTO orders (order_date, order_reference, customer_id) VALUES ($1, $2, $3) RETURNING id';
        pool
          .query(query, [newOrderDate, newOrderReference,newOrderCustomerId])
          .then((result) => res.status(201).json({ orderId: result.rows[0].id }))
          .catch((e) => console.error(e));

  }
});
});

  //Add a new PUT endpoint /customers/:customerId to update an existing customer (name, address, city and country).//
  app.put("/customers/:customerId", function (req, res) {
    const modifiedName = req.body.name;
    const modifiedAddress = req.body.address;
    const modifiedCity = req.body.city;
    const modifiedCountry = req.body. country;
    const modifiedCustomerId = req.params.customerId;


  pool.query(`UPDATE customers SET name=$1, address=$2, city=$3, country=$4 WHERE id=$5 RETURNING id`,
  [modifiedName, modifiedAddress, modifiedCity, modifiedCountry, modifiedCustomerId])
  .then((result) => res.status(201).json({ customerId: result.rows[0].id }))
  .catch((e) => console.error(e));
});

  //Add a new DELETE endpoint /orders/:orderId to delete an existing order along all the associated order items.//
  /*app.get("/orders", function (req, res) {
    pool
      .query("SELECT * FROM orders")
      .then((result) => res.json(result.rows))
      .catch((e) => console.error(e));
  });*/

  app.delete('/orders/:orderId', function(req, res) {
    const orderId = req.params.orderId;

    pool
    .query(`SELECT * FROM orders WHERE id=$1`, [orderId])
    .then(result => {
        if (result.rows.length > 0){
            const query =
            `DELETE FROM order_items where order_id = ${orderId};
            DELETE FROM orders where id = ${orderId}`;
    pool
            .query(query)
            .then(() => res.send("Order Delete!"))
            .catch((e) => console.error(e));
        }
        else{
            return res
            .status(400)
            .send("The order not exists!");
        }
    })
});
    
 

  //Add a new DELETE endpoint /customers/:customerId to delete an existing customer only if this customer doesn't have orders.//
  
  app.delete("/customers/:customerId", function (req, res) {
    const customerId = req.params.customerId;

  pool.query( `SELECT * FROM orders AS o WHERE o.customer_id=$1`, [customerId])
  .then((result) => {
    if (result.rows.length > 0) {
      return res.status(400).send('This customer has orders!');
    } else {
      pool
        .query('DELETE FROM customers WHERE id=$1', [customerId])
        .then(() => res.send(`Customer ${customerId} deleted!`))
        .catch((e) => console.error(e));
      }
    });
    });

  //Add a new GET endpoint /customers/:customerId/orders to load all the orders along the items in the orders of a specific customer. Especially, the following information should be returned: order references, order dates, product names, unit prices, suppliers and quantities.//
  
  app.get("/customers/:customerId/orders", function (req, res) {
    const customerId = req.params.customerId;

pool
    .query(
    `SELECT order_reference, order_date, product_name, unit_price, supplier_name, quantity
    FROM customers AS c
    INNER JOIN orders AS o ON c.id=o.customer_id
    INNER JOIN order_items AS i ON o.id=i.order_id
    INNER JOIN products AS p ON p.id=i.product_id
    INNER JOIN suppliers AS s ON s.id=p.supplier_id
    WHERE c.id=$1`,
      [customerId]
    )
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
  });

 
app.listen(4000, function () {
  console.log("Server is listening on port 4000. Ready to accept requests!");
});