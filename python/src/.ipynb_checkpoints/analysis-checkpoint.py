import pandas as pd


def calculate_total_customers(customers):
    return customers["customer_id"].nunique()


def calculate_active_customers(orders):
    return orders["customer_id"].nunique()


def calculate_total_orders(orders):
    return orders["order_id"].nunique()


def calculate_total_restaurants(restaurants):
    return restaurants["restaurant_id"].nunique()


def calculate_total_items(order_items):
    return order_items["quantity"].sum()


def calculate_total_revenue(order_items):
    return order_items["item_revenue"].sum()


def calculate_average_order_value(total_revenue, total_orders):
    if total_orders == 0:
        return 0

    return total_revenue / total_orders


def calculate_average_delivery_time(orders):
    return orders["delivery_time_minutes"].mean()


def calculate_repeat_customer_rate(orders):
    active_customers = orders["customer_id"].nunique()

    customer_order_counts = (
        orders.groupby("customer_id")
        .size()
        .reset_index(name="total_orders")
    )

    repeat_customers = customer_order_counts.loc[
        customer_order_counts["total_orders"] > 1,
        "customer_id"
    ].nunique()

    if active_customers == 0:
        return 0

    return repeat_customers / active_customers * 100


def calculate_revenue_per_active_customer(total_revenue, active_customers):
    if active_customers == 0:
        return 0

    return total_revenue / active_customers


def calculate_average_items_per_order(total_items, total_orders):
    if total_orders == 0:
        return 0

    return total_items / total_orders


def generate_kpi_summary(
    customers,
    orders,
    restaurants,
    order_items
):
    total_customers = calculate_total_customers(customers)
    active_customers = calculate_active_customers(orders)
    total_orders = calculate_total_orders(orders)
    total_restaurants = calculate_total_restaurants(restaurants)
    total_items = calculate_total_items(order_items)
    total_revenue = calculate_total_revenue(order_items)

    aov = calculate_average_order_value(
        total_revenue,
        total_orders
    )

    avg_delivery_time = calculate_average_delivery_time(orders)

    repeat_customer_rate = calculate_repeat_customer_rate(
        orders
    )

    revenue_per_active_customer = (
        calculate_revenue_per_active_customer(
            total_revenue,
            active_customers
        )
    )

    average_items_per_order = (
        calculate_average_items_per_order(
            total_items,
            total_orders
        )
    )

    return pd.DataFrame({
        "Metric": [
            "Total Revenue",
            "Total Orders",
            "Total Customers",
            "Active Customers",
            "Total Restaurants",
            "Total Items Sold",
            "Average Order Value",
            "Repeat Customer Rate",
            "Revenue per Active Customer",
            "Average Items per Order",
            "Average Delivery Time"
        ],
        "Value": [
            round(total_revenue, 2),
            total_orders,
            total_customers,
            active_customers,
            total_restaurants,
            total_items,
            round(aov, 2),
            round(repeat_customer_rate, 2),
            round(revenue_per_active_customer, 2),
            round(average_items_per_order, 2),
            round(avg_delivery_time, 2)
        ]
    })