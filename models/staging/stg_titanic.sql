SELECT
    passengerId::bigint as passenger_id,
    sex::integer,
    age::integer,
    fare::double precision,
    embarked::integer as embarked_on,
    pclass::integer as passenger_class,
    parch::integer  as parents_children,
    sibsp::integer  as siblings_spouses,
    CASE "2urvived" WHEN 1 THEN true WHEN 0 THEN false ELSE NULL END as survived
FROM
    titanic
	