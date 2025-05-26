# Wildlife Conservation Monitoring PostgreSQL Project

This project is built using **PostgreSQL** to manage and analyze wildlife conservation data.

## Completed Tasks:

- Problem 1–9 solved using simple, beginner-friendly and easy to understand PostgreSQL techniques.
- Bonus Section (answered 5+ conceptual questions in Bengali).
- Simple and clear logic with proper formatting.

---

---

---

# 📂 Bonus Section: (In Bengali)

## 1. What is PostgreSQL?

PostgreSQL হল একটি ফ্রি এবং ওপেন-সোর্স ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (DBMS) যা রিলেশনাল (SQL) এবং নন-রিলেশনাল (JSON) উভয় ধরণের কোয়েরি সমর্থন করে।
PostgreSQL বহুল পরিচিত এবং গুরুত্বপূর্ণ প্রোগ্রামিং ভাষাগুলো সমর্থন করে। যেমন:

- Python
- Node.js
- Java
- Go
  ইত্যাদি ।

আমরা চাইলে নিচের এই কমান্ড দিয়ে PostgreSQL-এ একটি ডেটাবেজ তৈরি করতে পারি ।

```postgreSQL
CREATE DATABASE my_awesome_db;
```

PostgreSQL ওয়েব অ্যাপ, ব্যাংকিং এবং ডেটা অ্যানালাইসিস ইত্যাদি কাজে বহুল ব্যবহৃত।

---

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

**_Primary Key_** হলো একটি কলাম বা কলামের সমষ্টি যা একটি টেবিলের প্রতিটি রেকর্ডকে স্বতন্ত্রভাবে শনাক্ত করে। এটি কখনো **NULL** হতে পারে না।

**_Foreign Key_** হলো এমন একটি কলাম যা অন্য টেবিলের **_Primary Key_** এর সাথে সম্পর্ক তৈরি করে। এটি টেবিলের মধ্যে সম্পর্ক <u>(relationship)</u> তৈরি করতে সাহায্য করে।

- উদাহরণ:

```postgreSQL
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name TEXT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_name TEXT NOT NULL
);
```

এখানে **enrollments** টেবিলের student_id হলো একটি foreign key যা **students** টেবিলের student_id কে রেফার করছে।

---

---

## 5. Explain the purpose of the WHERE clause in a SELECT statement.

PostgreSQL এ `WHERE` clause টি ব্যবহার করা হয় কোনো শর্ত দিয়ে **Data Filter** করতে। এটি শুধু সেই রেকর্ডগুলি বের করার জন্য ব্যবহৃত হয় যা একটি নির্দিষ্ট শর্ত পূরণ করে। এটি নির্ধারণ করে শুধু কোন রেকর্ডগুলো `SELECT` কমান্ডে অন্তর্ভুক্ত হবে।

- উদাহরণ:

```postgreSQL
SELECT * FROM products
WHERE product_name = 'Mechanical Keyboard';
```

এখানে শুধু সেইসব products দেখানো হবে যাদের নাম হবে ‘Mechanical Keyboard’। `WHERE` clause ছাড়া `SELECT` statement আমাদেরকে সমস্ত Products এর তথ্য দেখাবে — তাই এটি নির্দিষ্টভাবে এবং শর্তসাপেক্ষে তথ্য খোঁজার জন্য অপরিহার্য।

---

---

## 6. What are the `LIMIT` and `OFFSET` clauses used for?

**LIMIT** এবং **OFFSET** হলো PostgreSQL এর দুটি গুরুত্বপূর্ণ Clause, যা ডেটাবেজ কুয়েরিতে রেজাল্টের সংখ্যা নিয়ন্ত্রণ করতে ব্যবহৃত হয়। এদের মূল উদ্দেশ্য হলো: বড় রেজাল্টসেট থেকে নির্দিষ্ট কিছু সংখ্যক রেকর্ড বের করে আনা ।

---

**LIMIT কী?**

`LIMIT` ব্যবহার করে আমরা নির্ধারণ করতে পারি, সর্বোচ্চ কতটি রেকর্ড রেজাল্টে আসবে।

**উদাহরণ:**

```postgreSQL
SELECT * FROM species
LIMIT 3;
```

এই কুয়েরিতে `species` টেবিল থেকে শুরুর দিকের সর্বোচ্চ ৩টি রেকর্ড দেখাবে।

---

**OFFSET কী?**

`OFFSET` দিয়ে আমরা বলতে পারি, কোনো একটি কুয়েরির রিটার্ণকৃত সম্পূর্ণ রেকর্ড থেকে শুরুতে কতটি রেকর্ড **বাদ দিতে হবে** বা **স্কিপ** করতে হবে। সাধারণত এটি `LIMIT` এর সাথে এবং পেজিনেশন সিস্টেমের মাধ্যমে ধাপে ধাপে ডেটা প্রদর্শন করতে ব্যবহৃত হয়।

**উদাহরণ:**

```postgreSQL
SELECT * FROM species
OFFSET 3 LIMIT 2;
```

এই কুয়েরি প্রথমের ৩টি রেকর্ড স্কিপ করে এবং এরপরের ২টি রেকর্ড দেখাবে। অর্থাৎ ৪র্থ ও ৫ম রেকর্ড দেখাবে।

---

**বাস্তব প্রয়োগ (Pagination):**

ধরুন আমাদের একটি ডেটাবেজে ৫০টি Species বা প্রজাতির তথ্য আছে এবং আমরা চাই যে, একেক পেজে ১০টি করে Species বা প্রজাতির তথ্য দেখাতে। তাহলে আমাদের এর জন্য নিম্নোক্ত প্রক্রিয়ায় `PosgreSQL` এ কুয়েরি লিখতে হবে:

- Page 1:

```postgreSQL
SELECT * FROM species LIMIT 10 OFFSET 0;
```

- Page 2:

```postgreSQL
SELECT * FROM species LIMIT 10 OFFSET 10;
```

- Page 3:

```postgreSQL
SELECT * FROM species LIMIT 10 OFFSET 20;
```

এভাবে আমরা আমাদের অ্যাপ্লিকেশনের প্রতিটি পেইজের জন্য পর্যায়ক্রমে ডেটা আনতে পারবো এবং `Pagination` প্রক্রিয়ার মাধ্যমে তা দেখাতে পারবো ।

---

---

## 7. How can you modify data using `UPDATE` statements?

`UPDATE` স্টেটমেন্ট ব্যবহার করে ডেটাবেজের কোনো একটি নির্দিষ্ট টেবিলের এক বা একাধিক রেকর্ড আপডেট বা পরিবর্তন করা যায়।

**`UPDATE` STATEMENT এর গঠনপ্রণালী:**

```postgreSQL
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

**উদাহরণ:**

```postgreSQL
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';
```

এখানে **_১৮০০_** সালের আগে আবিষ্কৃত সব Species বা প্রজাতির status আপডেট করে **_Historic_** করবে।

---

---

## 9. Explain the `GROUP BY` clause and its role in aggregation operations.

**PostgreSQL** এ `GROUP BY` Clause ব্যবহার করে একই ধরনের ডেটা একসাথে গ্রুপ করে দেখানো যায় । `GROUP BY` Clause এর একটি অন্যতম সুবিধা হলো আমরা এক বা একাধিক কলাম দ্বারা ফলাফলসমূহকে গ্রুপ করার জন্য এটিকে প্রায়শই বিভিন্ন **Aggregate Functions** যেমন: `COUNT()`, `MAX()`, `MIN()`, `SUM()`, `AVG()` এর সাথে ব্যবহার করতে পারি।

**উদাহরণ:**

```postgreSQL
SELECT region, COUNT(*) AS total_rangers
FROM rangers
GROUP BY region;
```

**&rarr;** এই কুয়েরির মাধ্যমে প্রতিটি অঞ্চলে কতজন রেঞ্জার আছেন তা দেখা যাবে।

**`GROUP BY` Clause ব্যবহার করা ছাড়া Aggregate Function গুলো শুধুমাত্র সব ডেটার উপর কাজ করে। `GROUP BY` এর মাধ্যমে আমরা গ্রুপভিত্তিক ফলাফল পেয়ে থাকি।**
