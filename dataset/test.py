import pandas as pd

df = pd.read_csv('orders.csv')
#replacing the old date year
df['order_date'] = df['order_date'].str.replace('2015', '2026')

df.to_csv('orders_2026.csv', index=False)

print("done year updation")
#delete the orders.csv then




df = pd.read_csv('pizzas.csv')
df['price'] = df['price'] - 10  # Normalizing prices for Indian market by subtracting  by 10
df['price'] = df['price'] * 91  # Adjusting prices for inflation by multiplying by INR USD exchange rate
df['price'] = df['price'].round(2) # upto two decimal places
df.to_csv('pizzas_2026.csv', index=False)
print("done price updation")
#delete the pizzas.csv then