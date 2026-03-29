import pandas as pd
import mysql.connector
import matplotlib.pyplot as plt
import seaborn as sns

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root123",
    database="ecommerce_project"
)

df = pd.read_sql("SELECT * FROM rfm_base", conn)

print(df.head())
print(df.describe())

df['R_score'] = pd.qcut(df['recency'],5, labels=[5,4,3,2,1])
df['F_score'] = pd.qcut(df['frequency'].rank(method='first'), 5, labels=[1,2,3,4,5])
df['M_score'] = pd.qcut(df['monetary'],5, labels=[1,2,3,4,5])

print(df[['R_score','F_score','M_score']].head())

df['RFM_score']= (df['R_score'].astype(str)+
                  df['F_score'].astype(str)+
                  df['M_score'].astype(str))

def segment(row):
    if row['R_score'] == 5 and row['M_score'] >= 4:
        return 'Champions'
    elif row['R_score'] >= 4 and row['M_score'] >= 3:
        return 'Loyal Customers'
    elif row['R_score'] == 5:
        return 'New Customers'
    elif row['R_score'] <= 2:
        return 'At Risk'
    else:
        return 'Others'

df['segment'] = df.apply(segment, axis=1)
print(df['segment'])

#Segment Counts
print(df['segment'].value_counts())

#Revenue Contribution
print(df.groupby('segment')['monetary'].sum().sort_values(ascending=False))

#Average frequency 
print(df.groupby('segment')['frequency'].mean())

# Plot for segmented monetary spend
df.groupby('segment')['monetary'].sum().plot(kind='bar')
plt.title("Revenue contribution by segment")
plt.ticklabel_format(style='plain', axis='y')
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("segmented_monetary_spend.png")
plt.show()

# Customer Segment Distribution
sns.countplot(data=df, x='segment')
plt.title("Customer segment distribution")
plt.xticks(rotation=30)
plt.tight_layout()
plt.savefig("customer_segment_distribution.png")
plt.show()

# Recency Vs Monetary
sns.scatterplot(data=df, x='recency', y='monetary', hue='segment')
plt.tight_layout()
plt.title("Recency Vs Monetary")
plt.savefig("recency_vs_monetary.png")
plt.show()

df.to_excel('rfm_customer_analysis.xlsx', index=False)
