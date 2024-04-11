# exer6_cmsc23

Name: Alexis Danielle G. Aguinaldo

Section: CMSC 23 UV4L

## Exercise 6

For this exercise, implement the checkout feature of the sample state
management app from the lab class.

### Functions of the Application

- My Catalog - list of items can be seen here, where in user can add items to the cart.
- My Cart - where added item is stored.
    - Has two buttons:
            
            - RESET, which only show when the cart is NOT empty.

            - CHECKOUT, which also show when the cart is NOT empty.
    - Hence, user can't reset or checkout when cart is empty.
- Checkout page - user wants to checkout their item.
    - Has 'Pay Now' button where in user can pay their bill.
    - After paying it will navigate back to My Catalog and reset the state of My Cart.

